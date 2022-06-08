local telescope = require("telescope")
local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local trouble = require("trouble.providers.telescope")
local t = require("styling").variables.transparency
local i = require("styling").icon
local b = require("styling").border.default
local bn = require("styling").border.none

telescope.setup({
    defaults = {
        prompt_prefix = " " .. i.prompt[1] .. " ",
        selection_caret = i.point[1] .. " ",
        multi_icon = " " .. i.select[1],
        entry_prefix = "  ",
        winblend = t,
        color_devicons = true,
        border = true,
        borderchars = {
        --  prompt  = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   }
            prompt  = { bn.t,  b.r,   b.b,   b.l,   b.l,   b.r,   b.br,  b.bl  },
        --  results = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   },
            results = { b.t,   b.r,   b.b,   b.l,   b.tl,  b.tr,  b.br,  b.bl  },
        --  preview = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   },
            preview = { b.t,   b.r,   b.b,   b.l,   b.tl,  b.tr,  b.br,  b.bl  },
        },
        initial_mode = "insert",
        path_display = {
            -- truncate = 3
            "smart"
            -- shorten = { len = 1, exclude = { -1, -2, -3, -4 } }
            -- "absolute",
        },
        dynamic_preview_title = true,
        preview = {
            check_mime_type = true,
            timeout = 3000,
            msg_bg_fillchar = "╱" -- "╱" "╲" "╳"
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim", -- Remove indentation
            "--hidden"
        },
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.9,
            height = 0.9,
            horizontal = {
                mirror = false,
            },
            vertical = {
                mirror = false,
            },
        },
        selection_strategy = "reset",
        sorting_strategy = "descending",
        file_ignore_patterns = { "^.git", "tags" },
        history = {
            path = DATA_PATH .. "/databases/telescope_history",
            limit = 100
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        gflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        mappings = {
            i = {
                ["<c-n>"]     = actions.move_selection_next,
                ["<c-p>"]     = actions.move_selection_previous,
                ["<c-q>"]     = actions.close,
                ["<c-y>"]     = actions.select_default,
                ["<cr>"]      = actions.select_default,
                ["<c-s>"]     = actions.select_horizontal,
                ["<c-v>"]     = actions.select_vertical,
                ["<c-t>"]     = actions.select_tab,
                ["<s-tab>"]   = actions.toggle_selection + actions.move_selection_worse,
                ["<tab>"]     = actions.toggle_selection + actions.move_selection_better,
                ["<c-u>"]     = actions.preview_scrolling_up,
                ["<c-d>"]     = actions.preview_scrolling_down,
                ["<c-l>"]     = actions.complete_tag,
                ["<c-_>"]     = actions.which_key, -- keys from pressing <C-/>
                ["<m-q>"]     = trouble.smart_open_with_trouble,
                ["<m-p>"]     = actions_layout.toggle_preview,
                ["<leader>f"] = function(prompt_bufnr)
                    local opts = {
                        callback = actions.toggle_selection,
                    }
                    require("telescope").extensions.hop._hop(prompt_bufnr, opts)
                end,
                ["<leader>F"] = function(prompt_bufnr)
                    local opts = {
                        callback = actions.toggle_selection,
                        loop_callback = trouble.smart_open_with_trouble,
                    }
                    require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
                end,
            },
            n = {
                ["<c-q>"]     = actions.close,
                ["<cr>"]      = actions.select_default,
                ["<c-s>"]     = actions.select_horizontal,
                ["<c-v>"]     = actions.select_vertical,
                ["<c-t>"]     = actions.select_tab,
                ["<s-tab>"]   = actions.toggle_selection + actions.move_selection_worse,
                ["<tab>"]     = actions.toggle_selection + actions.move_selection_better,
                ["<c-n>"]     = actions.move_selection_next,
                ["<c-p>"]     = actions.move_selection_previous,
                ["gg"]        = actions.move_to_top,
                ["G"]         = actions.move_to_bottom,
                ["l"]         = actions.toggle_selection,
                ["<c-u>"]     = actions.preview_scrolling_up,
                ["<c-d>"]     = actions.preview_scrolling_down,
                ["?"]         = actions.which_key,
                ["<m-q>"]     = trouble.smart_open_with_trouble,
                ["<m-p>"]     = actions_layout.toggle_preview,
                ["<leader>f"] = function(prompt_bufnr)
                    local opts = {
                        callback = actions.toggle_selection,
                    }
                    require("telescope").extensions.hop._hop(prompt_bufnr, opts)
                end,
                ["<leader>F"] = function(prompt_bufnr)
                    local opts = {
                        callback = actions.toggle_selection,
                        loop_callback = trouble.smart_open_with_trouble,
                    }
                    require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
                end,
            },
        },
    },
    pickers = {
        find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden" },
        },
    },
    extensions = {
        frecency = {
            db_root = DATA_PATH .. "/databases",
            show_scores = true,
            show_unindexed = true,
            ignore_patterns = {"*.git/*", "*/tmp/*"},
            disable_devicons = false,
            workspaces = {
                ["Win petrosAth"] = "/mnt/c/Users/petrosAth",
                [".config"]       = "$HOME/.config",
                ["Projects"]      = "$HOME/Develop"
            }
        },
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "ignore_case",
        },
        hop = {
            -- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
            keys = {
                "a", "s", "d", "f", "g", "h", "j", "k", "l", ";",
                "q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
                "A", "S", "D", "F", "G", "H", "J", "K", "L", ":",
                "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
            },
            -- Highlight groups to link to signs and lines; the below configuration refers to demo
            -- sign_hl typically only defines foreground to possibly be combined with line_hl
            sign_hl = { "WarningMsg", "Title" },
            -- optional, typically a table of two highlight groups that are alternated between
            line_hl = { "CursorLine", "Normal" },
            -- options specific to `hop_loop`
            -- true temporarily disables Telescope selection highlighting
            clear_selection_hl = false,
            -- highlight hopped to entry with telescope selection highlight
            -- note: mutually exclusive with `clear_selection_hl`
            trace_entry = true,
            -- jump to entry where hoop loop was started from
            reset_selection = true,
        },
        project = {
            base_dirs = {
                { path = "$HOME/Develop",  max_depth = 3 },
            },
            hidden_files = true,
        },
    },
})

-- Load extensions
local extensions = { "frecency", "fzf", "hop", "project", "session-lens" }
pcall(function()
    for _, ext in ipairs(extensions) do
        telescope.load_extension(ext)
    end
end)
