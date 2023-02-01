local M = {}

function M.setup(icons)
    local loaded, lspsaga = pcall(require, "lspsaga")
    if not loaded then
        USER.loading_error_msg("lspsaga.nvim")
        return
    end

    lspsaga.setup({
        ui = {
            -- Currently, only the round theme exists
            theme = "round",
            -- This option only works in Neovim 0.9
            title = true,
            -- Border type can be single, double, rounded, solid, shadow.
            border = "solid",
            winblend = 0,
            expand = "",
            collapse = "",
            preview = " ",
            code_action = "💡",
            diagnostic = "🐞",
            incoming = " ",
            outgoing = " ",
            hover = " ",
            kind = {},
        },
        symbol_in_winbar = {
            enable = false,
            separator = " ",
            hide_keyword = true,
            show_file = true,
            folder_level = 2,
            respect_root = false,
            color_mode = true,
        },
    })
end

return M
