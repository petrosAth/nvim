return {
    {
        -- mini.animate
        -- Neovim Lua plugin to animate common Neovim actions. Part of 'mini.nvim' library.
        "echasnovski/mini.animate",
        enabled = false,
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
                    timing = animate.gen_timing.exponential({ easing = "out", duration = 600, unit = "total" }),
                    path = animate.gen_path.line(),
                },
                -- Vertical scroll
                scroll = {
                    enable = true,
                    timing = animate.gen_timing.quadratic({ easing = "out", duration = 300, unit = "total" }),
                    subscroll = animate.gen_subscroll.equal({ max_output_steps = 60 }),
                },
                -- Window resize
                resize = {
                    enable = true,
                    timing = animate.gen_timing.exponential({ easing = "out", duration = 150, unit = "total" }),
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
