local wk = require("which-key")
local t = require("styling").variables.transparency
local i = require("styling").icons
local sb = require("styling").borders.default

wk.setup({
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 60, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        ["<Space>"] = "SPC",
        ["<CR>"] = "CR",
        ["<Tab>"] = "TAB",
        ["<Leader>"] = "LDR"
    },
    icons = {
        breadcrumb = i.arrowr[1], -- symbol used in the command line area that shows your active key combo
        separator = i.arrowr[1], -- symbol used between a key and it's label
        group = " ", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = '<c-d>', -- binding to scroll down inside the popup
        scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
        border = { sb.tl, sb.t, sb.tr, sb.r, sb.br, sb.b, sb.bl, sb.l }, -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = t
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 80 }, -- min and max width of the columns
        spacing = 5, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
})

local function register_descriptions(mappings)
-- Source: echasnovski/nvim
-- https://github.com/echasnovski/nvim/blob/70e70bfa9223383f059b474ae4969f79676b3dc0/lua/ec/configs/which-key.lua#L24-L34
    return vim.tbl_map(function(keymap)
        if type(keymap) ~= "table" then
            return keymap
        end

        -- If command's name is present, return it
        if type(keymap[2]) == "string" then
            return keymap[2]
        end

        -- Otherwise further traverse tree
        return register_descriptions(keymap)
    end, mappings)
end

local function register_modes(mappings)
    for mode, keymaps in pairs(mappings) do
        wk.register(register_descriptions(keymaps), { mode = mode })
    end
end

local function register_mappings_in_wk(mappings)
    register_modes(mappings)
end

register_mappings_in_wk(PA.mappings)