local M = {}

local mouse_scrolled = false
for _, scroll in ipairs({ "Up", "Down" }) do
    local key = "<ScrollWheel" .. scroll .. ">"
    vim.keymap.set("", key, function()
        mouse_scrolled = true
        return key
    end, { noremap = true, expr = true })
end

local function setup(animate)
    animate.setup({
        -- Cursor path
        cursor = {
            enable = false,
            timing = animate.gen_timing.exponential({ easing = "out", duration = 300, unit = "total" }),
            path = animate.gen_path.line(),
        },
        -- Vertical scroll
        scroll = {
            enable = true,
            timing = animate.gen_timing.quadratic({ easing = "out", duration = 150, unit = "total" }),
            subscroll = animate.gen_subscroll.equal({
                predicate = function(total_scroll)
                    if mouse_scrolled then
                        mouse_scrolled = false
                        return false
                    end
                    return total_scroll > 1
                end,
            }),
        },
        -- Window resize
        resize = {
            enable = false, -- NOTE: enable when mini.animate becomes compatible with hydra.nvim
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
end

function M.load()
    local loaded, animate = pcall(require, "mini.animate")
    if not loaded then
        USER.loading_error_msg("mini.animate")
        return
    end

    setup(animate)
end

return M
