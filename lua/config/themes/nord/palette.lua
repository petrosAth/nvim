local u = require("config.themes.utilities")
vim.o.background = "dark"

local M = {}

-- Original palette
M.p = {
    nord0darker  = "#242a35",
    nord0dark    = "#2a303c",
    nord0        = "#2e3440",

    nord1dark    = "#343b49",
                -- "#333947"  -- 24
    nord1        = "#3b4252", -- 28
    nord2        = "#434c5e",
    nord3        = "#4c566a", -- 35,7
    nord3light   = "#616e88", -- 45,7
    nord4dark    = "#8e97a9",
    -- nord4dark    = "#8a95ab", -- 60,7
    nord4        = "#d8dee9",
    nord5        = "#e5e9f0",
    nord6        = "#eceff4",

    nord7        = "#8fbcbb",
    nord8        = "#88c0d0",
    nord9        = "#81a1c1",
    nord10       = "#5e81ac",
    nord11darker = "#443844",
    nord11dark   = "#543d48",
    nord11       = "#bf616a",
    nord12       = "#d08770",
    nord13darker = "#4d4a48",
    nord13dark   = "#635b4f",
    nord13       = "#ebcb8b",
    nord14darker = "#3e4748",
    nord14dark   = "#4b564f",
    nord14       = "#a3be8c",
    nord15       = "#b48ead",
    none         = "none",
}

M.pCurated = {
    bgDark     = u.adjustHSL(M.p.nord0, 0, 0, -5),
    bgDim      = u.adjustHSL(M.p.nord0, 0, 0, -2),
    bg         = M.p.nord0,

    fill1      = u.adjustHSL(M.p.nord1, 0, 0, -3),
    fill2      = M.p.nord1,
    fill3      = M.p.nord2,
    fill4      = M.p.nord3,
    fill5      = u.adjustHSL(M.p.nord3, 0, 0, 10),

    fgDim      = u.adjustHSL(M.p.nord3, 0, 0, 25),
    fg         = M.p.nord4,
    fgLight    = M.p.nord6,

    select     = M.p.nord10,

    yellowDark = u.blend(M.p.nord13, M.p.nord0, 0.1),
    yellowDim  = u.blend(M.p.nord13, M.p.nord0, 0.2),
    yellow     = M.p.nord13,
    orange     = M.p.nord12,
    redDark    = u.blend(M.p.nord11, M.p.nord0, 0.1),
    redDim     = u.blend(M.p.nord11, M.p.nord0, 0.2),
    red        = M.p.nord11,
    magenta    = M.p.nord15,
    violet     = M.p.nord7,
    blue       = M.p.nord9,
    cyan       = M.p.nord8,
    greenDark  = u.blend(M.p.nord14, M.p.nord0, 0.1),
    greenDim   = u.blend(M.p.nord14, M.p.nord0, 0.2),
    green      = M.p.nord14,
}

return M.pCurated
