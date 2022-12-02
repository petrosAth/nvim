-- undotree diff panel
local ol = vim.opt_local
local fc = USER.styling.icons.fillchars
local lc = USER.styling.icons.listchars
local ns = vim.api.nvim_create_namespace("SidePanel")

ol.signcolumn     = "no"
ol.foldcolumn     = "0"
ol.colorcolumn    = ""
ol.cursorcolumn   = false
ol.number         = true
ol.relativenumber = true
ol.fillchars      = fc.global -- Re-apply fillchars because some plugins reset them
ol.fillchars:append(fc.custom)
ol.listchars      = lc.global -- Re-apply listchars because some plugins reset them
ol.listchars:append(lc.custom)

vim.api.nvim_set_hl(ns, "WinSeparator", vim.api.nvim_get_hl_by_name("SidePanelWinSeparator", true))
vim.api.nvim_set_hl(ns, "NonText", vim.api.nvim_get_hl_by_name("SidePanelNonText", true))
vim.api.nvim_win_set_hl_ns(0, ns)
