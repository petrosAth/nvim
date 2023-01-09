return {
    {
        "echasnovski/mini.animate",
        config = function()
            local loaded, animate = pcall(require, "mini.animate")
            if not loaded then
                USER.loading_error_msg("mini.animate")
                return
            end

            animate.setup({
                -- Cursor path
                cursor = {
                    enable = false,
                },
                -- Vertical scroll
                scroll = {
                    enable = true,
                    timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
                },
                -- Window resize
                resize = {
                    enable = true,
                    timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
                },
                -- Window open
                open = {
                    enable = false,
                },
                -- Window close
                close = {
                    enable = false,
                },
            })
        end,
    },
}
