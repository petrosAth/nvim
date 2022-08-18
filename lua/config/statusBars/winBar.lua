local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local theme = require("config.themes." .. THEME .. ".highlights.statusBars").heirline.winBar
local h = require("config.statusBars.helperTables")
local c = require("config.statusBars.components")
local M = {}

local DefaultWinBar = {
    condition = function()
        return conditions.is_active()
    end,
    {
        c.FileReadOnly,
        hl = { fg = theme.bright.fg, bg = theme.bright.bg, bold = true }
    },
    {
        c.FileNameBlock,
        hl = function()
            if vim.bo.modified then
                return { bg = utils.get_highlight("DiffChange").bg, bold = true }
            end
            return { fg = theme.bright.fg, bg = theme.bright.bg, bold = true }
        end,
    },
    h.Align,
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
        hl = function()
            if vim.bo.modified then
                return { fg = utils.get_highlight("GitSignsChange").fg, bold = true }
            end
            return { bold = true }
        end,
    },
    h.Align,
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

-- TODO: Delete TempWinBar when whichkey gets fixed
--At the moment whichkey window disapears when winbar is disabled through buftype conditions
local TempWinBar = {
    condition = function()
        return conditions.buffer_matches({
            filetype = { "WhichKey" },
        })
    end,
    h.Null,
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

    -- TODO: Delete TempWinBar when whichkey gets fixed
    TempWinBar,
    SpecialWinBar,
    InactiveWinBar,
    DefaultWinBar,
}

return M
