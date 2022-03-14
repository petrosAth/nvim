local g = vim.g
local ci = require("aesthetics").icon

vim.cmd([[
    augroup NVIMTREE
        autocmd!
        autocmd BufEnter NvimTree_* setlocal fillchars+=eob:\ "
        autocmd FileType NvimTree setlocal fillchars+=eob:\ "
    augroup END
]])

g.nvim_tree_show_icons = {
    git = 1,            -- If 0, do not show the icons for one of 'git' 'folder' and 'files'
    folders = 1,        -- 1 by default, notice that if 'files' is 1, it will only display
    files = 1,          -- if nvim-web-devicons is installed and on your runtimepath.
    folder_arrows = 1,  -- if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
}                       -- but this will not work when you set indent_markers (because of UI conflict)
g.nvim_tree_indent_markers = 0          -- 0 by default, this option shows indent markers when folders are open
g.nvim_tree_highlight_opened_files = 3  -- 0 by default, Highlight icons and/or names for opened files and directories
g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged  = ci.edit[1], -- ci.pending[1],
        staged    = ci.done[1], -- ci.done[1],
        unmerged  = "",
        renamed   = ci.arrowr[1],
        untracked = ci.pending[1], -- ci.def[2],
        deleted   = ci.delete[1], -- ci.delete[1],
        ignored   = ci.def[1]
    },
        folder = {
        arrow_open   = ci.folderop[1],
        arrow_closed = ci.foldercl[1],
        default      = " ",
        open         = " ",
        empty        = " ",
        empty_open   = " ",
        symlink      = " ",
        symlink_open = " ",
    }
}
-- g.nvim_tree_git_hl = 0                   -- 0 by default, will enable file highlight for git attributes (can be used without the icons)
g.nvim_tree_root_folder_modifier = ":t"     -- In what format to show root folder. See `:help filename-modifiers` for available options. Default is `:~`
-- g.nvim_tree_add_trailing = 0             -- 0 by default, append a trailing slash to folder names
g.nvim_tree_group_empty = 1              -- 0 by default, compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_icon_padding = " "           -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
g.nvim_tree_symlink_arrow = " " .. ci.arrowr[1] .. " " -- defaults to ' ➛ '. used as a separator between symlinks' source and target.
-- g.nvim_tree_respect_buf_cwd = 1          -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
-- g.nvim_tree_create_in_closed_folder = 1  -- 1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
-- g.nvim_tree_refresh_wait = 500           -- 1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.

local tree = require("nvim-tree")

