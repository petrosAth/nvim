local function setup(neo_tree, icons, borders)
    neo_tree.setup({
        sources = {
            "filesystem",
            "buffers",
            "git_status",
            "document_symbols",
        },
        close_if_last_window = false,
        enable_normal_mode_for_inputs = true,
        popup_border_style = {
            borders.tl,
            borders.t,
            borders.tr,
            borders.r,
            borders.br,
            borders.b,
            borders.bl,
            borders.l,
        },
        use_popups_for_input = false,
        use_default_mappings = false,
        source_selector = {
            statusline = true,
            sources = {
                {
                    source = "filesystem",
                    display_name = icons.fileExplorer[1] .. " Files ",
                },
                {
                    source = "buffers",
                    display_name = icons.buffers[1] .. " Buffers ",
                },
                {
                    source = "git_status",
                    display_name = icons.git.repo[1] .. " Git ",
                },
                {
                    source = "document_symbols",
                    display_name = icons.codeOutline[1] .. " Code outline ",
                },
            },
            tabs_layout = "active",
            separator = { left = "▏", right = "" },
            show_separator_on_edge = true,
            highlight_tab = "NeoTreeTabInactive",
            highlight_tab_active = "NeoTreeTabActive",
            highlight_background = "NeoTreeTabBarBackground",
            highlight_separator = "NeoTreeTabSeparatorInactive",
            highlight_separator_active = "NeoTreeTabSeparatorActive",
        },
        event_handlers = {
            {
                event = "neo_tree_buffer_enter",
                handler = function()
                    local ol = vim.opt_local

                    ol.colorcolumn = "" -- Hide vertical line for text alignment
                    ol.cursorcolumn = false
                    ol.relativenumber = true
                    ol.statuscolumn = ""
                    ol.fillchars = icons.fillchars.global
                    ol.fillchars:append(icons.fillchars.custom) -- Remove eob character
                end,
            },
        },
        default_component_configs = {
            container = {
                right_padding = 1,
            },
            indent = {
                padding = 0,
                with_markers = false,
                with_expanders = true,
                expander_collapsed = icons.fillchars.global.foldclose,
                expander_expanded = icons.fillchars.global.foldopen,
            },
            icon = {
                folder_closed = icons.dir[1],
                folder_open = icons.diropen[1],
                folder_empty = icons.dir[1],
                folder_empty_open = icons.diropen[1],
            },
            modified = {
                symbol = icons.edit[1],
            },
            name = {
                highlight_opened_files = "all",
            },
            git_status = {
                symbols = {
                    added = icons.git.added[1],
                    modified = icons.git.changed[1],
                    deleted = icons.git.deleted[1],
                    renamed = icons.git.renamed[1],
                    untracked = icons.git.untracked[1],
                    ignored = icons.git.ignored[2],
                    unstaged = icons.git.unstaged[1],
                    staged = icons.git.staged[1],
                    conflict = icons.git.conflict[1],
                },
            },
        },
        window = {
            width = 51,
            popup = {
                size = {
                    width = 49,
                    height = "80%",
                },
            },
            mappings = {
                ["<2-LeftMouse>"] = "open",
                ["<CR>"] = "open",
                ["l"] = "open_with_window_picker",
                ["o"] = "split_with_window_picker",
                ["v"] = "vsplit_with_window_picker",
                ["t"] = "open_tabnew",
                ["p"] = { "toggle_preview", config = { use_float = true } },
                ["P"] = "open",
                ["h"] = "close_node",
                ["zM"] = "close_all_nodes",
                ["zR"] = "expand_all_nodes",
                ["za"] = "toggle_node",
                ["%"] = {
                    "add",
                    -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                    config = {
                        show_path = "relative", -- "none", "relative", "absolute"
                    },
                },
                ["d"] = "add_directory", -- also accepts the optional config.show_path option like "add".
                ["D"] = "delete",
                ["R"] = "rename",
                ["mc"] = "copy_to_clipboard",
                ["mm"] = "cut_to_clipboard",
                ["mp"] = "paste_from_clipboard",
                ["cp"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
                ["mv"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
                ["q"] = "close_window",
                ["r"] = "refresh",
                ["?"] = "show_help",
                ["<"] = "prev_source",
                [">"] = "next_source",
            },
        },
        filesystem = {
            filtered_items = {
                hide_gitignored = false,
            },
            follow_current_file = {
                enabled = true,
            },
            group_empty_dirs = true,
            hijack_netrw_behavior = "open_current",
            window = {
                mappings = {
                    ["-"] = "navigate_up",
                    ["cd"] = "set_root",
                    ["gh"] = "toggle_hidden",
                    ["/"] = "filter_as_you_type",
                    ["<Esc>"] = "clear_filter",
                    ["[c"] = "prev_git_modified",
                    ["]c"] = "next_git_modified",
                },
            },
        },
        buffers = {
            group_empty_dirs = true, -- when true, empty folders will be grouped together
            show_unloaded = true,
            window = {
                mappings = {
                    ["D"] = "buffer_delete",
                    ["-"] = "navigate_up",
                    ["cd"] = "set_root",
                },
            },
        },
        git_status = {
            window = {
                mappings = {
                    ["A"] = "git_add_all",
                    ["gu"] = "git_unstage_file",
                    ["ga"] = "git_add_file",
                    ["gr"] = "git_revert_file",
                    ["gc"] = "git_commit",
                    ["gp"] = "git_push",
                    ["gg"] = "git_commit_and_push",
                },
            },
        },
        document_symbols = {
            follow_cursor = true,
            window = {
                mappings = {
                    ["<cr>"] = "jump_to_symbol",
                    ["o"] = "jump_to_symbol",
                    ["%"] = "noop",
                    ["d"] = "noop",
                    ["D"] = "noop",
                    ["mc"] = "noop",
                    ["mm"] = "noop",
                    ["mp"] = "noop",
                    ["cp"] = "noop",
                    ["mv"] = "noop",
                },
            },
            kinds = {
                Unknown = { icon = "?", hl = "" },
                Array = { icon = icons.lsp.kinds.Array, hl = "@field" },
                Boolean = { icon = icons.lsp.kinds.Boolean, hl = "@boolean" },
                Class = { icon = icons.lsp.kinds.Class, hl = "@function" },
                Constant = { icon = icons.lsp.kinds.Constant, hl = "@constant" },
                Constructor = { icon = icons.lsp.kinds.Constructor, hl = "@constructor" },
                Enum = { icon = icons.lsp.kinds.Enum, hl = "@structure" },
                EnumMember = { icon = icons.lsp.kinds.EnumMember, hl = "@structure" },
                Event = { icon = icons.lsp.kinds.Event, hl = "@keyword" },
                Field = { icon = icons.lsp.kinds.Field, hl = "@field" },
                File = { icon = icons.lsp.kinds.File, hl = "Directory" },
                Function = { icon = icons.lsp.kinds.Function, hl = "@function" },
                Interface = { icon = icons.lsp.kinds.Interface, hl = "@type" },
                Key = { icon = icons.lsp.kinds.Key, hl = "@keyword" },
                Method = { icon = icons.lsp.kinds.Method, hl = "@method" },
                Module = { icon = icons.lsp.kinds.Module, hl = "@include" },
                Namespace = { icon = icons.lsp.kinds.Namespace, hl = "@namespace" },
                Null = { icon = icons.lsp.kinds.Null, hl = "@comment" },
                Number = { icon = icons.lsp.kinds.Number, hl = "@number" },
                Object = { icon = icons.lsp.kinds.Object, hl = "@type" },
                Operator = { icon = icons.lsp.kinds.Operator, hl = "@operator" },
                Package = { icon = icons.lsp.kinds.Package, hl = "@include" },
                Property = { icon = icons.lsp.kinds.Property, hl = "@property" },
                Root = { icon = "?", hl = "NeoTreeRootName" },
                String = { icon = icons.lsp.kinds.String, hl = "@string" },
                Struct = { icon = icons.lsp.kinds.Struct, hl = "@structure" },
                TypeParameter = { icon = icons.lsp.kinds.TypeParameter, hl = "@type" },
                Variable = { icon = icons.lsp.kinds.Variable, hl = "@variable" },
            },
        },
    })
end

return {
    {
        -- Neo-tree.nvim
        -- Neo-tree is a Neovim plugin to browse the file system and other tree like structures in whatever style suits
        -- you, including sidebars, floating windows, netrw split style, or all of them at once!
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            -- plenary.nvim
            -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write
            -- twice.
            "nvim-lua/plenary.nvim",
            -- Nvim-web-devicons
            -- A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.
            "nvim-tree/nvim-web-devicons",
            -- nui.nvim
            -- UI Component Library for Neovim.
            "MunifTanjim/nui.nvim",
            -- nvim-window-picker
            -- This plugins prompts the user to pick a window and returns the window id of the picked window
            "s1n7ax/nvim-window-picker",
        },
        config = function()
            local loaded, neo_tree = pcall(require, "neo-tree")
            if not loaded then
                USER.loading_error_msg("neo-tree.nvim")
                return
            end

            local icons = USER.styling.icons
            local borders = USER.styling.borders.default
            setup(neo_tree, icons, borders)
        end,
    },
}
