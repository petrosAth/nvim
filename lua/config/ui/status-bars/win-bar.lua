local conditions = require("heirline.conditions")
local u = require("config.ui.utilities")
local h = require("config.ui.status-bars.tables")
local c = require("config.ui.status-bars.components")
local M = {}

local DisableWinBar = {
    condition = function()
        -- Source:
        -- incline.nvim - https://github.com/b0o/incline.nvim/blob/44d4e6f4dcf2f98cf7b62a14e3c10749fc5c6e35/lua/incline/util.lua#L49-L51
        return vim.api.nvim_win_get_config(0).relative ~= ""
            or conditions.buffer_matches({
                buftype = h.DisableBufType,
                filetype = h.DisableFileType,
            })
    end,
    init = function()
        vim.opt_local.winbar = nil
    end,
}

local WinBarSpecial = {
    condition = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.fullPath = vim.fn.fnamemodify(self.fileName, ":p")
        local has_custom_title, _ = u.check_for_custom_title(self.fullPath, vim.bo.buftype, vim.bo.filetype)
        return not conditions.is_active() and has_custom_title
    end,
    {
        c.FileReadOnly,
        hl = "WinBarIsReadOnly",
    },
    {
        c.CustomTitle,
        hl = "WinBarSpecialNC",
    },
    h.Align,
    {
        c.WindowNumber,
        hl = "WinBarWindowNumber"
    },
    {
        c.CloseButton,
        hl = "WinBarCloseButton",
    },
}

local WinBar = {
    condition = function()
        return not conditions.is_active()
    end,
    {
        c.FileReadOnly,
        hl = "WinBarIsReadOnly",
    },
    {
        c.FileModified,
        hl = "WinBarIsModified",
    },
    {
        c.FileNameBlock,
        hl = "WinBarFileNC"
    },
    h.Align,
    {
        c.WindowNumber,
        hl = "WinBarWindowNumber"
    },
    {
        c.CloseButton,
        hl = "WinBarCloseButton",
    },
}

local WinBarSpecialCurrent = {
    condition = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.fullPath = vim.fn.fnamemodify(self.fileName, ":p")
        local has_custom_title, _ = u.check_for_custom_title(self.fullPath, vim.bo.buftype, vim.bo.filetype)
        return has_custom_title
    end,
    {
        c.FileReadOnly,
        hl = "WinBarIsReadOnly",
    },
    {
        c.CustomTitle,
        hl = "WinBarSpecial",
    },
    h.Align,
    {
        c.CloseButton,
        hl = "WinBarCloseButton",
    },
}

local WinBarCurrent = {
    condition = function()
        return conditions.is_active()
    end,
    {
        c.FileReadOnly,
        hl = "WinBarIsReadOnly",
    },
    {
        c.FileModified,
        hl = "WinBarIsModified",
    },
    {
        c.FileNameBlock,
        hl = "WinBarFile",
    },
    h.Align,
    {
        c.CloseButton,
        hl = "WinBarCloseButton",
    },
}

M.WinBars = {
    fallthrough = false,

    DisableWinBar,
    WinBarSpecial,
    WinBar,
    WinBarSpecialCurrent,
    WinBarCurrent,

    hl = function()
        if conditions.is_active() then
            return "WinBar"
        else
            return "WinBarNC"
        end
    end,
}

return M
