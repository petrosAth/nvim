local hydra = require("hydra")
hydra({
    name = "Side scroll",
    config = {
        hint = false,
    },
    mode = "n",
    body = "z",
    heads = {
        { "h", "v:count == 0 ? '5zh' : v:count1 . 'zh'", { expr = true } },
        { "l", "v:count == 0 ? '5zl' : v:count1 . 'zl'", { expr = true } },
        { "H", "zH" },
        { "L", "zL" },
    },
})
hydra({
    name = "Change / Resize Window",
    mode = { "n" },
    body = "<C-w>",
    config = {
        hint = false,
    },
    heads = {
        { "<C-j>", "<C-w>j" },
        { "<C-k>", "<C-w>k" },
        { "<C-h>", "<C-w>h" },
        { "<C-l>", "<C-w>l" },
        { "<M-k>", "v:count == 0 ? ':resize -2<CR>' : ':<C-u>resize -' . v:count1 . '<CR>'",                   { expr = true }, },
        { "<M-j>", "v:count == 0 ? ':resize +2<CR>' : ':<C-u>resize +' . v:count1 . '<CR>'",                   { expr = true }, },
        { "<M-h>", "v:count == 0 ? ':vertical resize +5<CR>' : ':<C-u>vertical resize +' . v:count1 . '<CR>'", { expr = true }, },
        { "<M-l>", "v:count == 0 ? ':vertical resize -5<CR>' : ':<C-u>vertical resize -' . v:count1 . '<CR>'", { expr = true }, },
    },
})
hydra({
    name = "Next",
    mode = { "n" },
    body = "]",
    config = {
        hint = false,
    },
    heads = {
        { "b", "<CMD>bn<CR>",                                  { desc = "Next buffer"                       } },
        { "c", "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", { desc = "Next git hunk",       expr =  true } },
        { "d", "<CMD>lua vim.diagnostic.goto_next()<CR>",      { desc = "Next diagnostic"                   } },
        { "s", "]s",                                           { desc = "Next misspelled word"              } },
        { "t", "<CMD>tabnext<CR>",                             { desc = "Next tab"                          } },
    },
})
hydra({
    name = "Previous",
    mode = { "n" },
    body = "[",
    config = {
        hint = false,
    },
    heads = {
        { "b", "<CMD>bp<CR>",                                  { desc = "Previous buffer"                       } },
        { "c", "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", { desc = "Previous git hunk",       expr =  true } },
        { "d", "<CMD>lua vim.diagnostic.goto_prev()<CR>",      { desc = "Previous diagnostic"                   } },
        { "s", "]s",                                           { desc = "Previous misspelled word"              } },
        { "t", "<CMD>tabprevious<CR>",                         { desc = "Previous tab"                          } },
    },
})
