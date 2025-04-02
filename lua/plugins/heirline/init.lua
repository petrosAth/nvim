local function setup(heirline)
    local opts = {
        -- if the callback returns true, the winbar will be disabled for that window
        -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
        disable_winbar_cb = function(args)
            local file_name = vim.api.nvim_buf_get_name(args.buf)
            local full_path = vim.fn.fnamemodify(file_name, ":p")
            local buf_label = require("ui.utilities").get_buf_label(full_path, vim.bo.buftype, vim.bo.filetype)
            local props = require("plugins.heirline.properties").Disable.winBar
            local buftype = vim.tbl_contains(props.buftype, vim.bo[args.buf].buftype)
            local filetype = vim.tbl_contains(props.filetype, vim.bo[args.buf].filetype)

            return (buftype and (buf_label == "" or buf_label == nil)) or filetype
        end,
    }

    heirline.setup({
        statusline = require("plugins.heirline.status-line"),
        winbar = require("plugins.heirline.winbar"),
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
