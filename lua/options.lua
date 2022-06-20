local opt, o, g = vim.opt, vim.o, vim.g
local t = require("styling").variables.transparency
local i = require("styling").icons
local iUI = i.nvim_ui

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

opt.completeopt = { 'menu', 'menuone', 'noinsert' } -- A comma-separated list of options for Insert mode completion

opt.encoding = "utf-8" -- File encoding
opt.fileencoding = "utf-8 " -- File encoding
opt.fileformat = "dos" -- DOS fileformat

opt.background = "dark" -- Enable dark background colorschemes

opt.termguicolors = true -- Enable 24bit colors in terminal

opt.cmdheight = 1 -- Give more space for displaying messages

opt.autoindent = true -- Auto-indent new lines
opt.smartindent = true -- Enable smart-indent

opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Number of auto-indent spaces
opt.softtabstop = 4 -- Number of spaces per Tab
opt.tabstop = 4 -- Number of columns per tab

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

opt.foldcolumn = "auto:9" -- Fold column
opt.foldmethod = "indent" -- Folding configuration

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

opt.list = true -- Display eol characters

opt.fillchars = { -- Display chars
    vert = iUI.vert[1],
    fold = iUI.fold[1],
    foldopen = iUI.foldopen[1],
    foldclose = iUI.foldclose[1],
    foldsep = iUI.foldsep[1],
    diff = iUI.diff[1],
    msgsep = iUI.msgsep[1],
    eob = iUI.eob[1],
}
opt.listchars:append({
    tab = iUI.tab[1],
    lead = iUI.lead[1],
    eol = iUI.eol[1],
    extends = iUI.extends[1],
    precedes = iUI.precedes[1],
})

opt.spell = false
opt.spelllang = "en_us" -- Use en_us to spellcheck

opt.laststatus = 2 -- Statusline

opt.showmode = false -- Don't show mode in command line

opt.autoread = false -- Ask before reloading a file changed outside of neovim

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

o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal" -- What to save with mksession command

opt.swapfile = false -- No swap file

opt.undofile = true -- Maintain undo history between sessions

g.python3_host_prog = vim.fn.trim(vim.fn.system("which python")) -- Python3 path

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
