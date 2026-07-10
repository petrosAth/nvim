local M = {}

-- Filetype → linters. Mirrors the diagnostics sources previously registered
-- via none-ls. All names are nvim-lint builtins (the `zsh` linter runs
-- `zsh -n` via the system shell — no mason package, see install.lua).
local linters_by_ft = {
    php = { "phpcs", "phpstan" },
    lua = { "selene" },
    zsh = { "zsh" },
}

function M.setup()
    local loaded, lint = pcall(require, "lint")
    if not loaded then
        USER.loading_error_msg("nvim-lint")
        return
    end

    lint.linters_by_ft = linters_by_ft

    -- none-ls re-linted continuously; nvim-lint is explicit, so trigger it on
    -- the events where diagnostics should refresh.
    local group = vim.api.nvim_create_augroup("NvimLint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = group,
        callback = function() lint.try_lint() end,
    })
end

return M
