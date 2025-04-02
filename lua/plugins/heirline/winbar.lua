local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local uiUtils = require("ui.utilities")
local props = require("plugins.heirline.properties")
local c = require("plugins.heirline.components")
local Sep = USER.styling.separators.bars
local Align = { provider = "%=" }

local border = function(position, fg, bg)
    return {
        provider = Sep[position],
        hl = {
            fg = fg and utils.get_highlight(fg.hl)[fg.layer] or "",
            bg = bg and utils.get_highlight(bg.hl)[bg.layer] or "",
        },
    }
end

local DisableWinBar = {
    condition = function()
        return vim.api.nvim_win_get_config(0).relative ~= ""
            or conditions.buffer_matches({
                buftype = props.Disable.winBar.buftype,
                filetype = props.Disable.winBar.filetype,
            })
    end,
    init = function() vim.opt_local.winbar = "" end,
}

local WinBarSpecialNC = {
    condition = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.fullPath = vim.fn.fnamemodify(self.fileName, ":p")
        local buf_label = uiUtils.get_buf_label(self.fullPath, vim.bo.buftype, vim.bo.filetype)
        return not conditions.is_active() and buf_label
    end,
    border("edgeLeft", { hl = "WinBar1NC", layer = "bg" }, { hl = "WinBarNC", layer = "bg" }),
    {
        c.FileReadOnly,
        hl = { fg = utils.get_highlight("BarReadOnly").fg, bg = utils.get_highlight("WinBar1NC").bg },
    },
    {
        c.CustomTitle,
        hl = "WinBar1NC",
    },
    border("right", { hl = "WinBar1NC", layer = "bg" }, { hl = "WinBarNC", layer = "bg" }),
    Align,
    {
        c.WindowNumber,
        hl = "BarWindowNumber",
    },
    border("left", { hl = "WinBar1NC", layer = "bg" }, { hl = "WinBarNC", layer = "bg" }),
    {
        { c.CloseButton },
        hl = { fg = utils.get_highlight("BarCloseButtonNC").fg, bg = utils.get_highlight("WinBar1NC").bg },
    },
    border("right", { hl = "WinBar1NC", layer = "bg" }, { hl = "WinBarNC", layer = "bg" }),
}

local WinBarNC = {
    condition = function() return not conditions.is_active() end,
    border("edgeLeft", { hl = "WinBar1NC", layer = "bg" }, { hl = "WinBarNC", layer = "bg" }),
    {
        c.FileReadOnly,
        hl = { fg = utils.get_highlight("BarReadOnly").fg, bg = utils.get_highlight("WinBar1NC").bg },
    },
    {
        c.FileModified,
        hl = { fg = utils.get_highlight("BarUnmodified").fg, bg = utils.get_highlight("WinBar1NC").bg },
    },
    {
        c.FileNameBlock,
        hl = "WinBar1NC",
    },
    border("right", { hl = "WinBar1NC", layer = "bg" }, { hl = "WinBarNC", layer = "bg" }),
    Align,
    {
        c.WindowNumber,
        hl = "BarWindowNumber",
    },
    border("left", { hl = "WinBar1NC", layer = "bg" }, { hl = "WinBarNC", layer = "bg" }),
    {
        { c.CloseButton },
        hl = { fg = utils.get_highlight("BarCloseButtonNC").fg, bg = utils.get_highlight("WinBar1NC").bg },
    },
    border("right", { hl = "WinBar1NC", layer = "bg" }, { hl = "WinBarNC", layer = "bg" }),
}

local WinBarSpecial = {
    condition = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.fullPath = vim.fn.fnamemodify(self.fileName, ":p")
        local buf_label = uiUtils.get_buf_label(self.fullPath, vim.bo.buftype, vim.bo.filetype)
        return buf_label
    end,
    border("edgeLeft", { hl = "WinBar1", layer = "bg" }, { hl = "WinBar", layer = "bg" }),
    {
        c.FileReadOnly,
        hl = { fg = utils.get_highlight("BarReadOnly").fg, bg = utils.get_highlight("WinBar1").bg },
    },
    {
        c.CustomTitle,
        hl = "WinBar1",
    },
    border("right", { hl = "WinBar1", layer = "bg" }, { hl = "WinBar", layer = "bg" }),
    Align,
    {
        c.WindowNumber,
        hl = "BarWindowNumber",
    },
    border("left", { hl = "WinBar1", layer = "bg" }, { hl = "WinBar", layer = "bg" }),
    {
        { c.CloseButton },
        hl = { fg = utils.get_highlight("BarCloseButton").fg, bg = utils.get_highlight("WinBar1").bg },
    },
    border("right", { hl = "WinBar1", layer = "bg" }, { hl = "WinBar", layer = "bg" }),
}

local WinBar = {
    condition = function() return conditions.is_active() end,
    border("left", { hl = "WinBar1", layer = "bg" }, { hl = "WinBar", layer = "bg" }),
    {
        c.FileReadOnly,
        hl = { fg = utils.get_highlight("BarReadOnly").fg, bg = utils.get_highlight("WinBar1").bg },
    },
    {
        c.FileModified,
        hl = { fg = utils.get_highlight("BarUnmodified").fg, bg = utils.get_highlight("WinBar1").bg },
    },
    {
        c.FileNameBlock,
        hl = "WinBar1",
    },
    border("right", { hl = "WinBar1", layer = "bg" }, { hl = "WinBar", layer = "bg" }),
    c.LspSymbol,
    Align,
    {
        c.WindowNumber,
        hl = "BarWindowNumber",
    },
    border("left", { hl = "WinBar1", layer = "bg" }, { hl = "WinBar", layer = "bg" }),
    {
        { c.CloseButton },
        hl = { fg = utils.get_highlight("BarCloseButton").fg, bg = utils.get_highlight("WinBar1").bg },
    },
    border("right", { hl = "WinBar1", layer = "bg" }, { hl = "WinBar", layer = "bg" }),
}

return {
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
