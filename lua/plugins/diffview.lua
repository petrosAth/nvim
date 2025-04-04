local function setup(diffview)
    local icons = USER.styling.icons
    local actions = require("diffview.config").actions

    diffview.setup({
        diff_binaries = false, -- Show diffs for binaries
        enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
        use_icons = true, -- Requires nvim-web-devicons
        icons = { -- Only applies when use_icons is true.
            folder_closed = icons.dir[1],
            folder_open = icons.diropen[1],
        },
        signs = {
            fold_closed = icons.fillchars.global.foldclose,
            fold_open = icons.fillchars.global.foldopen,
        },
        file_panel = {
            listing_style = "tree", -- One of 'list' or 'tree'
            tree_options = { -- Only applies when listing_style is 'tree'
                flatten_dirs = true, -- Flatten dirs that only contain one single dir
                folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
            },
            win_config = { -- See ':h diffview-config-win_config'
                position = "left",
                width = 35,
                win_opts = {
                    cursorcolumn = false,
                    number = true,
                    relativenumber = true,
                    signcolumn = "no",
                    foldcolumn = "0",
                },
            },
        },
        file_history_panel = {
            win_config = { -- See ':h diffview-config-win_config'
                position = "bottom",
                height = 16,
                win_opts = {
                    cursorcolumn = false,
                    number = true,
                    relativenumber = true,
                    signcolumn = "no",
                    foldcolumn = "0",
                },
            },
        },
        keymaps = {
            disable_defaults = false, -- Disable the default keymaps
            view = {
                -- The `view` bindings are active in the diff buffers, only when the current
                -- tabpage is a Diffview.
                -- ["<tab>"]         = actions.select_next_entry,   -- Open the diff for the next file
                -- ["<s-tab>"]       = actions.select_prev_entry,   -- Open the diff for the previous file
                -- ["gf"]            = actions.goto_file,           -- Open the file in a new split in previous tabpage
                ["<C-w><C-y>"] = actions.goto_file, -- Open the file in a new split in previous tabpage
                -- ["<C-w><C-f>"]    = actions.goto_file_split,     -- Open the file in a new split
                ["<C-w><C-v>"] = actions.goto_file_split, -- Open the file in a new split
                -- ["<C-w>gf"]       = actions.goto_file_tab,       -- Open the file in a new tabpage
                ["<C-w><C-t>"] = actions.goto_file_tab, -- Open the file in a new tabpage
                -- ["<leader>e"]     = actions.focus_files,         -- Bring focus to the files panel
                -- ["<leader>b"]     = actions.toggle_files,        -- Toggle the files panel.
            },
            file_panel = {
                -- ["j"]             = actions.next_entry,          -- Bring the cursor to the next file entry
                -- ["<down>"]        = actions.next_entry,          -- Bring the cursor to the next file entry
                -- ["k"]             = actions.prev_entry,          -- Bring the cursor to the previous file entry.
                -- ["<up>"]          = actions.prev_entry,          -- Bring the cursor to the previous file entry.
                -- ["<cr>"]          = actions.select_entry,        -- Open the diff for the selected entry.
                -- ["o"]             = actions.select_entry,        -- Open the diff for the selected entry.
                -- ["<2-LeftMouse>"] = actions.select_entry,        -- Open the diff for the selected entry.
                ["l"] = actions.select_entry, -- Open the diff for the selected entry.
                -- ["-"]             = actions.toggle_stage_entry,  -- Stage / unstage the selected entry.
                ["gt"] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
                -- ["S"]             = actions.stage_all,           -- Stage all entries.
                ["gS"] = actions.stage_all, -- Stage all entries.
                -- ["U"]             = actions.unstage_all,         -- Unstage all entries.
                ["gU"] = actions.unstage_all, -- Unstage all entries.
                -- ["X"]             = actions.restore_entry,       -- Restore entry to the state on the left side.
                ["gR"] = actions.restore_entry, -- Restore entry to the state on the left side.
                -- ["R"]             = actions.refresh_files,       -- Update stats and entries in the file list.
                -- ["L"]             = actions.open_commit_log,     -- Open the commit log panel.
                ["gl"] = actions.open_commit_log, -- Open the commit log panel.
                -- ["<tab>"]         = actions.select_next_entry,   -- Open the diff for the next file
                ["J"] = actions.select_next_entry, -- Open the diff for the next file
                -- ["<s-tab>"]       = actions.select_prev_entry,   -- Open the diff for the previous file
                ["K"] = actions.select_prev_entry, -- Open the diff for the previous file
                -- ["gf"]            = actions.goto_file,           -- Open the file in a new split in previous tabpage
                ["<C-y>"] = actions.goto_file, -- Open the file in a new split in previous tabpage
                -- ["<C-w><C-f>"]    = actions.goto_file_split,     -- Open the file in a new split
                ["<C-v>"] = actions.goto_file_split, -- Open the file in a new split
                -- ["<C-w>gf"]       = actions.goto_file_tab,       -- Open the file in a new tabpage
                ["<C-t>"] = actions.goto_file_tab, -- Open the file in a new tabpage
                -- ["i"]             = actions.listing_style,       -- Toggle between 'list' and 'tree' views
                -- ["f"]             = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
                -- ["<leader>e"]     = actions.focus_files,         -- Bring focus to the files panel
                -- ["<leader>b"]     = actions.toggle_files,        -- Toggle the files panel.
            },
            file_history_panel = {
                -- ["g!"]            = actions.options,             -- Open the option panel
                -- ["<C-A-d>"]       = actions.open_in_diffview,    -- Open the entry under the cursor in a diffview
                -- ["y"]             = actions.copy_hash,           -- Copy the commit hash of the entry under the cursor
                -- ["L"]             = actions.open_commit_log,
                ["gl"] = actions.open_commit_log, -- Open the commit log panel.
                -- ["zR"]            = actions.open_all_folds,
                -- ["zM"]            = actions.close_all_folds,
                -- ["j"]             = actions.next_entry,          -- Bring the cursor to the next file entry
                -- ["<down>"]        = actions.next_entry,          -- Bring the cursor to the next file entry
                -- ["k"]             = actions.prev_entry,          -- Bring the cursor to the previous file entry.
                -- ["<up>"]          = actions.prev_entry,          -- Bring the cursor to the previous file entry.
                -- ["<cr>"]          = actions.select_entry,        -- Open the diff for the selected entry.
                -- ["o"]             = actions.select_entry,        -- Open the diff for the selected entry.
                -- ["<2-LeftMouse>"] = actions.select_entry,        -- Open the diff for the selected entry.
                ["l"] = actions.select_entry, -- Open the diff for the selected entry.
                -- ["<tab>"]         = actions.select_next_entry,   -- Open the diff for the next file
                ["J"] = actions.select_next_entry, -- Open the diff for the next file
                -- ["<s-tab>"]       = actions.select_prev_entry,   -- Open the diff for the previous file
                ["K"] = actions.select_prev_entry, -- Open the diff for the previous file
                -- ["gf"]            = actions.goto_file,           -- Open the file in a new split in previous tabpage
                ["<C-y>"] = actions.goto_file, -- Open the file in a new split in previous tabpage
                -- ["<C-w><C-f>"]    = actions.goto_file_split,     -- Open the file in a new split
                ["<C-v>"] = actions.goto_file_split, -- Open the file in a new split
                -- ["<C-w>gf"]       = actions.goto_file_tab,       -- Open the file in a new tabpage
                ["<C-t>"] = actions.goto_file_tab, -- Open the file in a new tabpage
                -- ["<leader>e"]     = actions.focus_files,         -- Bring focus to the files panel
                -- ["<leader>b"]     = actions.toggle_files,        -- Toggle the files panel.
            },
            option_panel = {
                -- ["<tab>"]         = actions.select_entry,        -- Open the diff for the selected entry.
                ["<cr>"] = actions.select_entry, -- Open the diff for the selected entry.
                ["<C-y>"] = actions.select_entry, -- Open the diff for the selected entry.
                -- ["q"]             = actions.close,               -- Close the option panel
            },
        },
    })
end

return {
    {
        -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
        "sindrets/diffview.nvim",
        cmd = {
            "DiffviewOpen",
            "DiffviewLog",
            "DiffviewClose",
            "DiffviewRefresh",
            "DiffviewFocusFiles",
            "DiffviewFileHistory",
            "DiffviewToggleFiles",
        },
        config = function()
            local loaded, diffview = pcall(require, "diffview")
            if not loaded then
                USER.loading_error_msg("diffview.nvim")
                return
            end

            setup(diffview)
        end,
    },
}
