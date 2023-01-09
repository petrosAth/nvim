local u = require("themes.utilities")
local M = {}

vim.o.background = "dark"
vim.o.termguicolors = true

-- Original palette
local p = {
    nord0  = "#2e3440",
    nord1  = "#3b4252",
    nord2  = "#434c5e",
    nord3  = "#4c566a",
    nord4  = "#d8dee9",
    nord5  = "#e5e9f0",
    nord6  = "#eceff4",
    nord7  = "#8fbcbb",
    nord8  = "#88c0d0",
    nord9  = "#81a1c1",
    nord10 = "#5e81ac",
    nord11 = "#bf616a",
    nord12 = "#d08770",
    nord13 = "#ebcb8b",
    nord14 = "#a3be8c",
    nord15 = "#b48ead",
}

M.base = {
    cBgDark      = u.adjustHSL(p.nord0, 0, 0, -5),
    cBgDim       = u.adjustHSL(p.nord0, 0, 0, -2),
    cBg          = p.nord0,

    cFgDim       = u.adjustHSL(p.nord3, 0, 0, 25),
    cFg          = p.nord4,
    cFgLight     = p.nord6,

    cSelect      = p.nord10,

    cFill1       = u.adjustHSL(p.nord1, 0, 0, -3),
    cFill2       = p.nord1,
    cFill3       = p.nord2,
    cFill4       = p.nord3,
    cFill5       = u.adjustHSL(p.nord3, 0, 0, 10),

    cYellowDark = u.blend(p.nord13, p.nord0, 0.1),
    cYellowDim  = u.blend(p.nord13, p.nord0, 0.2),
    cYellow     = p.nord13,
    cOrange     = p.nord12,
    cRedDark    = u.blend(p.nord11, p.nord0, 0.1),
    cRedDim     = u.blend(p.nord11, p.nord0, 0.2),
    cRed        = p.nord11,
    cMagenta    = p.nord15,
    cViolet     = p.nord7,
    cBlue       = p.nord9,
    cCyan       = p.nord8,
    cGreenDark  = u.blend(p.nord14, p.nord0, 0.1),
    cGreenDim   = u.blend(p.nord14, p.nord0, 0.2),
    cGreen      = p.nord14,
}

M.terminal = {
    black        = p.nord1,
    grayDark     = p.nord3,
    red          = p.nord11,
    redLight     = p.nord11,
    green        = p.nord14,
    greenLight   = p.nord14,
    yellow       = p.nord13,
    yellowLight  = p.nord13,
    blue         = p.nord9,
    blueLight    = p.nord9,
    magenta      = p.nord15,
    magentaLight = p.nord15,
    cyan         = p.nord8,
    cyanLight    = p.nord7,
    white        = p.nord5,
    grayLight    = p.nord6,
}

return M
