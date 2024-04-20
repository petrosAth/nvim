local conditions = require("heirline.conditions")
local u = require("ui.utilities")
local t = require("ui.status-bars.tables")
local c = require("ui.status-bars.components")
local M = {}

local DisableWinBar = {
    condition = function()
        return vim.api.nvim_win_get_config(0).relative ~= ""
            or conditions.buffer_matches({
                buftype = t.Disable.winBar.buftype,
                filetype = t.Disable.winBar.filetype,
            })
    end,
    init = function()
        vim.opt_local.winbar = ""
    end,
}

local WinBarSpecialNC = {
    condition = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.fullPath = vim.fn.fnamemodify(self.fileName, ":p")
        local buf_label = u.get_buf_label(self.fullPath, vim.bo.buftype, vim.bo.filetype)
        return not conditions.is_active() and buf_label
    end,
    {
        {
            c.FileReadOnly,
            hl = "WinBarIsReadOnly",
        },
        hl = "WinBarLightNC",
    },
    {
        c.CustomTitle,
        hl = "WinBarSpecialNC",
    },
    t.Align,
    {
        {
            c.WindowNumber,
            hl = "WinBarWindowNumber",
        },
        hl = "WinBarLightNC",
    },
}

local WinBarNC = {
    condition = function()
        return not conditions.is_active()
    end,
    {
        {
            c.FileReadOnly,
            hl = "WinBarIsReadOnly",
        },
        {
            c.FileModified,
            hl = "WinBarIsModified",
        },
        hl = "WinBarLightNC",
    },
    {
        c.FileNameBlock,
    },
    t.Align,
    {
        {
            c.WindowNumber,
            hl = "WinBarWindowNumber",
        },
        hl = "WinBarLightNC",
    },
}

local WinBarSpecial = {
    condition = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.fullPath = vim.fn.fnamemodify(self.fileName, ":p")
        local buf_label = u.get_buf_label(self.fullPath, vim.bo.buftype, vim.bo.filetype)
        return buf_label
    end,
    {
        {
            c.FileReadOnly,
            hl = "WinBarIsReadOnly",
        },
        {
            c.CustomTitle,
            hl = "WinBarSpecial",
        },
        hl = "WinBarLight",
    },
    t.Align,
}

local WinBar = {
    condition = function()
        return conditions.is_active()
    end,
    {
        {
            c.FileReadOnly,
            hl = "WinBarIsReadOnly",
        },
        {
            c.FileModified,
            hl = "WinBarIsModified",
        },
        hl = "WinBarLight",
    },
    {
        c.FileNameBlock,
    },
    t.Align,
}

M.WinBars = {
    fallthrough = false,

    -- DisableWinBar,
    WinBarSpecialNC,
    WinBarNC,
    WinBarSpecial,
    WinBar,

    hl = function()
        if conditions.is_active() then
            return "WinBar"
        else
            return "WinBarNC"
        end
    end,
}

return M
