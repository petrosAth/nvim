local ol = vim.opt_local
local i = require("styling").icons.fillchars

ol.winbar = nil               -- Disable winbar
ol.fillchars:append(i.custom) -- Remove eob character
