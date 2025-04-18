local opt = vim.opt
local g = vim.g
local t = USER.styling.variables.transparency
local i = USER.styling.icons

-- Neovim GUI's options like nvim-qt and Neovide
opt.guifont               = "Monospace"
g.neovide_refresh_rate    = 60          -- Setting refresh rate to a positive integer will set the refresh rate of the app
g.neovide_transparency    = 0.90        -- Setting the value between 0.0 and 1.0 will set the opacity of the window to that value
g.neovide_cursor_vfx_mode = "wireframe" -- Cursor Particles ( railgun torpedo pixiedust sonicboom ripple wireframe )

-- Neovim options
opt.exrc           = true               -- Load local configuration file (.nvim.lua, .nvimrc and .exrc files)
opt.swapfile       = false              -- Don't keep swap file
opt.undofile       = true               -- Maintain undo history between sessions
opt.sessionoptions = "curdir,globals,help,tabpages,winsize,winpos,terminal" -- mksession command's options list
opt.completeopt    = "menu,menuone,noinsert,noselect" -- A comma-separated list of options for Insert mode completion
opt.diffopt:append("vertical")          -- Start diff mode in vertical splits
opt.spell          = false
opt.spelllang      = "en_us"
opt.spelloptions   = "camel"            -- Treat parts of camelCase words as separate words
opt.encoding       = "utf-8"
opt.fileencoding   = "utf-8"
opt.ignorecase     = true               -- Always case-insensitive
opt.smartcase      = true               -- Enable smart-case search
opt.incsearch      = true               -- Searches for strings incrementally
opt.shiftwidth     = 4                  -- Number of auto-indent spaces
opt.softtabstop    = 4                  -- Number of spaces per Tab
opt.tabstop        = 4                  -- Number of columns per tab
opt.expandtab      = true               -- Use spaces instead of tabs
opt.smarttab       = true               -- A <Tab> in front of a line inserts blanks according to 'shiftwidth'
opt.autoindent     = true               -- Copy indent from current line when starting a new line
opt.smartindent    = true
opt.splitright     = true               -- Splitting a window will put the new window right of the current one
opt.splitbelow     = true               -- Splitting a window will put the new window below the current one
opt.splitkeep      = "screen"           -- On horizontal splits keep the top line the same
opt.inccommand     = "split"            -- Create a split for items offscreen for search and replace
opt.virtualedit    = "block"            -- Allow going past the end of line in visual block mode
opt.showmatch      = true               -- Highlights matching brackets
opt.wrap           = false              -- Visualy break long lines
opt.linebreak      = true               -- Wrap lines at specific characters instead of cutting words in the middle
opt.breakindent    = true               -- Wrapped lines follow parent indentation
opt.showtabline    = 1                  -- Always show tabline
opt.equalalways    = false              -- When on, all the windows are automatically made the same size after splitting or closing a window
opt.winblend       = t                  -- Transparency for floating windows
opt.pumblend       = t                  -- Transparency for the popup-menu
opt.scrolloff      = 3                  -- Minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff  = 10                 -- The minimal number of columns to scroll horizontally
opt.winwidth       = 28                 -- Active window width
opt.winheight      = 6                  -- Active window height
opt.winminwidth    = 2                  -- The minimal width of an inactive windo.
opt.winminheight   = 0                  -- The minimal height of an inactive window
opt.laststatus     = 3                  -- Always show a global status line of the active window
opt.cmdheight      = 1                  -- Give more space for displaying messages
opt.showmode       = false              -- Don't show mode in command line
opt.autoread       = false              -- Ask before reloading a file changed outside of Neovim
opt.lazyredraw     = true               -- No redraw during macro, regex execution
opt.updatetime     = 500                -- If this many milliseconds nothing is typed the swap file will be written to disk. Also used for the |CursorHold| autocommand event
opt.cursorline     = true               -- Highlight the text line of the cursor
opt.number         = true               -- Show line numbers
opt.relativenumber = true               -- Enable relative line numbers
opt.signcolumn     = "no"               -- Keep the sign column always visible
opt.foldmethod     = "expr"             -- Folding configuration
opt.foldexpr       = "nvim_treesitter#foldexpr()"
opt.foldcolumn     = "1"
opt.foldlevelstart = 99                 -- All folds below that level are closed on new buffers
opt.foldminlines   = 1                  -- Fold even single line
opt.colorcolumn    = "+1"
opt.textwidth      = 120
opt.list           = true               -- Display whitespace characters
opt.fillchars      = i.fillchars.global -- Characters to fill the statuslines, vertical separators and special lines in the window
opt.listchars      = i.listchars.global -- Strings to use in 'list' mode
opt.clipboard      = "unnamedplus"      -- Use system clipboard for copy/paste
opt.keywordprg     = ":help"            -- Program to use for the K command
opt.startofline    = true               -- Keep cursor at place if possible
opt.mouse          = "a"                -- Enable mouse for normal and visual modes
opt.guicursor      = {                  -- Make the cursor blink
    "n-v-c:block",
    "i-ci-ve:ver25",
    "r-cr:hor20",
    "o:hor50",
    "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
    "sm:block-blinkwait175-blinkoff150-blinkon175",
}
