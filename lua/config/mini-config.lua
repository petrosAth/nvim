local M = {}

function M.setup()
    local loaded, animate = pcall(require, "mini.animate")
    if not loaded then
        USER.loading_error_msg("mini.animate")
        return
    end

    animate.setup({
        -- Cursor path
        cursor = {
            -- Whether to enable this animation
            enable = true,

            -- Timing of animation (how steps will progress in time)
            timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
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
end

return M
