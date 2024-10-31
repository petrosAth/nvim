local M = {}

local timing = function(animate)
    return animate.gen_timing.linear({ duration = 50, unit = "total" })
end

local function setup(animate)
    local mouse_scrolled = false
    for _, scroll in ipairs({ "Up", "Down" }) do
        local key = string.format("<ScrollWheel%s>", scroll)
        vim.keymap.set("", key, function()
            mouse_scrolled = true
            return key
        end, { noremap = true, expr = true })
    end

    animate.setup({
        -- Cursor path
        cursor = {
            enable = true,
            timing = timing(animate),
            path = animate.gen_path.line(),
        },
        -- Vertical scroll
        scroll = {
            enable = true,
            timing = timing(animate),
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
            timing = timing(animate),
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
