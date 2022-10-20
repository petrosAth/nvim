local ol = vim.opt_local
local i = PA.styling.icons.fillchars

ol.colorcolumn = ""           -- Hide vertical line for text alignment
ol.fillchars      = i.global  -- Re-apply fillchars because undotree resets them
ol.fillchars:append(i.custom) -- Remove eob character
