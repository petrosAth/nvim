local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local uiUtils = require("ui.utilities")
local props = require("plugins.heirline.properties")
local c = require("plugins.heirline.components")
local get_vim_mode_color = require("plugins.heirline.utilities").get_vim_mode_color
local Sep = USER.styling.separators.bars
local Align = { provider = "%=" }
local hl = "StatusLine1"

local border_edge_2 = {
    init = function(self) self.mode = vim.api.nvim_get_mode()["mode"] end,
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
    },
    {
        provider = Sep.edgeLeft,
        hl = function(self)
            return {
                fg = get_vim_mode_color(self.mode).bg,
                bg = utils.get_highlight("StatusLine").bg,
            }
        end,
    },
}

local border_2_edge = {
    init = function(self) self.mode = vim.api.nvim_get_mode()["mode"] end,
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
    },
    {
        provider = Sep.edgeRight,
        hl = function(self)
            return {
                fg = get_vim_mode_color(self.mode).bg,
                bg = utils.get_highlight("StatusLine").bg,
            }
        end,
    },
}

local border_2_1 = {
    init = function(self) self.mode = vim.api.nvim_get_mode()["mode"] end,
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
    },
    {
        provider = Sep.right,
        hl = function(self)
            return {
                fg = get_vim_mode_color(self.mode).bg,
                bg = utils.get_highlight("StatusLine1").bg,
            }
        end,
    },
}

local border_1_2 = {
    init = function(self) self.mode = vim.api.nvim_get_mode()["mode"] end,
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
    },
    {
        provider = Sep.left,
        hl = function(self)
            return {
                fg = get_vim_mode_color(self.mode).bg,
                bg = utils.get_highlight("StatusLine1").bg,
            }
        end,
    },
}

local border_1_0 = {
    init = function(self) self.mode = vim.api.nvim_get_mode()["mode"] end,
    {
        provider = Sep.right,
        hl = {
            fg = utils.get_highlight("StatusLine1").bg,
            bg = utils.get_highlight("StatusLine").bg,
        },
    },
}

local border_0_1 = {
    init = function(self) self.mode = vim.api.nvim_get_mode()["mode"] end,
    {
        provider = Sep.left,
        hl = {
            fg = utils.get_highlight("StatusLine1").bg,
            bg = utils.get_highlight("StatusLine").bg,
        },
    },
}

local StatusLineInactive = {
    condition = function() return not conditions.is_active() end,

    border_edge_2,
    c.ViMode,
    border_2_1,
    border_1_0,
    Align,
    {
        c.WindowNumber,
        hl = hl,
    },
}

local StatusLineTerminal = {
    condition = function() return conditions.buffer_matches({ buftype = { "terminal" } }) end,

    border_edge_2,
    c.ViMode,
    c.SearchResults,
    border_2_1,
    {
        c.TerminalName,
        hl = hl,
    },
    border_1_0,
    c.PluginUpdates,
    Align,
    border_0_1,
    {
        c.CursorPosition,
        hl = hl,
    },
    border_1_2,
    c.LinesTotal,
    border_2_edge,
}

local StatusLineSpecial = {
    condition = function()
        return conditions.buffer_matches({
            buftype = { "qf" },
            filetype = { "Outline", "qf", "trouble" },
        })
    end,

    border_edge_2,
    c.ViMode,
    c.SearchResults,
    border_2_1,
    border_1_0,
    c.PluginUpdates,
    Align,
    border_0_1,
    {
        c.CursorLine,
        hl = hl,
    },
    border_1_2,
    c.LinesTotal,
    border_2_edge,
}

local StatusLineMinimal = {
    condition = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.fullPath = vim.fn.fnamemodify(self.fileName, ":p")
        local buf_label = uiUtils.get_buf_label(self.fullPath, vim.bo.buftype, vim.bo.filetype)
        local in_diffview = string.match(self.fileName, "^diffview:///[^(panels)]") -- in diffview but not in diffview panels
        local is_disabled = conditions.buffer_matches({
            buftype = props.Disable.statusLine.buftype,
            filetype = props.Disable.statusLine.filetype,
        })
        return is_disabled or (buf_label and not in_diffview)
    end,

    border_edge_2,
    c.ViMode,
    c.SearchResults,
    border_2_1,
    border_1_0,
    c.PluginUpdates,
    Align,
}

local StatusLine = {
    border_edge_2,
    c.ViMode,
    c.SearchResults,
    c.Paste,
    c.Wrap,
    border_2_1,
    {
        c.GitStatus,
        hl = hl,
    },
    border_1_0,
    c.LspBlock,
    c.PluginUpdates,
    Align,
    c.GitBlame,
    Align,
    c.Spell,
    c.Treesitter,
    c.FileEncoding,
    c.FileFormatBlock,
    c.FileTypeBlock,
    c.FileSize,
    border_0_1,
    {
        c.CursorPosition,
        hl = hl,
    },
    border_1_2,
    c.LinesTotal,
    border_2_edge,
}

return {
    fallthrough = false,

    StatusLineInactive,
    StatusLineTerminal,
    StatusLineSpecial,
    StatusLineMinimal,
    StatusLine,

    hl = function()
        if conditions.is_active() then
            return "StatusLine"
        else
            return "StatusLineNC"
        end
    end,
}
