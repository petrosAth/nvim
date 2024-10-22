local function setup(heirline)
    local status_line = require("plugins.heirline.status-line").StatusLines
    local win_bar = require("plugins.heirline.winbar").WinBars
    local opts = {
        -- if the callback returns true, the winbar will be disabled for that window
        -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
        disable_winbar_cb = function(args)
            local buf = args.buf
            local fileName = vim.api.nvim_buf_get_name(0)
            local fullPath = vim.fn.fnamemodify(fileName, ":p")
            local buf_label = require("ui.utilities").get_buf_label(fullPath, vim.bo.buftype, vim.bo.filetype)
            local table = require("plugins.heirline.tables").Disable.winBar
            local buftype = vim.tbl_contains(table.buftype, vim.bo[buf].buftype)
            local filetype = vim.tbl_contains(table.filetype, vim.bo[buf].filetype)

            return (buftype and (buf_label == "" or buf_label == nil)) or filetype
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
            -- This is the Neovim implementation of the famous Emacs Hydra package.
            "anuvyklack/hydra.nvim",
            -- A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.
            "nvim-tree/nvim-web-devicons",
            -- Configs for the Nvim LSP client (:help lsp).
            "neovim/nvim-lspconfig",
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
