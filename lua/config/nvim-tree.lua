-- Automatically refresh the tree after opening a new file
-- Ensures that the file is highlighted correctly in the tree when
-- opened using telescope or netrw
vim.cmd([[
    augroup NVIMTREE
        autocmd!
        autocmd BufEnter NvimTree setlocal fillchars+=eob:\ "
        autocmd BufEnter,BufNewFile,BufReadPost,BufWinEnter,BufWinLeave * NvimTreeRefresh
    augroup END
]])

local g = vim.g
local ci = require("cosmetics").icon

g.nvim_tree_quit_on_open = 0            -- 0 by default, closes the tree when you open a file
g.nvim_tree_indent_markers = 0          -- 0 by default, this option shows indent markers when folders are open
g.nvim_tree_git_hl = 0                  -- 0 by default, will enable file highlight for git attributes (can be used without the icons)
g.nvim_tree_highlight_opened_files = 3  -- 0 by default, Highlight icons and/or names for opened files and directories
g.nvim_tree_root_folder_modifier = ":t"
g.nvim_tree_add_trailing = 0            -- 0 by default, append a trailing slash to folder names
g.nvim_tree_group_empty = 1             -- 0 by default, compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_disable_window_picker = 0   -- 0 by default, will disable the window picker.
g.nvim_tree_icon_padding = " "          -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
g.nvim_tree_symlink_arrow = " >> "      -- defaults to ' ➛ '. used as a separator between symlinks' source and target.
g.nvim_tree_respect_buf_cwd = 0         -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
g.nvim_tree_create_in_closed_folder = 0 -- 1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
g.nvim_tree_refresh_wait = 500          -- 1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
g.nvim_tree_window_picker_chars = "asdghklqwertyuiopzxcvbnmfj'"
g.nvim_tree_window_picker_exclude = {   -- Dictionary of buffer option names mapped to a list of option values that
    filetype = {                        -- indicates to the window picker that the buffer's window should not be
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
    buftype = { "terminal" },
}
g.nvim_tree_show_icons = {
    git = 1,            -- If 0, do not show the icons for one of 'git' 'folder' and 'files'
    folders = 1,        -- 1 by default, notice that if 'files' is 1, it will only display
    files = 1,          -- if nvim-web-devicons is installed and on your runtimepath.
    folder_arrows = 1,  -- if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
}                       -- but this will not work when you set indent_markers (because of UI conflict)
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
    },
        folder = {
        arrow_open   = ci.folderop[1],
        arrow_closed = ci.foldercl[1],
        default      = "",
        open         = "",
        empty        = "",
        empty_open   = "",
        symlink      = "",
        symlink_open = "",
    }
}

local tree = require("nvim-tree")
local tree_cb = require("nvim-tree.config").nvim_tree_callback

tree.setup({
	disable_netrw = true, -- disables netrw completely
	hijack_netrw = true, -- hijack netrw window on startup
	open_on_setup = true, -- open the tree when running this setup function
-- 	ignore_ft_on_setup = {
--         "help",
--         "git",
--         ".cache",
--         -- python
--         "__pycache__",
--     }, -- will not open on setup if the filetype is in this list
	auto_close = true, -- closes neovim automatically when the tree is the last **WINDOW** in the view
	open_on_tab = false, -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
	hijack_cursor = true, -- hijack the cursor in the tree to put it at the start of the filename
	update_cwd = false, -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
	update_to_buf_dir = { -- hijacks new directory buffers when they are opened.
		enable = true, -- enable the feature
		auto_open = false, -- allow to open the tree if it was previously closed
	},
	diagnostics = { -- show lsp diagnostics in the signcolumn
		enable = false,
		icons = {
			hint = ci.hint[1],
			info = ci.info[1],
			warning = ci.warn[1],
			error = ci.error[1],
		},
	},
	update_focused_file = { -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
		enable = true, -- enables the feature
		update_cwd = false, -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
                           -- only relevant when `update_focused_file.enable` is true
		ignore_list = {}, -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
                          -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
	},
	system_open = { -- configuration options for the system open command (`s` in the tree by default)
		cmd = nil, -- the command to run this, leaving nil should work in most cases
		args = {}, -- the command arguments as a list
	},
    filters = {
        dotfiles = false,
        custom = {}
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
	view = {
		width = 40, -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
		height = 15, -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
        hide_root_folder = false,
		side = "left", -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
		auto_resize = false, -- if true the tree will resize itself after opening a file
		mappings = {
			custom_only = true, -- custom only false will merge the list with the default mappings
                                -- if true, it will only use your list to set the mappings
			list = { -- list of mappings to set on the tree manually
                { key = {"<CR>", "<2-LeftMouse>"}, cb = tree_cb("edit") },
                { key = {"<2-RightMouse>", "L"},   cb = tree_cb("cd") },
                { key = "<C-v>",                   cb = tree_cb("vsplit") },
                { key = "<C-s>",                   cb = tree_cb("split") },
                { key = "<C-t>",                   cb = tree_cb("tabnew") },
                { key = "<",                       cb = tree_cb("prev_sibling") },
                { key = ">",                       cb = tree_cb("next_sibling") },
                { key = "P",                       cb = tree_cb("parent_node") },
                { key = "h",                       cb = tree_cb("close_node") },
                { key = "l",                       cb = tree_cb("preview") },
                { key = "K",                       cb = tree_cb("first_sibling") },
                { key = "J",                       cb = tree_cb("last_sibling") },
                { key = "I",                       cb = tree_cb("toggle_ignored") },
                { key = "H",                       cb = tree_cb("toggle_dotfiles") },
                { key = "r",                       cb = tree_cb("refresh") },
                { key = "a",                       cb = tree_cb("create") },
                { key = "d",                       cb = tree_cb("trash") },
                { key = "D",                       cb = tree_cb("remove") },
                { key = "R",                       cb = tree_cb("rename") },
                { key = "<C-r>",                   cb = tree_cb("full_rename") },
                { key = "X",                       cb = tree_cb("cut") },
                { key = "c",                       cb = tree_cb("copy") },
                { key = "p",                       cb = tree_cb("paste") },
                { key = "y",                       cb = tree_cb("copy_name") },
                { key = "Y",                       cb = tree_cb("copy_path") },
                { key = "gy",                      cb = tree_cb("copy_absolute_path") },
                { key = "[c",                      cb = tree_cb("prev_git_item") },
                { key = "]c",                      cb = tree_cb("next_git_item") },
                { key = "-",                       cb = tree_cb("dir_up") },
                { key = "s",                       cb = tree_cb("system_open") },
                { key = "q",                       cb = tree_cb("close") },
                { key = "?",                      cb = tree_cb("toggle_help") },
            },
		},
        number = false,
        relativenumber = true,
        signcolumn = "no"
	},
    trash = {
        cmd = "trash",
        require_confirm = true
    }
})
