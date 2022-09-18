local conditions = require("heirline.conditions")
local theme = require("config.themes." .. THEME .. ".highlights.statusBars").heirline.statusBar
local h = require("config.statusBars.helperTables")
local c = require("config.statusBars.components")
local M = {}

local DefaultStatusline = {
    c.ViMode,
    c.Paste,
    c.Wrap,
    c.SearchResults,
    {
        c.GitStatus,
        hl = theme.bright,
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
        hl = theme.bright,
    },
    c.LinesTotal,
}

local InactiveStatusline = {
    condition = function()
        return not conditions.is_active()
    end,

    c.ViMode,
    h.Align,
    {
        c.WindowNumber,
        hl = theme.bright,
    },
}

local SpecialStatusline = {
    condition = function()
        return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = {
                "aerial",
                "alpha",
                "diff",
                "DiffviewFileHistory",
                "DiffviewFiles",
                "fugitive",
                "^git.*",
                "help",
                "lspinfo",
                "man",
                "mason.nvim",
                "minimap",
                "neo-tree",
                "NvimTree",
                "Outline",
                "packer",
                "qf",
                "TelescopePrompt",
                "Trouble",
                "undotree",
            },
        })
    end,

    c.ViMode,
    c.SearchResults,
    {
        c.SpecialName,
        hl = theme.bright,
    },
    h.Align,
    {
        c.CursorLineSpecial,
        hl = theme.bright,
    },
    c.LinesTotalSpecial,
}

local TerminalStatusline = {

    condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
    end,

    c.ViMode,
    {
        c.TerminalName,
        hl = theme.bright,
    },
    h.Align,
}

M.StatusLines = {
    fallthrough = false,

    TerminalStatusline,
    SpecialStatusline,
    InactiveStatusline,
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
