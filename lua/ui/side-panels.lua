local ol = vim.opt_local
local fc = USER.styling.icons.fillchars
local lc = USER.styling.icons.listchars
local M = {}

M.set_local_options = function()
    ol.signcolumn = "no"
    ol.foldcolumn = "1"
    ol.colorcolumn = ""
    ol.cursorcolumn = false
    ol.number = true
    ol.relativenumber = true
    ol.statuscolumn = ""
    ol.list = false
end

M.set_non_chars = function()
    ol.fillchars = fc.global -- Re-apply fillchars because some plugins reset them
    ol.fillchars:append(fc.custom)
    ol.listchars = lc.global -- Re-apply listchars because some plugins reset them
    ol.listchars:append(lc.custom)
end

return M
