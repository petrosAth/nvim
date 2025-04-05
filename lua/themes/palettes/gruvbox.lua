local u = require("themes.utilities")
local M = {}

vim.o.background = "dark"
vim.o.termguicolors = true

-- Original palette
-- This code was [copied/inspired/adapted] from:
-- https://github.com/morhetz/gruvbox
local p = {
    dark0   = "#1d2021",
    dark1   = "#282828",
    dark2   = "#32302f",
    dark3   = "#3c3836",
    dark4   = "#504945",
    light0  = "#a89984",
    light1  = "#bdae93",
    light2  = "#ebdbb2",
    light3  = "#fbf1c7",
    light4  = "#f9f5d7",
    red     = "#cc241d",
    orange  = "#d65d0e",
    yellow  = "#d79921",
    green   = "#98971a",
    cyan    = "#689d6a",
    blue    = "#458588",
    violet  = "#6662b2",
    magenta = "#b16286",
}

local bg = p.dark1
local fg = p.light2

M.base = {
    base_fg   = fg,
    base_bg   = USER.transparent_bg and "NONE" or bg,
    base_0    = p.dark0,
    base_1    = p.dark1,
    base_2    = p.dark2,
    base_3    = p.dark3,
    base_4    = p.dark4,
    base_04   = p.light0,
    base_03   = p.light1,
    base_02   = p.light2,
    base_01   = p.light3,
    base_00   = p.light4,
    red_0     = u.blend(p.red, bg, 0.15),
    red_1     = u.blend(p.red, bg, 0.5),
    red_2     = p.red,
    red_3     = u.blend(p.red, fg, 0.5),
    red_4     = u.blend(p.red, fg, 0.2),
    orange_0  = u.blend(p.orange, bg, 0.15),
    orange_1  = u.blend(p.orange, bg, 0.5),
    orange_2  = p.orange,
    orange_3  = u.blend(p.orange, fg, 0.5),
    orange_4  = u.blend(p.orange, fg, 0.2),
    yellow_0  = u.blend(p.yellow, bg, 0.15),
    yellow_1  = u.blend(p.yellow, bg, 0.5),
    yellow_2  = p.yellow,
    yellow_3  = u.blend(p.yellow, fg, 0.5),
    yellow_4  = u.blend(p.yellow, fg, 0.2),
    green_0   = u.blend(p.green, bg, 0.15),
    green_1   = u.blend(p.green, bg, 0.5),
    green_2   = p.green,
    green_3   = u.blend(p.green, fg, 0.5),
    green_4   = u.blend(p.green, fg, 0.2),
    cyan_0    = u.blend(p.cyan, bg, 0.15),
    cyan_1    = u.blend(p.cyan, bg, 0.5),
    cyan_2    = p.cyan,
    cyan_3    = u.blend(p.cyan, fg, 0.5),
    cyan_4    = u.blend(p.cyan, fg, 0.2),
    blue_0    = u.blend(p.blue, bg, 0.15),
    blue_1    = u.blend(p.blue, bg, 0.5),
    blue_2    = p.blue,
    blue_3    = u.blend(p.blue, fg, 0.5),
    blue_4    = u.blend(p.blue, fg, 0.2),
    violet_0  = u.blend(p.violet, bg, 0.15),
    violet_1  = u.blend(p.violet, bg, 0.5),
    violet_2  = p.violet,
    violet_3  = u.blend(p.violet, fg, 0.5),
    violet_4  = u.blend(p.violet, fg, 0.2),
    magenta_0 = u.blend(p.magenta, bg, 0.15),
    magenta_1 = u.blend(p.magenta, bg, 0.5),
    magenta_2 = p.magenta,
    magenta_3 = u.blend(p.magenta, fg, 0.5),
    magenta_4 = u.blend(p.magenta, fg, 0.2),
}

M.terminal = {
    black        = M.base.base_1,
    blackLight   = M.base.base_3,
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
    cyanLight    = M.base.cyan_3,
    white        = M.base.base_02,
    whiteLight   = M.base.base_00,
}

return M
