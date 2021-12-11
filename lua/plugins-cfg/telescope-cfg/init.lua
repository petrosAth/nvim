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
				-- ["<C-j>"] = actions.move_selection_next,
				-- ["<C-k>"] = actions.move_selection_previous,
                ["<C-y>"] = actions.select_default,
				["<C-q>"] = actions.close,
				-- ["<Esc>"] = actions.close,
                -- ["<C-l>"] = actions.toggle_selection,
                -- ["<C-k>"] = actions.toggle_selection + actions.move_selection_worse,
                -- ["<C-j>"] = actions.toggle_selection + actions.move_selection_better,
                ["<M-q>"] = trouble.smart_open_with_trouble,
                ["<M-p>"] = actions_layout.toggle_preview,
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
                ["<M-p>"] = actions_layout.toggle_preview
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
local extensions = { "frecency", "fzf", "hop" }
pcall(function()
	for _, ext in ipairs(extensions) do
		telescope.load_extension(ext)
	end
end)

-- Telescope mappings
local map = vim.api.nvim_set_keymap
local ns_opts = { noremap = true, silent = true }
local builtin = "<cmd> lua require('telescope.builtin')."
local ext = "<cmd> lua require('telescope').extensions.hop"
local custom = "<cmd> lua require('plugins-cfg.telescope-cfg.customPickers')."

-- Searching -------------------------------------------------------------------
map("n", "<Space>sf",    custom  .. "find_files()<CR>",                ns_opts)
map("n", "<Space>sr",    custom  .. "find_recent()<CR>",               ns_opts)
map("n", "<Space>sg",    custom  .. "live_grep()<CR>",                 ns_opts)
map("n", "<Space>se",    custom  .. "file_browser()<CR>",              ns_opts)
map("n", "<Space>sp",    custom  .. "project()<CR>",                   ns_opts)

-- Navigation ------------------------------------------------------------------
map("n", "<Space><Tab>", custom  .. "buffers()<CR>",                   ns_opts)
map("n", "<Space>rs",    custom  .. "registers('small')<CR>",          ns_opts)
map("n", "<Space>rl",    custom  .. "registers('large')<CR>",          ns_opts)

-- LSP -------------------------------------------------------------------------
map("n", "<Space>tdd",   builtin .. "diagnostics()<CR>",  ns_opts)
map("n", "<Space>tdw",   builtin .. "lsp_workspace_diagnostics()<CR>", ns_opts)
map("n", "<Space>ta",    custom  .. "lsp_code_actions()<CR>",          ns_opts)
map("n", "<Space>tr",    custom  .. "lsp_references()<CR>",            ns_opts)
map("n", "<Space>td",    custom  .. "lsp_definitions()<CR>",           ns_opts)
map("n", "<Space>tt",    custom  .. "lsp_type_definitions()<CR>",      ns_opts)
map("n", "<Space>ti",    custom  .. "lsp_implementations()<CR>",       ns_opts)

-- Git -------------------------------------------------------------------------
map("n", "<Space>tg",    builtin .. "builtin()<CR>^git",                 ns_opts)

-- Miscellaneous ---------------------------------------------------------------
map("n", "<Space>hi",    builtin .. "highlights()<CR>",                ns_opts)
map("n", "<Space>he",    builtin .. "help_tags()<CR>",                 ns_opts)
map("n", "<Space>o",     builtin .. "vim_options()<CR>",               ns_opts)
map("n", "<Space>c",     builtin .. "commands()<CR>",                  ns_opts)
map("n", "<Space>tc",    builtin .. "builtin()<CR>",                   ns_opts)
map("n", "<Space>h",     builtin .. "command_history()<CR>",           ns_opts)
map("n", "<Space>.",     builtin .. "resume()<CR>",                    ns_opts)
