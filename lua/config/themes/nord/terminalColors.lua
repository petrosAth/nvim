local p = require("config.themes.nord.palette")
local terminalColors = {}

function terminalColors.load()
    vim.g.terminal_color_0  = p.nord1
    vim.g.terminal_color_8  = p.nord3

    vim.g.terminal_color_7  = p.nord5
    vim.g.terminal_color_15 = p.nord6

    vim.g.terminal_color_1  = p.nord11
    vim.g.terminal_color_9  = p.nord11

    vim.g.terminal_color_2  = p.nord14
    vim.g.terminal_color_10 = p.nord14

    vim.g.terminal_color_3  = p.nord13
    vim.g.terminal_color_11 = p.nord13

    vim.g.terminal_color_4  = p.nord9
    vim.g.terminal_color_12 = p.nord9

    vim.g.terminal_color_5  = p.nord15
    vim.g.terminal_color_13 = p.nord15

    vim.g.terminal_color_6  = p.nord8
    vim.g.terminal_color_14 = p.nord7
end

return terminalColors
