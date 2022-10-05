local M = {}

---Set terminal colors based on the given palette
---@param palette table The values must be a color name or hexadecimal string
function M.load(palette)
    local p = palette

    vim.g.terminal_color_0  = p.black        -- black
    vim.g.terminal_color_8  = p.grayDark     -- gray dark

    vim.g.terminal_color_1  = p.red          -- red
    vim.g.terminal_color_9  = p.redLight     -- red bright

    vim.g.terminal_color_2  = p.green        -- green
    vim.g.terminal_color_10 = p.greenLight   -- green bright

    vim.g.terminal_color_3  = p.yellow       -- yellow
    vim.g.terminal_color_11 = p.yellowLight  -- yellow bright

    vim.g.terminal_color_4  = p.blue         -- blue
    vim.g.terminal_color_12 = p.blueLight    -- blue bright

    vim.g.terminal_color_5  = p.magenta      -- magenta
    vim.g.terminal_color_13 = p.magentaLight -- magenta bright

    vim.g.terminal_color_6  = p.cyan         -- cyan
    vim.g.terminal_color_14 = p.cyanLight    -- cyan bright

    vim.g.terminal_color_7  = p.white        -- white
    vim.g.terminal_color_15 = p.grayLight    -- gray bright
end

return M
