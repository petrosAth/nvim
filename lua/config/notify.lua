local notify = require("notify")
local i = require("styling").icon
local b = require("styling").border.default

notify.setup({
    -- Animation style (see below for details)
    stages = "slide",

    -- Function called when a new window is opened, use for changing win settings/config
    on_open = function (win)
        vim.api.nvim_win_set_config(win, { border = {
                { b.tl, "FloatBorder" },
                { b.t,  "FloatBorder" },
                { b.tr, "FloatBorder" },
                { b.r,  "FloatBorder" },
                { b.br, "FloatBorder" },
                { b.b,  "FloatBorder" },
                { b.bl, "FloatBorder" },
                { b.l,  "FloatBorder" },
            }
        })
    end,

    -- Function called when a window is closed
    on_close = nil,

    -- Render function for notifications. See notify-render()
    render = "default",

    -- Default timeout for notifications
    timeout = 5000,

    -- For stages that change opacity this is treated as the highlight behind the window
    -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
    background_colour = "Normal",

    -- Minimum width for notification windows
    minimum_width = 50,

    -- Icons for the different levels
    icons = {
        ERROR = i.error[1],
        WARN  = i.warn[1],
        INFO  = i.info[1],
        DEBUG = i.bug[1],
        TRACE = i.location[1]
    }
})

vim.notify = notify
