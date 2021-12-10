local map = vim.api.nvim_set_keymap
local n_opts = { noremap = true }
local ne_opts = { noremap = true, expr = true }
local ns_opts = { noremap = true, silent = true }
local nse_opts = { noremap = true, silent = true, expr = true }

-- Open windows terminal terminal at cwd
map(
	"n",
	"<Leader><Leader>t",
	"<cmd>lua launch_ext_prog('wt.exe -d', string.format('\"%s\"', vim.fn.expand('%:p:h')))<CR>",
	ns_opts
)

-- Open explorer at cwd
map(
	"n",
	"<Leader><Leader>e",
	"<cmd>lua launch_ext_prog('explorer.exe', vim.fn.expand('%:p:h'))<CR>",
	ns_opts
)

-- Open current file in vscode
map("n", "<Leader><Leader>c", "<cmd>lua launch_ext_prog('code', '%')<CR>", ns_opts)

-- Replace word under cursor
map("n", "<F2>", [[:%s/\<<C-r><C-w>\>/]], n_opts)
map("v", "<F2>", [[y:%s/\V<C-r>"/]], n_opts)

-- Toggle relative number
map("n", "<Leader>n", "<cmd>set relativenumber!<CR>", ns_opts)

-- Toggle quickfix
-- map("n", "<Leader>q", "<cmd>QFix<CR>", ns_opts)

-- Format entire document
map("n", "<C-f>", "gg=G<C-o>zz<Esc>", ns_opts)

-- Toggle spell
map("n", "<F1>", "<cmd>setlocal spell!<CR>", ns_opts)
map("i", "<F1>", "<cmd>setlocal spell!<CR>", ns_opts)

-- Map $ to g_
map("n", "$", "g_", n_opts)
map("v", "$", "g_", n_opts)

-- Paste from system clipboard in insert/select mode
map("i", "<C-v>", "<C-R>+", n_opts)
map("s", "<C-v>", "<BS>i<C-R>+<Esc>", n_opts)

-- Toggle paste mode and paste from system clipboard
-- map("n", "<Leader>v", '<F12>"+P<F12>', n_opts)
-- map("i", "<Leader>v", '<ESC><F12>"+P<F12>i', n_opts)

-- Don't lose yanked string after paste
map("v", "<leader>p", '"_dP', n_opts)

-- Move to line end
map("i", "<C-a>", "<Esc>g_a", n_opts)

-- Display line movements
map("n", "j", "v:count == 0 ? 'gj' : 'j'", nse_opts)
map("n", "k", "v:count == 0 ? 'gk' : 'k'", nse_opts)
-- map("v", "j", "v:count == 0 ? 'gj' : 'j'", ne_opts)
-- map("v", "k", "v:count == 0 ? 'gk' : 'k'", ne_opts)

-- Fix accidental line joining during visual block selection
map("v", "J", "j", n_opts)
map("v", "K", "k", n_opts)

-- Correct previous bad word in insert mode
map("i", "<C-z>", "<C-g>u<Esc>[s1z=`]a<C-g>u", n_opts)
-- Correct word under cursor
map("n", "<C-z>", "1z=<Esc>", n_opts)

-- Delete previous word
map("i", "<C-BS>", "<C-w>", n_opts)
-- Delete next word
map("i", "<C-Del>", "<C-o>dW", n_opts)

-- Disable word search on shift mouse
map("", "<S-LeftMouse>", "<nop>", {})
map("", "<S-LeftDrag>", "<nop>", {})

-- Command mode movement
map("c", "<C-j>", "<C-n>", n_opts)
map("c", "<C-k>", "<C-p>", n_opts)
map("c", "<C-h>", "<Left>", n_opts)
map("c", "<C-l>", "<Right>", n_opts)

-- Move text
map("n", "<A-n>", ":m .+1<CR>==", n_opts)
map("n", "<A-p>", ":m .-2<CR>==", n_opts)
map("v", "<A-n>", ":m '>+1<CR>gv-gv", n_opts)
map("v", "<A-p>", ":m '<-2<CR>gv-gv", n_opts)

-- Toggle wrap
map("n", "<F11>", "<cmd>set wrap!<CR>", ns_opts)

-- Enter normal mode in terminal
map("t", "<Esc>", "<C-\\><C-n>", ns_opts)

-- Resize splits by 5 lines/rows if no [count] is given, else resize by [count]
map("n", "<A-j>", "v:count == 0 ? ':resize +5<CR>' : ':<C-u>resize +' . v:count1 . '<CR>'", nse_opts)
map("n", "<A-k>", "v:count == 0 ? ':resize -5<CR>' : ':<C-u>resize -' . v:count1 . '<CR>'", nse_opts)
map("n", "<A-h>", "v:count == 0 ? ':vertical resize +5<CR>' : ':<C-u>vertical resize +' . v:count1 . '<CR>'", nse_opts)
map("n", "<A-l>", "v:count == 0 ? ':vertical resize -5<CR>' : ':<C-u>vertical resize -' . v:count1 . '<CR>'", nse_opts)
-- Resize splits by [count] lines/rows
-- map("n", "<A-j>", "':<C-u>resize +' . v:count1 . '<CR>'", nse_opts)
-- map("n", "<A-k>", "':<C-u>resize -' . v:count1 . '<CR>'", nse_opts)
-- map("n", "<A-h>", "':<C-u>vertical resize +' . v:count1 . '<CR>'", nse_opts)
-- map("n", "<A-l>", "':<C-u>vertical resize -' . v:count1 . '<CR>'", nse_opts)

-- Navigate through buffers
map("n", "<Tab>n", ":bn<CR>", ns_opts)
map("n", "<Tab>p", ":bp<CR>", ns_opts)
map("n", "<Tab>d", ":Bdelete<CR>", ns_opts)
map("n", "g<Tab>", "<C-^>", ns_opts)

-- Navigate through tabs
map("n", "tn", ":tabnext<CR>", ns_opts)
map("n", "tp", ":tabprevious<CR>", ns_opts)
map("n", "td", ":tabclose<CR>", ns_opts)

-- "Undo chain" break points
local break_points = { ".", ",", "!", "?", "=", "-", "_" }
for _, v in pairs(break_points) do
	map("i", tostring(v), v .. "<C-g>u", n_opts)
end

map("n", "n", "nzz", n_opts)
map("n", "N", "Nzz", n_opts)
