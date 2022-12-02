-- alpha-nvim
local ol = vim.opt_local
local fc = USER.styling.icons.fillchars

ol.fillchars      = fc.global  -- Re-apply fillchars because some plugins reset them
ol.fillchars:append(fc.custom)
