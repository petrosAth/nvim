local opt, o, g = vim.opt, vim.o, vim.g
local ct = require("aesthetics").variables.transparency
local ci = require("aesthetics").icon
local cui = ci.nvim_ui
local M = {}

--<=< GUI general options >==========================================================================================>--
-- Set gui font for nvim-qt, neovide etc
opt.guifont = "FiraCode NF:h12"
--<==================================================================================================================>--

--<=< Neovide specific options  >====================================================================================>--
-- Setting refresh rate to a positive integer will set the refresh rate of the app.
g.neovide_refresh_rate = 60

-- Setting the value between 0.0 and 1.0 will set the opacity of the window to that value.
g.neovide_transparency = 0.97

-- Force neovide to redraw all the time. This can be a quick hack if animations appear to stop too early.
g.neovide_no_idle = true

-- Open neovide in windowed fullscreen mode
g.neovide_fullscreen = false

-- Remember Previous Window Size
g.neovide_remember_window_size = false

-- Determines the time it takes for the cursor to complete it's animation in seconds
g.neovide_cursor_animation_length = 0.15

-- Determines how much the trail of the cursor lags behind the front edge
g.neovide_cursor_trail_length = 0.8

-- Enables or disables antialiasing of the cursor quad. Disabling may fix some cursor visual issues
g.neovide_cursor_antialiasing = false

-- Cursor Particles
g.neovide_cursor_vfx_mode = "wireframe" -- railgun torpedo pixiedust sonicboom ripple wireframe
--<==================================================================================================================>--

-- Syntax highlighting
opt.syntax = "on"

-- File encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8 "

-- DOS fileformat
opt.fileformat = "dos"

-- Enable dark background colorschemes
opt.background = "dark"

-- Enable 24bit colors in terminal
opt.termguicolors = true

-- Give more space for displaying messages
opt.cmdheight = 1

-- Auto-indent new lines
opt.autoindent = true
-- Enable smart-indent
opt.smartindent = true

-- Use spaces instead of tabs
opt.expandtab = true
-- Number of auto-indent spaces
opt.shiftwidth = 4
-- Number of spaces per Tab
opt.softtabstop = 4
-- Number of columns per tab
opt.tabstop = 4

-- Highlights matching brackets
opt.showmatch = true
-- Highlights the current line
opt.cursorline = false

-- Keep cursor at place if possible
opt.startofline = true

-- Make the cursor blink
--opt.guicursor = {
--    "n-v-c:block",
--    "i-ci-ve:ver25",
--    "r-cr:hor20",
--    "o:hor50",
--    "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
--    "sm:block-blinkwait175-blinkoff150-blinkon175"
--}

-- No wrap
opt.wrap = false

-- Always case-insensitive
opt.ignorecase = true
-- Enable smart-case search
opt.smartcase = true
-- Searches for strings incrementally
opt.incsearch = true

-- Create a split for items offscreen for search and replace
opt.inccommand = "split"

-- Show line numbers
opt.number = true
-- Enable relative line numbers
opt.relativenumber = true
-- Keep the sign column always visible
opt.signcolumn = "yes"

-- Show vertical line for text alignment
opt.colorcolumn = "80"

-- Draw colored column one step to the right of desired maximum width
vim.opt.colorcolumn = "+1"

-- Fold column
opt.foldcolumn = "auto:9"

-- Folding configuration
opt.foldmethod = "indent"

-- Expr folding using treesitter
-- reddit comment: https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]

-- Manual folding using custom fold text from file
-- opt.foldmethod = "marker"
-- opt.foldtext = "v:lua.custom_fold_text()"

opt.foldlevelstart = 99

opt.foldminlines = 1

opt.viewoptions:remove("options")

-- Display eol characters
opt.list = true

-- Display chars
opt.fillchars = {
    vert = cui.vert[1],
    fold = cui.fold[1],
    foldopen = cui.foldopen[1],
    foldclose = cui.foldclose[1],
    foldsep = cui.foldsep[1],
    msgsep = cui.msgsep[1],
    eob = cui.eob[1],
}
opt.listchars:append({
    tab = cui.tab[1],
    lead = cui.lead[1],
    eol = cui.eol[1]
})

-- Use en_us to spellcheck
opt.spell = false
opt.spelllang = "en_us"

-- Statusline
opt.laststatus = 2

-- Don't show mode in command line
vim.opt.showmode = false

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Don't hide (conceal) special symbols (like `` in markdown)
opt.conceallevel  = 0

-- No redraw during macro, regex execution
opt.lazyredraw = true

-- Enable mouse for normal and visual modes
opt.mouse = "a"

-- Use system clipboard for copy/paste
opt.clipboard = "unnamedplus"

-- Toggle paste mode
opt.pastetoggle = "<F12>"

-- Minimal number of screen lines to keep above and below the cursor
opt.scrolloff = 3
-- The minimal number of columns to scroll horizontally
opt.sidescrolloff = 5

-- Transparency for floating windows
opt.winblend = ct
-- Transparency for the popup-menu
opt.pumblend = ct

-- Program to use for the K command
opt.keywordprg = ":help"

-- What to save with mksession command
o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- No swap file
opt.swapfile = false

-- Maintain undo history between sessions
opt.undofile = true

-- Python3 path
g.python3_host_prog = vim.fn.trim(vim.fn.system("which python"))

-- Disable builtin vim plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end

-- Disable Python2 support
g.loaded_python_provider = 0

-- Disable perl provider
g.loaded_perl_provider = 0

-- Disable ruby provider
g.loaded_ruby_provider = 0

-- Disable node provider
g.loaded_node_provider = 0

return M
