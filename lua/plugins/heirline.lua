local function setup(heirline)
    local status_line = require("ui.status-bars.status-line").StatusLines
    local win_bar = require("ui.status-bars.win-bar").WinBars
    local opts = {
        -- if the callback returns true, the winbar will be disabled for that window
        -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
        disable_winbar_cb = function(args)
            local buf = args.buf
            local table = require("ui.status-bars.tables").Disable.winBar
            local buftype = vim.tbl_contains(table.buftype, vim.bo[buf].buftype)
            local filetype = vim.tbl_contains(table.filetype, vim.bo[buf].filetype)

            return buftype or filetype
        end,
    }

    heirline.setup({
        statusline = status_line,
        winbar = win_bar,
        opts = opts,
    })
end

return {
    {
        -- heirline.nvim
        -- Heirline.nvim is a no-nonsense Neovim Statusline/Winbar/Tabline plugin designed around recursive inheritance
        -- to be exceptionally fast and versatile.
        "rebelot/heirline.nvim",
        dependencies = {
            -- Hydra.nvim
            -- This is the Neovim implementation of the famous Emacs Hydra package.
            "anuvyklack/hydra.nvim",
            -- Nvim-web-devicons
            -- A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.
            "nvim-tree/nvim-web-devicons",
            -- nvim-lspconfig
            -- Configs for the Nvim LSP client (:help lsp).
            "neovim/nvim-lspconfig",
            -- gitsigns.nvim
            -- Super fast git decorations implemented purely in lua/teal.
            "lewis6991/gitsigns.nvim",
        },
        config = function()
            local loaded, heirline = pcall(require, "heirline")
            if not loaded then
                USER.loading_error_msg("heirline.nvim")
                return
            end

            setup(heirline)
        end,
    },
}
