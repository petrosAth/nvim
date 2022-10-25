-- symbols-outline.nvim
local ol = vim.opt_local
local i = PA.styling.icons.fillchars

ol.colorcolumn    = ""        -- Hide vertical line for text alignment
ol.number         = true
ol.relativenumber = true
ol.foldcolumn     = "0"       -- Fold column size
ol.fillchars:append(i.custom) -- Remove eob character
