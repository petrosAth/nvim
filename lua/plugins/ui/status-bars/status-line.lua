local conditions = require("heirline.conditions")
local u = require("plugins.ui.utilities")
local h = require("plugins.ui.status-bars.tables")
local c = require("plugins.ui.status-bars.components")
local hl = "StatusLineLight"
local M = {}

local StatusLineInactive = {
    condition = function()
        return not conditions.is_active()
    end,

    c.ViMode,
    h.Align,
    {
        c.WindowNumber,
        hl = hl,
    },
}

local StatusLineTerminal = {
    condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
    end,

    c.ViMode,
    {
        c.TerminalName,
        hl = hl,
    },
    h.Align,
    {
        c.CursorPosition,
        hl = hl,
    },
    c.LinesTotal,
}

local StatusLineSpecial = {
    condition = function()
        return conditions.buffer_matches({
            buftype = { "qf" },
            filetype = { "qf", "Trouble" },
        })
    end,

    c.ViMode,
    c.SearchResults,

    h.Align,
    {
        c.CursorLine,
        hl = hl,
    },
    c.LinesTotal,
}

local StatusLineMinimal = {
    condition = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.fullPath = vim.fn.fnamemodify(self.fileName, ":p")
        local buf_label = u.get_buf_label(self.fullPath, vim.bo.buftype, vim.bo.filetype)
        local in_diffview = string.match(self.fileName, "^diffview:///[^(panels)]") -- in diffview but not in diffview panels
        local is_disabled = conditions.buffer_matches({
            buftype = h.Disable.statusLine.buftype,
            filetype = h.Disable.statusLine.filetype,
        })
        return is_disabled or (buf_label and not in_diffview)
    end,

    c.ViMode,
    c.SearchResults,

    h.Align,
}

local StatusLine = {
    c.ViMode,
    c.Paste,
    c.Wrap,
    c.SearchResults,
    {
        c.GitStatus,
        hl = hl,
    },
    c.LspBlock,
    c.Treesitter,
    h.Align,
    c.Spell,
    c.FileFormatBlock,
    c.FileEncoding,
    c.FileTypeBlock,
    {
        c.CursorPosition,
        hl = hl,
    },
    c.LinesTotal,
}

M.StatusLines = {
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

return M
