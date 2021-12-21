local telescope = require("telescope")
local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local custom_pickers = require("plugins-cfg.telescope-cfg.customPickers")
local trouble = require("trouble.providers.telescope")
local ct = require("cosmetics").variables.transparency
local ci = require("cosmetics").icon

telescope.setup({
	defaults = {
        prompt_prefix = ci.prompt[1] .. " ",
		selection_caret = ci.arrowr[1] .. " ",
        entry_prefix = "  ",
        winblend = ct,
        color_devicons = true,
        border = true,
        borderchars = custom_pickers.borderchars,
        initial_mode = "insert",
        path_display = {
            -- truncate = 3
            -- "smart"
            shorten = { len = 1, exclude = { -1, -2, -3, -4 } }
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
            "--trim" -- Remove indentation
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
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		gflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-s>"] = actions.select_horizontal,
                ["<C-c>"] = false,
                ["<C-y>"] = actions.select_default,
				["<C-q>"] = actions.close,
                ["<M-q>"] = trouble.smart_open_with_trouble,
                ["<M-p>"] = actions_layout.toggle_preview,
                ["<Leader>f"] = function(prompt_bufnr)
                    local opts = {
                        callback = actions.toggle_selection,
                    }
                    require("telescope").extensions.hop._hop(prompt_bufnr, opts)
                end,
                ["<Leader>F"] = function(prompt_bufnr)
                    local opts = {
                        callback = actions.toggle_selection,
                        loop_callback = trouble.smart_open_with_trouble,
                    }
                    require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
                end,
			},
			n = {
				["<C-n>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				["<C-x>"] = false,
				["<C-s>"] = actions.select_horizontal,
                ["l"]     = actions.toggle_selection,
                ["<C-k>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<C-j>"] = actions.toggle_selection + actions.move_selection_better,
                ["<M-q>"] = trouble.smart_open_with_trouble,
                ["<M-p>"] = actions_layout.toggle_preview,
                ["<Leader>f"] = function(prompt_bufnr)
                    local opts = {
                        callback = actions.toggle_selection,
                    }
                    require("telescope").extensions.hop._hop(prompt_bufnr, opts)
                end,
                ["<Leader>F"] = function(prompt_bufnr)
                    local opts = {
                        callback = actions.toggle_selection,
                        loop_callback = trouble.smart_open_with_trouble,
                    }
                    require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
                end,
			},
		},
	},
	extensions = {
		frecency = {
            db_root = vim.fn.stdpath("data"),
            show_scores = true,
            show_unindexed = true,
            ignore_patterns = {"*.git/*", "*/tmp/*"},
            disable_devicons = false,
            workspaces = {
                [".config"]     = "$HOME\\.config",
                ["nvim config"] = vim.fn.stdpath("config"),
                ["nvim data"]   = vim.fn.stdpath("data"),
                ["projects"]    = "H:\\Projects",
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
            -- base_dirs = {
            --     {path = "H:\\Projects", max_depth = 2},
            --     {path = "H:\\Projects\\Learning", max_depth = 5},
            -- },
            hidden_files = false,
        }
	},
})

-- Load extensions
local extensions = { "frecency", "fzf", "hop", "project" }
pcall(function()
	for _, ext in ipairs(extensions) do
		telescope.load_extension(ext)
	end
end)
