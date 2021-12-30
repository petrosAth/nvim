local notify = require("notify")
local ci = require("cosmetics").icon

notify.setup({
    -- Animation style (see below for details)
    stages = "fade_in_slide_out",

    -- Function called when a new window is opened, use for changing win settings/config
    on_open = nil,

    -- Function called when a window is closed
    on_close = nil,

    -- Render function for notifications. See notify-render()
    render = "default",

    -- Default timeout for notifications
    timeout = 5000,

    -- For stages that change opacity this is treated as the highlight behind the window
    -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
    background_colour = "#000000",

    -- Minimum width for notification windows
    minimum_width = 50,

    -- Icons for the different levels
    icons = {
        ERROR = ci.error[1],
        WARN  = ci.warn[1],
        INFO  = ci.info[1],
        DEBUG = ci.bug[1],
        TRACE = ci.location[1]
    }
})

vim.notify = require("notify")
