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
-- only run on save.
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
        callback = function() lint.try_lint(linters_for(vim.bo.filetype, true)) end,
    })
end

return M
