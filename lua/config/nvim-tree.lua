local tree = require("nvim-tree")
local i = require("styling").icon

vim.cmd([[
    augroup NVIMTREE
        autocmd!
        autocmd BufEnter NvimTree_* setlocal fillchars+=eob:\ "
        autocmd FileType NvimTree setlocal fillchars+=eob:\ "
    augroup END
]])

tree.setup({
    auto_reload_on_write = true,
    create_in_closed_folder = true, -- 1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
	disable_netrw = true, -- disables netrw completely
	hijack_cursor = true, -- hijack the cursor in the tree to put it at the start of the filename
	hijack_netrw = true, -- hijack netrw window on startup
    hijack_unnamed_buffer_when_opening = false, -- opens in place of the unnamed buffer if it's empty
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
    hijack_directories = { -- hijacks new directory buffers when they are opened (`:e dir`)
		enable = true, -- enable the feature
		auto_open = false, -- allow to open the tree if it was previously closed
    },
	update_cwd = true, -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    reload_on_bufenter = false,
    respect_buf_cwd = false, -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
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
			hint = i.hint[1],
			info = i.info[1],
			warning = i.warn[1],
			error = i.error[1],
		},
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
                { key = "y",                            action = "copy" },
                { key = "p",                            action = "paste" },
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
    renderer = {
        add_trailing = false, -- false by default, append a trailing slash to folder names
        group_empty = false, -- false by default, compact folders that only contain a single folder into one node in the file tree
        highlight_git = false, -- 0 by default, will enable file highlight for git attributes (can be used without the icons)
        highlight_opened_files = "all", -- "none" by default, Highlight icons and/or names for opened files. Value can be `"none"`, `"icon"`, `"name"` or `"all"`.
        root_folder_modifier = ":t",    -- In what format to show root folder. See `:help filename-modifiers` for available options. Default is `:~`
        indent_markers = {
            enable = false,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
        icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ", -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
            symlink_arrow  = " " .. i.arrowr[4] .. " ", -- defaults to ' ➛ '. used as a separator between symlinks' source and target.
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_closed = i.foldercl[1],
                    arrow_open   = i.folderop[1],
                    default      = "",
                    open         = "",
                    empty        = "",
                    empty_open   = "",
                    symlink      = "",
                    symlink_open = "",
                },
                git = {
                    unstaged  = i.edit[1],
                    staged    = i.done[1],
                    unmerged  = "",
                    renamed   = i.arrowr[1],
                    untracked = i.pending[1],
                    deleted   = i.delete[1],
                    ignored   = ""
                },
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
        change_dir = {
            enable = true, -- change the working directory when changing directories in the tree
            global = false, -- use `:cd` instead of `:lcd` when changing directories
            restrict_above_cwd = false -- restrict changing to a directory above the global current working directory
        },
        open_file = {
            quit_on_open = false, -- closes the explorer when opening a file. It will also disable preventing a buffer overriding the tree
            resize_window = false, -- resizes the tree when opening a file
            window_picker = {
                enable = true,
                chars = "asdghklqwertyuiopzxcvbnmfj'",
                exclude = {
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
        }
    }
})
