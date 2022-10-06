local opt, o, g = vim.opt, vim.o, vim.g
local t = require("styling").variables.transparency
local i = require("styling").icons
local iUI = i.nvim_ui

local M = {}

M.fillchars = { -- Display chars
    horiz = iUI.horiz[1],
    horizup = iUI.horizup[1],
    horizdown = iUI.horizdown[1],
    vert = iUI.vert[1],
    vertleft = iUI.vertleft[1],
    vertright = iUI.vertright[1],
    verthoriz = iUI.verthoriz[1],
    fold = iUI.fold[1],
    foldopen = iUI.foldopen[1],
    foldclose = iUI.foldclose[1],
    foldsep = iUI.foldsep[1],
    diff = iUI.diff[1],
    msgsep = iUI.msgsep[1],
    eob = iUI.eob[1],
}

M.localFillchars = { -- Display chars
    horiz = iUI.horiz[1],
    horizup = iUI.horizup[1],
    horizdown = iUI.horizdown[1],
    vert = iUI.vert[1],
    vertleft = iUI.vertleft[1],
    vertright = iUI.vertright[1],
    verthoriz = iUI.verthoriz[1],
    fold = iUI.fold[1],
    foldopen = iUI.foldopen[1],
    foldclose = iUI.foldclose[1],
    foldsep = iUI.foldsep[1],
    diff = iUI.diff[1],
    msgsep = iUI.msgsep[1],
    eob = " ",
}

--<=< GUI general options >==========================================================================================>--
-- Set gui font for nvim-qt, neovide etc
opt.guifont = "Fira Code, Regular:h12"
--<==================================================================================================================>--

--<=< Neovide specific options  >====================================================================================>--
-- Setting refresh rate to a positive integer will set the refresh rate of the app.
g.neovide_refresh_rate = 60

-- Setting the value between 0.0 and 1.0 will set the opacity of the window to that value.
g.neovide_transparency = 0.90

-- Cursor Particles
g.neovide_cursor_vfx_mode = "wireframe" -- railgun torpedo pixiedust sonicboom ripple wireframe
--<==================================================================================================================>--

opt.completeopt = { "menu", "menuone", "noinsert" } -- A comma-separated list of options for Insert mode completion

opt.encoding = "utf-8" -- File encoding
opt.fileencoding = "utf-8 " -- File encoding
opt.fileformat = "dos" -- DOS fileformat

opt.background = "dark" -- Enable dark background colorschemes

opt.termguicolors = true -- Enable 24bit colors in terminal

opt.cmdheight = 1 -- Give more space for displaying messages

opt.shiftwidth = 4 -- Number of auto-indent spaces
opt.softtabstop = 4 -- Number of spaces per Tab
opt.tabstop = 4 -- Number of columns per tab
opt.expandtab = true -- Use spaces instead of tabs
opt.smarttab = true -- A <Tab> in front of a line inserts blanks according to 'shiftwidth'
opt.autoindent = true -- Auto-indent new lines
opt.smartindent = true -- Enable smart-indent

opt.showmatch = true -- Highlights matching brackets
opt.cursorline = true -- Highlight the text line of the cursor
opt.cursorcolumn = true -- Highlight the screen column of the cursor

opt.startofline = true -- Keep cursor at place if possible

-- Make the cursor blink
--opt.guicursor = {
--    "n-v-c:block",
--    "i-ci-ve:ver25",
--    "r-cr:hor20",
--    "o:hor50",
--    "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
--    "sm:block-blinkwait175-blinkoff150-blinkon175"
--}

opt.wrap = false -- No wrap

opt.ignorecase = true -- Always case-insensitive
opt.smartcase = true -- Enable smart-case search
opt.incsearch = true -- Searches for strings incrementally

opt.inccommand = "split" -- Create a split for items offscreen for search and replace

opt.number = true -- Show line numbers
opt.relativenumber = true -- Enable relative line numbers
opt.signcolumn = "yes" -- Keep the sign column always visible

opt.colorcolumn = "120" -- Show vertical line for text alignment

opt.foldcolumn = "1" -- Fold column size
opt.foldmethod = "indent" -- Folding configuration
opt.foldlevelstart = 3
opt.foldminlines = 1 -- Fold even single line

opt.list = true -- Display eol characters

opt.fillchars = M.fillchars
opt.listchars:append({
    tab = iUI.tab[1],
    lead = iUI.lead[1],
    trail = iUI.trail[1],
    eol = iUI.eol[1],
    extends = iUI.extends[1],
    precedes = iUI.precedes[1],
})

opt.spell = false
opt.spelllang = "en_us" -- Use en_us to spellcheck
opt.spelloptions = "camel" -- Treat parts of camelCase words as separate words

opt.showtabline = 2 -- tabline
opt.laststatus = 3 -- Statusline

opt.showmode = false -- Don't show mode in command line

opt.autoread = false -- Ask before reloading a file changed outside of Neovim

opt.splitright = true
opt.splitbelow = true
opt.equalalways = false -- When on, all the windows are automatically made the same size after splitting or closing a window

opt.conceallevel = 0 -- Don't hide (conceal) special symbols (like `` in markdown)

opt.lazyredraw = true -- No redraw during macro, regex execution

opt.mouse = "a" -- Enable mouse for normal and visual modes

opt.clipboard = "unnamedplus" -- Use system clipboard for copy/paste
opt.pastetoggle = "<F12>" -- Toggle paste mode

opt.scrolloff = 3 -- Minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 20 -- The minimal number of columns to scroll horizontally

opt.winblend = t -- Transparency for floating windows
opt.pumblend = t -- Transparency for the popup-menu

opt.keywordprg = ":help" -- Program to use for the K command

o.sessionoptions = "blank,curdir,help,tabpages,winsize,winpos,terminal" -- What to save with mksession command

opt.swapfile = false -- No swap file
opt.undofile = true -- Maintain undo history between sessions

local disabled_built_ins = { -- Disable builtin vim plugins
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

g.loaded_python_provider = 0 -- Disable Python2 support
g.loaded_perl_provider = 0 -- Disable perl provider
g.loaded_ruby_provider = 0 -- Disable ruby provider
g.loaded_node_provider = 0 -- Disable node provider

return M
