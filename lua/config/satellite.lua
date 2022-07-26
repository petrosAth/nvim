local t = require("styling").variables.transparency
local i = require("styling").icons
local b = require("styling").borders.default

require("satellite").setup({
    current_only = false,
    winblend = t,
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
