-- trouble.nvim
local ol = vim.opt_local
local i = PA.styling.icons.fillchars

ol.colorcolumn    = ""        -- Hide vertical line for text alignment
ol.number         = true
ol.relativenumber = true
ol.fillchars      = i.global  -- Re-apply fillchars because Trouble resets them
ol.fillchars:append(i.custom) -- Remove eob character