tree.setup({
	disable_netrw = true, -- disables netrw completely
	hijack_netrw = true, -- hijack netrw window on startup
	open_on_setup = true, -- open the tree when running this setup function
    -- ignore_buffer_on_setup = false, -- will ignore the buffer, when deciding to open the tree on setup
	-- ignore_ft_on_setup = {
        -- "help",
        -- "git",
        -- ".cache",
        -- python
        -- "__pycache__",
    -- }, -- will not open on setup if the filetype is in this list
	-- auto_close = false, -- closes neovim automatically when the tree is the last **WINDOW** in the view
	-- open_on_tab = false, -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    hijack_unnamed_buffer_when_opening = false, -- opens in place of the unnamed buffer if it's empty
    hijack_directories = { -- hijacks new directory buffers when they are opened (`:e dir`)
		enable = true, -- enable the feature
		auto_open = false, -- allow to open the tree if it was previously closed
    },
	hijack_cursor = true, -- hijack the cursor in the tree to put it at the start of the filename
	update_cwd = true, -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
	update_focused_file = { -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
		enable = true, -- enables the feature
		update_cwd = false, -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
                           -- only relevant when `update_focused_file.enable` is true
		ignore_list = {}, -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
                          -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
	},
	diagnostics = { -- show lsp diagnostics in the signcolumn
		enable = true,
        show_on_dirs = true, -- if the node with diagnostic is not visible, then show diagnostic in the parent directory
		icons = {
			hint = ci.hint[1],
			info = ci.info[1],
			warning = ci.warn[1],
			error = ci.error[1],
		},
	},
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
	view = {
        -- hide_root_folder = false,
		width = 40, -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
		height = 15, -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
		side = "left", -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
		preserve_window_proportions = true, -- preserve window proportions when opening a file
        -- number = false, -- print the line number in front of each line
        relativenumber = true, -- show the line number relative to the line with the cursor in front of each line
        -- signcolumn = "yes", -- show diagnostic sign column. Value can be `"yes"`
		mappings = {
			custom_only = true, -- custom only false will merge the list with the default mappings
                                -- if true, it will only use your list to set the mappings
			list = { -- list of mappings to set on the tree manually
                { key = {"l", "<CR>", "<2-LeftMouse>"}, action = "edit" },
                { key = "<C-y>",                        action = "edit_in_place" },
                -- { key = "<C-Y>",                        action = "edit_no_picker" },
                { key = {"L", "<2-RightMouse>"},        action = "cd" },
                { key = "<C-v>",                        action = "vsplit" },
                { key = "<C-s>",                        action = "split" },
                { key = "<C-t>",                        action = "tabnew" },
                { key = "<",                            action = "prev_sibling" },
                { key = ">",                            action = "next_sibling" },
                { key = "P",                            action = "parent_node" },
                { key = "h",                            action = "close_node" },
                { key = "<C-l>",                        action = "preview" },
                { key = "K",                            action = "first_sibling" },
                { key = "J",                            action = "last_sibling" },
                { key = "I",                            action = "toggle_ignored" },
                { key = "<C-h>",                        action = "toggle_dotfiles" },
                { key = "r",                            action = "refresh" },
                { key = "a",                            action = "create" },
                { key = "D",                            action = "remove" },
                { key = "d",                            action = "trash" },
                { key = "R",                            action = "rename" },
                { key = "<C-r>",                        action = "full_rename" },
                { key = "X",                            action = "cut" },
                { key = "c",                            action = "copy" },
                { key = "p",                            action = "paste" },
                { key = "y",                            action = "copy_name" },
                { key = "Y",                            action = "copy_path" },
                { key = "gy",                           action = "copy_absolute_path" },
                { key = "[c",                           action = "prev_git_item" },
                { key = "]c",                           action = "next_git_item" },
                { key = "-",                            action = "dir_up" },
                { key = "s",                            action = "system_open" },
                { key = "q",                            action = "close" },
                { key = "?",                            action = "toggle_help" },
                { key = 'H',                            action = "collapse_all" },
                { key = "<C-f>",                        action = "search_node" },
                { key = ".",                            action = "run_file_command" },
                { key = "<C-k>",                        action = "show_file_info" }
            },
		},
	},
	-- system_open = { -- configuration options for the system open command (`s` in the tree by default)
	-- 	cmd = nil, -- the command to run this, leaving nil should work in most cases
	-- 	args = {}, -- the command arguments as a list
	-- },
    -- filters = {
    --     dotfiles = false, -- do not show `dotfiles` (files starting with a `.`)
    --     custom = {}, -- custom list of string that will not be shown
    --     exclude = {}, -- list of directories or files to exclude from filtering
    -- },
    trash = {
        cmd = "trash-put",
        require_confirm = true
    },
    actions = {
        enable = true, -- change the working directory when changing directories in the tree
        -- global = false, -- use `:cd` instead of `:lcd` when changing directories
        quit_on_open = false, -- closes the explorer when opening a file. It will also disable preventing a buffer overriding the tree
        window_picker = {
            enable = true,
            nvim_tree_window_picker_chars = "asdghklqwertyuiopzxcvbnmfj'",
            filetype = { -- indicates to the window picker that the buffer's window should not be
                "alpha",
                "diff",
                "help",
                "lsp-installer",
                "minimap",
                "Outline",
                "packer",
                "qf",
                "Trouble",
                "undotree"
            },
			buftype  = { "nofile", "terminal", "help", }
        }
    }
})
