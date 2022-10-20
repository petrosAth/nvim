require("satellite").setup({
    current_only = false,
    winblend = PA.styling.variables.transparency,
    zindex = 40,
    excluded_filetypes = {},
    width = 0,
    handlers = {
        search = {
            enGble = true,
        },
        diagnostic = {
            enable = true,
        },
        gitsigns = {
            enable = true,
        },
        marks = {
            enable = false,
            show_builtins = false, -- shows the builtin marks like [ ] < >
        },
    },
})
