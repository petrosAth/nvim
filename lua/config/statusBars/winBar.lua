local conditions = require("heirline.conditions")
local h = require("config.statusBars.helperTables")
local c = require("config.statusBars.components")
local hl = "WinBarLight"
local M = {}

local CurrentWinBar = {
    condition = function()
        return conditions.is_active()
    end,
    {
        c.FileReadOnly,
        hl = hl,
    },
    {
        c.FileNameBlock,
        hl = function()
            if vim.bo.modified then
                return "WinBarModifiedCurrent"
            end
            return "WinBarCurrent"
        end,
    },
    h.Align,
    {
        c.CloseButton,
        hl = hl,
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
        hl = hl,
    },
    {
        c.FileNameBlock,
        hl = "WinBarCurrentSpecial",
    },
    h.Align,
    {
        c.CloseButton,
        hl = hl,
    },
}

local InactiveWinBar = {
    condition = function()
        return not conditions.is_active()
    end,
    {
        c.FileReadOnly,
        hl = hl,
    },
    {
        c.FileNameBlock,
        hl = function()
            if vim.bo.modified then
                return "WinBarModifiedInactive"
            end
        end,
    },
    h.Align,
    c.WindowNumber,
    {
        c.CloseButton,
        hl = hl,
    },
}

local SpecialInactiveWinBar = {
    condition = function()
        return not conditions.is_active()
            and conditions.buffer_matches({
                buftype = h.SpecialBufType,
                filetype = h.SpecialFileType,
            })
    end,
    {
        c.FileReadOnly,
        hl = hl,
    },
    {
        c.FileNameBlock,
        hl = "WinBarSpecial",
    },
    h.Align,
    c.WindowNumber,
    {
        c.CloseButton,
        hl = hl,
    },
}

local DisableWinBar = {
    condition = function()
        -- Source:
        -- incline.nvim - https://github.com/b0o/incline.nvim/blob/44d4e6f4dcf2f98cf7b62a14e3c10749fc5c6e35/lua/incline/util.lua#L49-L51
        return vim.api.nvim_win_get_config(0).relative ~= ""
            or conditions.buffer_matches({
                buftype = { "prompt" },
                filetype = { "alpha", "packer", "lspinfo", "mason", "WhichKey" },
            })
    end,
    init = function()
        vim.opt_local.winbar = nil
    end,
}

M.WinBars = {
    fallthrough = false,

    DisableWinBar,
    SpecialInactiveWinBar,
    InactiveWinBar,
    SpecialCurrentWinBar,
    CurrentWinBar,

    hl = function()
        if conditions.is_active() then
            return "WinBar"
        else
            return "WinBarNC"
        end
    end,
}

return M
