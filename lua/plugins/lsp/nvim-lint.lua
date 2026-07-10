local M = {}

-- Filetype → linters. Mirrors the diagnostics sources previously registered
-- via none-ls. All names are nvim-lint builtins (the `zsh` linter runs
-- `zsh -n` via the system shell — no mason package, see install.lua).
local linters_by_ft = {
    php = { "phpcs", "phpstan" },
    lua = { "selene" },
    zsh = { "zsh" },
}

-- Linters slow enough (full static analysis, not a quick syntax pass) that
-- running them on every InsertLeave/BufReadPost would be disruptive; these
-- only run on save. They also get a progress toast (see start_progress /
-- wrap_linter_progress below), since a run can take several seconds and
-- otherwise gives no feedback that it's happening.
local save_only_linters = {
    phpstan = true,
}

-- PHPStan already auto-discovers phpstan.neon / phpstan.neon.dist /
-- phpstan.dist.neon in cwd on its own when no -c is passed, so only a
-- non-standard, CI-specific config name needs pointing at explicitly here
-- -- checked first so that, if a project keeps one, editor diagnostics agree
-- with CI.
local function find_ci_phpstan_config(cwd)
    local path = cwd .. "/phpstan.ci.neon"
    if vim.uv.fs_stat(path) then return path end
    return nil
end

-- Override the stock linter (low default memory limit) with a function so
-- cwd/config-file are resolved fresh on every run, not once at startup. The
-- stock definition's vendor/bin-aware `cmd` is kept as-is.
local function phpstan_linter()
    local stock = require("lint.linters.phpstan")
    local cwd = vim.fn.getcwd()
    local args = { "analyze", "--error-format=json", "--no-progress", "--memory-limit=1G" }
    local ci_config = find_ci_phpstan_config(cwd)
    if ci_config then vim.list_extend(args, { "-c", ci_config }) end
    return vim.tbl_deep_extend("force", stock, { args = args })
end

local function linters_for(ft, save)
    local names = linters_by_ft[ft] or {}
    if save then return names end
    return vim.tbl_filter(function(name) return not save_only_linters[name] end, names)
end

-- Save-only linters (see save_only_linters above) give no interim progress
-- like LSP's $/progress, so the only "it's still going" signal is a
-- repeating timer that keeps re-notifying the same toast id until the
-- linter's parser fires. Keyed by linter name so multiple save-only linters
-- get independent toasts.
local progress_timers = {}

local function notify_progress(name, done)
    local icons = USER.styling.icons
    local spinner = icons.loading.sphere
    vim.notify(done and "Done" or "Linting…", vim.log.levels.INFO, {
        id = "lint_progress_" .. name,
        title = name,
        opts = function(notif)
            notif.icon = done and icons.lsp.loaded[1]
                ---@diagnostic disable-next-line: undefined-field
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
    })
end

-- Stops any timer already running for `name` before starting a fresh one --
-- covers the double-save case, where nvim-lint cancels the previous process
-- for the same linter name but its parser never fires (a cancelled process's
-- stdout closes with no buffered output), which would otherwise leak the old
-- timer.
local function start_progress(name)
    local existing = progress_timers[name]
    if existing then
        existing:stop()
        existing:close()
    end

    local timer = vim.uv.new_timer()
    progress_timers[name] = timer
    timer:start(0, 80, vim.schedule_wrap(function() notify_progress(name, false) end))
end

local function finish_progress(name)
    local timer = progress_timers[name]
    if not timer then return end
    timer:stop()
    timer:close()
    progress_timers[name] = nil
    notify_progress(name, true)
end

-- Generic try_lint wrap_linter: for any save-only linter with a
-- plain-function parser, finalizes its toast right when nvim-lint calls the
-- parser -- which only happens once, when the process's stdout closes (i.e.
-- once it has finished). No-op for every other linter.
local function wrap_linter_progress(linter)
    if not save_only_linters[linter.name] or type(linter.parser) ~= "function" then return linter end

    local parse = linter.parser
    linter.parser = function(output, bufnr)
        local ok, result = pcall(parse, output, bufnr)
        finish_progress(linter.name)
        if not ok then error(result, 0) end
        return result
    end
    return linter
end

function M.setup()
    local loaded, lint = pcall(require, "lint")
    if not loaded then
        USER.loading_error_msg("nvim-lint")
        return
    end

    lint.linters_by_ft = linters_by_ft
    lint.linters.phpstan = phpstan_linter

    -- none-ls re-linted continuously; nvim-lint is explicit, so trigger it on
    -- the events where diagnostics should refresh. Save-only linters (see
    -- save_only_linters above) are excluded from the more frequent events.
    local group = vim.api.nvim_create_augroup("NvimLint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufReadPost", "InsertLeave" }, {
        group = group,
        callback = function() lint.try_lint(linters_for(vim.bo.filetype, false)) end,
    })
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        callback = function()
            local names = linters_for(vim.bo.filetype, true)
            for _, name in ipairs(names) do
                if save_only_linters[name] then start_progress(name) end
            end
            lint.try_lint(names, { wrap_linter = wrap_linter_progress })
        end,
    })
end

return M
