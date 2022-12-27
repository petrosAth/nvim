local animate = require("mini.animate")

animate.setup({
    -- Cursor path
    cursor = {
        -- Whether to enable this animation
        enable = true,

        -- Timing of animation (how steps will progress in time)
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),

        -- Path generator for visualized cursor movement
        path = animate.gen_path.line({
            predicate = function()
                return true
            end,
        }),
    },
    -- Vertical scroll
    scroll = {
        -- Whether to enable this animation
        enable = true,

        -- Timing of animation (how steps will progress in time)
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
    },
    -- Window resize
    resize = {
        -- Whether to enable this animation
        enable = true,

        -- Timing of animation (how steps will progress in time)
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
    },
    -- Window open
    open = {
        -- Whether to enable this animation
        enable = false,
    },
    -- Window close
    close = {
        -- Whether to enable this animation
        enable = false,
    },
})
