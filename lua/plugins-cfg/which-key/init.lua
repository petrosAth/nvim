local wk = require("which-key")
local ct = require("cosmetics").variables.transparency
local ci = require("cosmetics").icon
local cb = require("cosmetics").border.table

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
        breadcrumb = ci.arrowr[1], -- symbol used in the command line area that shows your active key combo
        separator = ci.arrowr[1], -- symbol used between a key and it's label
        group = " ", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = '<c-d>', -- binding to scroll down inside the popup
        scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
        border = { cb.tl, cb.t, cb.tr, cb.r, cb.br, cb.b, cb.bl, cb.l }, -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = ct
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 80 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
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

require("plugins-cfg.which-key.mappings-plugin")
require("plugins-cfg.which-key.mappings-system")

-- Code snippets
-- For future reference - https://github.com/folke/which-key.nvim/issues/165#issuecomment-921332940
-- require('which-key').register({
--     ['key'] = {
--         key = "text"
--     },
-- }, {
--     buffer = vim.api.nvim_get_current_buf(), --- pass buffer number in option then it will work
-- })

-- For future reference - https://github.com/folke/which-key.nvim/issues/135#issuecomment-898175086
-- function WhichKeyFileType()
--     local fileType = vim.api.nvim_buf_get_option(0, "filetype")
--     local opts = { buffer = 0 }
--     if fileType == "FileType" then
--         wk.register({
--             ["<key>"] = { "text" }
--         }, opts )
--     end
-- end
