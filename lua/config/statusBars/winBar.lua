local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local theme = require("config.themes." .. THEME .. ".highlights.statusBars").heirline
local h = require("config.statusBars.helperTables")
local c = require("config.statusBars.components")
local M = {}

local CurrentWinBar = {
    condition = function()
        return conditions.is_active()
    end,
    {
        c.FileReadOnly,
        hl = theme.winBar.bright
    },
    {
        c.FileNameBlock,
        hl = function()
            if vim.bo.modified then
                return theme.modified.current
            end
            return theme.winBar.current
        end,
    },
    h.Align,
    {
        c.CloseButton,
        hl = theme.winBar.bright,
    },
}

local SpecialCurrentWinBar = {
    condition = function()
        return conditions.buffer_matches({
            buftype = h.SpecialBufType,
            filetype = h.SpecialFileType,
        })
    end,
    {
        c.FileReadOnly,
        hl = theme.winBar.bright
    },
    {
        c.FileNameBlock,
        hl = { fg = theme.winBar.current.fg, bg = theme.winBar.current.bg, bold = true }
    },
    h.Align,
    {
        c.CloseButton,
        hl = theme.winBar.bright,
    },
}

local InactiveWinBar = {
    condition = function()
        return not conditions.is_active()
    end,
    {
        c.FileReadOnly,
        hl = theme.winBar.bright,
    },
    {
        c.FileNameBlock,
        hl = function()
            if vim.bo.modified then
                return theme.modified.inactive
            end
        end,
    },
    h.Align,
    c.WindowNumber,
    {
        c.CloseButton,
        hl = theme.winBar.bright,
    },
}

local SpecialInactiveWinBar = {
    condition = function()
        return not conditions.is_active() and conditions.buffer_matches({
            buftype = h.SpecialBufType,
            filetype = h.SpecialFileType,
        })

    end,
    {
        c.FileReadOnly,
        hl = theme.winBar.bright
    },
    {
        c.FileNameBlock,
        hl = { bold = true },
    },
    h.Align,
    c.WindowNumber,
    {
        c.CloseButton,
        hl = theme.winBar.bright,
    },
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

local DisableWinBar = {
    condition = function()
        -- Source:
        -- incline.nvim - https://github.com/b0o/incline.nvim/blob/44d4e6f4dcf2f98cf7b62a14e3c10749fc5c6e35/lua/incline/util.lua#L49-L51
        return vim.api.nvim_win_get_config(0).relative ~= '' or conditions.buffer_matches({
            buftype = { "prompt" },
            filetype = { "alpha", "packer", "lspinfo", "mason" },
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

    -- TODO: Delete TempWinBar when whichkey gets fixed
    TempWinBar,
    DisableWinBar,
    SpecialInactiveWinBar,
    InactiveWinBar,
    SpecialCurrentWinBar,
    CurrentWinBar,
}

return M
