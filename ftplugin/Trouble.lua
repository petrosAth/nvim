local ol = vim.opt_local
local f = require("options")

ol.colorcolumn    = ""               -- Hide vertical line for text alignment
ol.number         = true
ol.relativenumber = true
ol.fillchars      = f.localFillchars
