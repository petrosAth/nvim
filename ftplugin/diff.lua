-- Undotree diff panel
local ol = vim.opt_local
local i = require("styling").icons.fillchars

ol.colorcolumn = ""           -- Hide vertical line for text alignment
ol.fillchars:append(i.custom) -- Remove eob character
