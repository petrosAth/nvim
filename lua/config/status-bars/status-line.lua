local conditions = require("heirline.conditions")
local h = require("config.status-bars.tables")
local c = require("config.status-bars.components")
local hl = "StatusLineLight"
local M = {}

local DefaultStatusline = {
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

local SpecialStatusline = {
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

local MinimalStatusline = {
    condition = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.fullPath = vim.fn.fnamemodify(self.fileName, ":p")
        local has_custom_title, _ = c.check_for_custom_title(self.fullPath, vim.bo.buftype, vim.bo.filetype)
        local in_diffview = string.match(self.fileName, "^diffview:///[^(panels)]") -- in diffview but not in diffview panels
        local disabled_buffer = conditions.buffer_matches({
            buftype = h.DisableBufType,
            filetype = h.DisableFileType,
        })
        return disabled_buffer or (has_custom_title and not in_diffview)
    end,

    c.ViMode,
    c.SearchResults,

    h.Align,
}

local InactiveStatusline = {
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

local TerminalStatusline = {

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

M.StatusLines = {
    fallthrough = false,

    InactiveStatusline,
    TerminalStatusline,
    SpecialStatusline,
    MinimalStatusline,
    DefaultStatusline,

    hl = function()
        if conditions.is_active() then
            return "StatusLine"
        else
            return "StatusLineNC"
        end
    end,
}

return M
