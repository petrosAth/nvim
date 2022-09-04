local ol = vim.opt_local
local f = require("options")

ol.list           = true             -- Enable list mode
ol.colorcolumn    = ""               -- Hide vertical line for text alignment
ol.number         = true
ol.relativenumber = true
ol.fillchars      = f.localFillchars
