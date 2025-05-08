local u = require("themes.utilities")
local M = {}

vim.o.background = "dark"
vim.o.termguicolors = true

-- Original palette
-- This code was [copied/inspired/adapted] from:
-- https://www.nordtheme.com/docs/colors-and-palettes
local p = {
    dark1   = "#2e3440",
    dark2   = "#3b4252",
    dark3   = "#434c5e",
    dark4   = "#4c566a",
    light2  = "#d8dee9",
    light3  = "#e5e9f0",
    light4  = "#eceff4",
    red     = "#bf616a",
    orange  = "#d08770",
    yellow  = "#ebcb8b",
    green   = "#a3be8c",
    cyan    = "#88c0d0",
    blue0   = "#81a1c1",
    blue1   = "#5e81ac",
    violet  = "#8fbcbb",
    magenta = "#b48ead",
}

local bg = p.dark1
local fg = p.light2

M.base = {
    base_fg   = fg,
    base_bg   = USER.transparent_bg and "NONE" or bg,
    base_0    = u.adjustHSL(bg, 0, 0, -2),
    base_1    = p.dark1,
    base_2    = p.dark2,
    base_3    = p.dark3,
    base_4    = p.dark4,
    base_04   = u.blend(p.dark4, fg, 0.8),
    base_03   = u.blend(p.dark4, fg, 0.4),
    base_02   = p.light2,
    base_01   = p.light3,
    base_00   = p.light4,
    red_0     = u.blend(p.red, bg, 0.15),
    red_1     = u.blend(p.red, bg, 0.5),
    red_2     = p.red,
    red_3     = u.blend(p.red, fg, 0.6),
    red_4     = u.blend(p.red, fg, 0.2),
    orange_0  = u.blend(p.orange, bg, 0.15),
    orange_1  = u.blend(p.orange, bg, 0.5),
    orange_2  = p.orange,
    orange_3  = u.blend(p.orange, fg, 0.6),
    orange_4  = u.blend(p.orange, fg, 0.2),
    yellow_0  = u.blend(p.yellow, bg, 0.15),
    yellow_1  = u.blend(p.yellow, bg, 0.5),
    yellow_2  = p.yellow,
    yellow_3  = u.blend(p.yellow, fg, 0.6),
    yellow_4  = u.blend(p.yellow, fg, 0.2),
    green_0   = u.blend(p.green, bg, 0.15),
    green_1   = u.blend(p.green, bg, 0.5),
    green_2   = p.green,
    green_3   = u.blend(p.green, fg, 0.6),
    green_4   = u.blend(p.green, fg, 0.2),
    cyan_0    = u.blend(p.cyan, bg, 0.15),
    cyan_1    = u.blend(p.cyan, bg, 0.5),
    cyan_2    = p.cyan,
    cyan_3    = u.blend(p.cyan, fg, 0.6),
    cyan_4    = u.blend(p.cyan, fg, 0.2),
    blue_0    = u.blend(p.blue1, bg, 0.15),
    blue_1    = u.blend(p.blue1, bg, 0.5),
    blue_2    = p.blue1,
    blue_3    = p.blue0,
    blue_4    = u.blend(p.blue1, fg, 0.2),
    violet_0  = u.blend(p.violet, bg, 0.15),
    violet_1  = u.blend(p.violet, bg, 0.5),
    violet_2  = p.violet,
    violet_3  = u.blend(p.violet, fg, 0.6),
    violet_4  = u.blend(p.violet, fg, 0.2),
    magenta_0 = u.blend(p.magenta, bg, 0.15),
    magenta_1 = u.blend(p.magenta, bg, 0.5),
    magenta_2 = p.magenta,
    magenta_3 = u.blend(p.magenta, fg, 0.6),
    magenta_4 = u.blend(p.magenta, fg, 0.2),
}

M.terminal = {
    black        = M.base.base_1,
    blackLight   = M.base.base_04,
    red          = M.base.red_2,
    redLight     = M.base.red_3,
    green        = M.base.green_2,
    greenLight   = M.base.green_3,
    yellow       = M.base.yellow_2,
    yellowLight  = M.base.yellow_3,
    blue         = M.base.blue_2,
    blueLight    = M.base.blue_3,
    magenta      = M.base.magenta_2,
    magentaLight = M.base.magenta_3,
    cyan         = M.base.cyan_2,
    cyanLight    = M.base.violet_2,
    white        = M.base.base_02,
    whiteLight   = M.base.base_00,
}

return M
