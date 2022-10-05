local p = require("config.themes.nord.palette")
local M = {}

function M.load()
    vim.g.terminal_color_0  = p.fill1
    vim.g.terminal_color_8  = p.fill4

    vim.g.terminal_color_7  = p.fg
    vim.g.terminal_color_15 = p.fgLight

    vim.g.terminal_color_1  = p.red
    vim.g.terminal_color_9  = p.redDim

    vim.g.terminal_color_2  = p.green
    vim.g.terminal_color_10 = p.greenDim

    vim.g.terminal_color_3  = p.yellow
    vim.g.terminal_color_11 = p.yellowDim

    vim.g.terminal_color_4  = p.blue
    vim.g.terminal_color_12 = p.select

    vim.g.terminal_color_5  = p.nord15
    vim.g.terminal_color_13 = p.nord15

    vim.g.terminal_color_6  = p.nord8
    vim.g.terminal_color_14 = p.nord7
end

return M
