require("satellite").setup({
    current_only = true,
    winblend = USER.styling.variables.transparency,
    zindex = 40,
    handlers = {
        marks = {
            enable = false,
        },
    },
})
