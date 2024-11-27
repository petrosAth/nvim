local function setup(telescope)
    local i = USER.styling.icons
    local b = USER.styling.borders.default
    local bn = USER.styling.borders.none
    local actions = require("telescope.actions")
    local actions_layout = require("telescope.actions.layout")
    local fb_actions = require("telescope").extensions.file_browser.actions

    telescope.setup({
        defaults = {
            prompt_prefix = string.format(" %s  ", i.search[1]),
            selection_caret = string.format("%s ", i.point[1]),
            multi_icon = string.format(" %s", i.select[1]),
            entry_prefix = "  ",
            winblend = USER.styling.variables.transparency,
            color_devicons = true,
            border = true,
            borderchars = {
            --  prompt  = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "▐",   "▌"   }
                prompt  = { bn.t,  b.r,   b.b,   b.l,   b.l,   b.r,   b.br,  b.bl, },
            --  results = { "🬂",   "▐",   "🬭",   "▌",   "🬛",   "🬫",   "🬷",   "🬲"   },
                results = { b.t,   b.r,   b.b,   b.l,   b.tl,  b.tr,  b.br,  b.bl, },
            --  preview = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   },
                preview = { b.t,   b.r,   b.b,   b.l,   b.tl,  b.tr,  b.br,  b.bl, },
            },
            initial_mode = "insert",
            path_display = {
                truncate = 3,
                -- "smart"
                -- shorten = { len = 1, exclude = { -1, -2, -3, -4 } }
                -- "absolute",
            },
            dynamic_preview_title = true,
            preview = {
                check_mime_type = true,
                timeout = 3000,
                msg_bg_fillchar = "╱", -- "╱" "╲" "╳"
            },
            vimgrep_arguments = {
                "rg",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--trim", -- Remove indentation
                "--hidden",
            },
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    mirror = false,
                    preview_cutoff = 20,
                    preview_width = { 0.6, max = 140 },
                    width = { 0.9, max = 260 },
                    height = { 0.9, max = 60 },
                },
                vertical = {
                    mirror = true,
                    preview_cutoff = 20,
                    preview_height = 0.4,
                    width = { 0.8, max = 140 },
                    height = { 0.8, max = 80 },
                },
            },
            selection_strategy = "reset",
            sorting_strategy = "descending",
            file_ignore_patterns = {
                "^.git",
                "^.nvim/",
                "tags",
                "node_modules",
            },
            history = {
                path = string.format("%s/databases/telescope_history", vim.fn.stdpath("data")),
                limit = 100,
            },
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            gflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            mappings = {
                i = {
                    ["<C-c>"] = actions.close,
                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<C-y>"] = actions.select_default,
                    ["<CR>"] = actions.select_default,
                    ["<C-o>"] = false,
                    ["<C-v>"] = false,
                    ["<C-t>"] = false,
                    ["<M-o>"] = actions.select_horizontal,
                    ["<M-v>"] = actions.select_vertical,
                    ["<M-t>"] = actions.select_tab,
                    ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                    ["<Tab>"] = actions.toggle_selection + actions.move_selection_better,
                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,
                    ["<PageUp>"] = actions.results_scrolling_up,
                    ["<PageDown>"] = actions.results_scrolling_down,
                    ["<C-l>"] = actions.complete_tag,
                    ["<C-_>"] = actions.which_key,
                    ["<M-q>F"] = require("trouble.sources.telescope").open,
                    ["<M-p>"] = actions_layout.toggle_preview,
                    ["<C-x>"] = false,
                    ["<C-q>"] = false,
                    ["<M-q>"] = false,
                    ["<C-/>"] = actions.which_key,
                    ["<C-w>"] = false,
                    ["<C-j>"] = actions.nop,
                },
                n = {
                    ["q"] = actions.close,
                    ["<esc>"] = actions.close,
                    ["<C-c>"] = actions.close,
                    ["<CR>"] = actions.select_default,
                    ["P"] = actions.select_default,
                    ["o"] = actions.select_horizontal,
                    ["v"] = actions.select_vertical,
                    ["t"] = actions.select_tab,
                    ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                    ["<Tab>"] = actions.toggle_selection + actions.move_selection_better,
                    ["mf"] = actions.toggle_selection,
                    ["<Space>"] = actions.toggle_selection,
                    ["j"] = actions.move_selection_next,
                    ["k"] = actions.move_selection_previous,
                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["gg"] = actions.move_to_top,
                    ["G"] = actions.move_to_bottom,
                    ["H"] = actions.move_to_top,
                    ["M"] = actions.move_to_middle,
                    ["L"] = actions.move_to_bottom,
                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,
                    ["<PageUp>"] = actions.results_scrolling_up,
                    ["<PageDown>"] = actions.results_scrolling_down,
                    ["?"] = actions.which_key,
                    ["qF"] = require("trouble.sources.telescope").open,
                    ["p"] = actions_layout.toggle_preview,
                    ["<C-x>"] = false,
                    ["<C-v>"] = false,
                    ["<C-t>"] = false,
                    ["<C-q>"] = false,
                    ["<M-q>"] = false,
                },
            },
        },
        pickers = {
            find_files = {
                find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden" },
            },
        },
        extensions = {
            file_browser = {
                grouped = true,
                depth = 1,
                dir_icon = i.dir[1],
                dir_icon_hl = "Directory",
                -- disables netrw and use telescope-file-browser in its place
                hijack_netrw = false,
                mappings = {
                    ["i"] = {
                        ["-"] = false,
                        ["~"] = false,
                        ["<A-c>"] = false,
                        ["<A-%>"] = fb_actions.create_from_prompt,
                        ["<A-r>"] = false,
                        ["<A-m>"] = false,
                        ["<A-y>"] = false,
                        ["<A-d>"] = false,
                        ["<C-o>"] = false,
                        ["<C-g>"] = false,
                        ["<C-e>"] = false,
                        ["<C-w>"] = false,
                        ["<C-t>"] = false,
                        ["<C-f>"] = false,
                        ["<C-h>"] = false,
                        ["<C-s>"] = false,
                    },
                    ["n"] = {
                        ["%"] = fb_actions.create,
                        ["R"] = fb_actions.rename,
                        ["M"] = fb_actions.move,
                        ["Y"] = fb_actions.copy,
                        ["D"] = fb_actions.remove,
                        ["X"] = fb_actions.open,
                        ["-"] = fb_actions.goto_parent_dir,
                        ["h"] = fb_actions.goto_parent_dir,
                        ["~"] = fb_actions.goto_home_dir,
                        ["."] = fb_actions.goto_cwd,
                        ["cd"] = fb_actions.change_cwd,
                        ["a"] = fb_actions.toggle_browser,
                        ["gh"] = fb_actions.toggle_hidden,
                        ["mu"] = fb_actions.toggle_all,
                        ["c"] = false,
                        ["r"] = false,
                        ["m"] = false,
                        ["y"] = false,
                        ["d"] = false,
                        ["o"] = false,
                        ["g"] = false,
                        ["e"] = false,
                        ["t"] = actions.select_tab,
                        ["f"] = false,
                        ["s"] = false,
                    },
                },
            },
            frecency = {
                db_root = string.format("%s/databases", vim.fn.stdpath("data")),
                show_scores = true,
                show_unindexed = true,
                ignore_patterns = { "*.git/*", "*/tmp/*" },
                disable_devicons = false,
                workspaces = {
                    ["Win petrosAth"] = "/mnt/c/Users/petrosAth",
                    [".config"] = "$HOME/.config",
                    ["Projects"] = "$HOME/Develop",
                },
            },
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "ignore_case",
            },
        },
    })

    -- Load extensions
    local extensions = { "dir", "file_browser", "frecency", "fzf", "luasnip", "possession" }
    pcall(function()
        for _, ext in ipairs(extensions) do
            telescope.load_extension(ext)
        end
    end)
end

return {
    {
        -- Find, Filter, Preview, Pick. All lua, all the time.
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false,
        dependencies = {
            -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write
            -- twice.
            "nvim-lua/plenary.nvim",
            -- fzf-native is a c port of fzf. It only covers the algorithm and implements few functions to support
            -- calculating the score.
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            -- A telescope.nvim extension that offers intelligent prioritization when selecting files from your editing
            -- history.
            "nvim-telescope/telescope-frecency.nvim",
            -- telescope-file-browser.nvim is a file browser extension for telescope.nvim. It supports synchronized
            -- creation, deletion, renaming, and moving of files and folders powered by telescope.nvim and plenary.nvim
            "nvim-telescope/telescope-file-browser.nvim",
            -- This plugin adds a LuaSnip snippet picker to the already-awesome Neovim Telescope plugin.
            "benfowler/telescope-luasnip.nvim",
            -- Perform telescope.nvim functions in selected directories
            "princejoogie/dir-telescope.nvim",
        },
        config = function()
            local loaded, telescope = pcall(require, "telescope")
            if not loaded then
                USER.loading_error_msg("telescope.nvim")
                return
            end

            setup(telescope)
        end,
    },
}
