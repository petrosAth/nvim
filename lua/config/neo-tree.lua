local tree = require("neo-tree")
local i = require("styling").icons
local b = require("styling").borders.default

tree.setup({
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    -- popup_border_style = "double",
    popup_border_style = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l }, -- Border style of prompt popups.,
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    sort_function = nil, -- use a custom function for sorting files and directories in the tree
    -- sort_function = function (a,b)
    --       if a.type == b.type then
    --           return a.path > b.path
    --       else
    --           return a.type > b.type
    --       end
    --   end , -- this sorts files and directories descendantly
    default_component_configs = {
        container = {
            enable_character_fade = true,
        },
        indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = false,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = i.foldercl[1],
            expander_expanded = i.folderop[1],
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = i.dir[1],
            folder_open = i.diropen[1],
            folder_empty = i.dir[1],
        },
        modified = {
            symbol = i.edit[1],
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                -- Change type
                added = i.git.added[1], -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified = i.git.changed[1], -- or "", but this is redundant info if you use git_status_colors on the name
                deleted = i.git.deleted[1], -- this can only be used in the git_status source
                renamed = i.git.renamed[1], -- this can only be used in the git_status source
                -- Status type
                untracked = i.git.untracked[1],
                ignored = i.git.ignored[2], --""
                unstaged = i.git.unstaged[1],
                staged = i.git.staged[1],
                conflict = i.git.conflict[1],
            },
        },
    },
    window = {
        position = "left",
        width = 45,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["<space>"] = {
                "toggle_node",
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open",
            ["l"] = "open_with_window_picker",
            ["<C-s>"] = "split_with_window_picker",
            ["<C-v>"] = "vsplit_with_window_picker",
            ["<C-t>"] = "open_tabnew",
            ["w"] = false,
            ["s"] = false,
            ["S"] = false,
            ["h"] = "close_node",
            ["z"] = false,
            ["zM"] = "close_all_nodes",
            ["a"] = {
                "add",
                -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                config = {
                    show_path = "relative", -- "none", "relative", "absolute"
                },
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
            ["D"] = "delete",
            ["R"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            ["M"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["r"] = "refresh",
            ["?"] = "show_help",
        },
    },
    nesting_rules = {},
    filesystem = {
        filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = false,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
                --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
                --"*.meta"
            },
            never_show = { -- remains hidden even if visible is toggled to true
                --".DS_Store",
                --"thumbs.db"
            },
        },
        follow_current_file = true, -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",  -- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
        window = {
            mappings = {
                ["<BS>"] = "navigate_up",
                ["<CR>"] = "set_root",
                ["."] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["d"] = "fuzzy_finder_directory",
                ["f"] = "filter_on_submit",
                ["<C-x>"] = "clear_filter",
                ["[c"] = "prev_git_modified",
                ["]c"] = "next_git_modified",
            },
        },
    },
    buffers = {
        follow_current_file = true, -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
            mappings = {
                ["d"] = "buffer_delete",
                ["<BS>"] = "navigate_up",
                ["<CR>"] = "set_root",
            },
        },
    },
    git_status = {
        window = {
            position = "float",
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
    event_handlers = {
        {
            event = "neo_tree_buffer_enter",
            handler = function()
                vim.cmd([[
                    setlocal
                        \ nocursorcolumn
                        \ fillchars+=eob:\ "
                ]])
            end,
        },
    },
})
