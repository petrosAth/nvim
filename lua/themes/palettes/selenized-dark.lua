local u = require("themes.utilities")
local M = {}

vim.o.background = "dark"
vim.o.termguicolors = true

-- Original palette
-- This code was [copied/inspired/adapted] from:
-- https://github.com/jan-warchol/selenized
local p = {
    dark1   = "#103c48",
    dark2   = "#184956",
    dark3   = "#2d5b69",
    light0  = "#72898f",
    light1  = "#adbcbc",
    light2  = "#cad8d9",
    red     = "#fa5750",
    orange  = "#ed8649",
    yellow  = "#dbb32d",
    green   = "#75b938",
    cyan    = "#41c7b9",
    blue    = "#4695f7",
    violet  = "#af88eb",
    magenta = "#f275be",
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
    base_4    = u.blend(p.light0, bg, 0.6),
    base_04   = u.blend(p.light0, bg, 0.95),
    base_03   = u.blend(p.light0, fg, 0.6),
    base_02   = p.light1,
    base_01   = p.light2,
    base_00   = u.adjustHSL(fg, 0, 0, 10),
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
    grayDark     = M.base.base_3,
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
    grayLight    = M.base.base_00,
}

return M
