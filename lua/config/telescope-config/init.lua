local telescope = require("telescope")
local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local trouble = require("trouble.providers.telescope")
local fb_actions = require("telescope").extensions.file_browser.actions
local c = require("config.telescope-config.customPickers")
local ws = c.window_size
local i = USER.styling.icons
local b = USER.styling.borders.default
local bn = USER.styling.borders.none

telescope.setup({
    defaults = {
        prompt_prefix = " " .. i.search[1] .. "  ",
        selection_caret = i.point[1] .. " ",
        multi_icon = " " .. i.select[1],
        entry_prefix = "  ",
        winblend = USER.styling.variables.transparency,
        color_devicons = true,
        border = true,
        borderchars = {
            --  prompt  = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   }
            prompt = { bn.t, b.r, b.b, b.l, b.l, b.r, b.br, b.bl },
            --  results = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   },
            results = { b.t, b.r, b.b, b.l, b.tl, b.tr, b.br, b.bl },
            --  preview = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   },
            preview = { b.t, b.r, b.b, b.l, b.tl, b.tr, b.br, b.bl },
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
                preview_width = 0.6,
                width = ws.width.large,
                height = ws.height.large,
            },
            vertical = {
                mirror = false,
                preview_height = 0.4,
                width = ws.width.medium,
                height = ws.height.medium,
            },
        },
        selection_strategy = "reset",
        sorting_strategy = "descending",
        file_ignore_patterns = { "^.git", "tags" },
        history = {
            path = USER.data_path .. "/databases/telescope_history",
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
                ["<M-q>F"] = trouble.smart_open_with_trouble,
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
                ["qF"] = trouble.smart_open_with_trouble,
                ["p"] = actions_layout.toggle_preview,
                ["f"] = function(prompt_bufnr)
                    local opts = {
                        callback = actions.toggle_selection,
                    }
                    require("telescope").extensions.hop._hop(prompt_bufnr, opts)
                end,
                ["F"] = function(prompt_bufnr)
                    local opts = {
                        callback = actions.toggle_selection,
                        loop_callback = trouble.smart_open_with_trouble,
                    }
                    require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
                end,
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
            db_root = USER.data_path .. "/databases",
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
        hop = {
            -- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
            keys = {
                "a",
                "s",
                "d",
                "f",
                "g",
                "h",
                "j",
                "k",
                "l",
                ";",
                "q",
                "w",
                "e",
                "r",
                "t",
                "y",
                "u",
                "i",
                "o",
                "p",
                "A",
                "S",
                "D",
                "F",
                "G",
                "H",
                "J",
                "K",
                "L",
                ":",
                "Q",
                "W",
                "E",
                "R",
                "T",
                "Y",
                "U",
                "I",
                "O",
                "P",
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
    },
})

-- Load extensions
local extensions = { "file_browser", "frecency", "fzf", "hop", "luasnip", "possession" }
pcall(function()
    for _, ext in ipairs(extensions) do
        telescope.load_extension(ext)
    end
end)
