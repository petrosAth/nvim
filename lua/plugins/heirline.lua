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
            -- lspsaga.nvim
            -- A lightweight LSP plugin based on Neovim's built-in LSP with a highly performant UI.
            "glepnir/lspsaga.nvim",
        },
        config = function()
            local loaded, heirline = pcall(require, "heirline")
            if not loaded then
                USER.loading_error_msg("heirline.nvim")
                return
            end

            local status_line = require("ui.status-bars.status-line").StatusLines
            local win_bar = require("ui.status-bars.win-bar").WinBars
            heirline.setup({
                statusline = status_line,
                winbar = win_bar,
            })
        end,
    },
}
