local ol = vim.opt_local
local i = require("styling").icons.fillchars

ol.number         = true
ol.relativenumber = true
ol.foldcolumn     = "0"       -- Fold column size
ol.fillchars:append(i.custom) -- Remove eob character
