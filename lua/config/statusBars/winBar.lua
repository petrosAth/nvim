local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local c = require("config.statusBars.components")
local theme = require("config.themes." .. THEME .. ".highlights.statusBars").heirline.winBar
local M = {}

local DefaultWinBar = {
    condition = function()
        return conditions.is_active()
    end,
    {
        c.FileReadOnly,
        hl = theme.bright,
    },
    {
        c.FileNameBlock,
        hl = function ()
            if vim.bo.modified then
                return { bg = utils.get_highlight("DiffChange").bg }
            end
            return theme.bright
        end
    },
    c.Align,
    {
        c.CloseButton,
        hl = theme.bright,
    },
}

local InactiveWinBar = {
    condition = function()
        return not conditions.is_active()
    end,
    {
        c.FileReadOnly,
        hl = theme.bright,
    },
    {
        c.FileNameBlock,
        hl = function ()
            if vim.bo.modified then
                return { fg = utils.get_highlight("GitSignsChange").fg }
            end
        end
    },
    c.Align,
    c.WindowNumber,
    {
        c.CloseButton,
        hl = theme.bright,
    },
}

local SpecialWinBar = {
    condition = function()
        return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "^git.*", "fugitive" },
        })
    end,
    init = function()
        vim.opt_local.winbar = nil
    end,
}

M.WinBars = {
    hl = function()
        if conditions.is_active() then
            return "WinBar"
        else
            return "WinBarNC"
        end
    end,

    init = utils.pick_child_on_condition,

    SpecialWinBar,
    InactiveWinBar,
    DefaultWinBar,
}

return M
