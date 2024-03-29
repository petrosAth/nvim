local function setup(which_key, icons, borders)
    which_key.setup({
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
            ["<Leader>"] = "LDR",
        },
        icons = {
            breadcrumb = icons.arrow.hollow.r, -- symbol used in the command line area that shows your active key combo
            separator = icons.arrow.hollow.r, -- symbol used between a key and it's label
            group = icons.key[1] .. " ", -- symbol prepended to a group
        },
        popup_mappings = {
            scroll_down = "<c-d>", -- binding to scroll down inside the popup
            scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
            border = {
                borders.tl,
                borders.t,
                borders.tr,
                borders.r,
                borders.br,
                borders.b,
                borders.bl,
                borders.l,
            }, -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
            winblend = USER.styling.variables.transparency,
        },
        layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 80 }, -- min and max width of the columns
            spacing = 5, -- spacing between columns
            align = "left", -- align columns left, center or right
        },
        ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
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

    require("plugins.which-key.utils").register_mappings(which_key, USER.mappings)
end

return {
    {
        "folke/which-key.nvim",
        -- Which Key
        -- WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible key bindings of the command you
        -- started typing. Heavily inspired by the original emacs-which-key and vim-which-key.
        event = { "VeryLazy" },
        config = function()
            local loaded, which_key = pcall(require, "which-key")
            if not loaded then
                USER.loading_error_msg("which-key.nvim")
                return
            end

            local icons = USER.styling.icons
            local borders = USER.styling.borders.default
            setup(which_key, icons, borders)
        end,
    },
}
