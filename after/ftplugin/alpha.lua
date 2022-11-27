-- alpha-nvim
local ol = vim.opt_local
local i = USER.styling.icons.fillchars

ol.fillchars = i.global       -- Re-apply fillchars because Trouble resets them
ol.fillchars:append(i.custom) -- Remove eob character
