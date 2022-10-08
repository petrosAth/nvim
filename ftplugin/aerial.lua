local ol = vim.opt_local
local i = require("styling").icons.fillchars

ol.number         = true
ol.relativenumber = true
ol.fillchars      = i.global  -- Re-apply fillchars because aerial resets them
ol.fillchars:append(i.custom) -- Remove eob character
