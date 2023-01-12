local ol = vim.opt_local
local fc = USER.styling.icons.fillchars
local lc = USER.styling.icons.listchars
local ns = vim.api.nvim_create_namespace("SidePanel")
local M = {}

M.set_local_options = function()
    ol.signcolumn = "no"
    ol.foldcolumn = "1"
    ol.colorcolumn = ""
    ol.cursorcolumn = false
    ol.relativenumber = true
    ol.statuscolumn = ""
end

M.set_non_chars = function()
    ol.fillchars = fc.global -- Re-apply fillchars because some plugins reset them
    ol.fillchars:append(fc.custom)
    ol.listchars = lc.global -- Re-apply listchars because some plugins reset them
    ol.listchars:append(lc.custom)
end

M.set_local_highlights = function(win)
    win = win or vim.api.nvim_get_current_win()
    vim.api.nvim_set_hl(ns, "Normal", vim.api.nvim_get_hl_by_name("SidePanelNormal", true))
    vim.api.nvim_set_hl(ns, "NormalNC", vim.api.nvim_get_hl_by_name("SidePanelNormalNC", true))
    vim.api.nvim_set_hl(ns, "WinSeparator", vim.api.nvim_get_hl_by_name("SidePanelWinSeparator", true))
    vim.api.nvim_set_hl(ns, "CursorLineFold", vim.api.nvim_get_hl_by_name("CursorLine", true))
    vim.api.nvim_win_set_hl_ns(win, ns)
end

return M
