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
        -- move between windows
        { "<C-j>", "<C-w>j" },
        { "<C-k>", "<C-w>k" },
        { "<C-h>", "<C-w>h" },
        { "<C-l>", "<C-w>l" },
        -- resize window
        { "<M-k>", "v:count == 0 ? ':resize -2<CR>' : ':<C-u>resize -' . v:count1 . '<CR>'",                   { expr = true }, },
        { "<M-j>", "v:count == 0 ? ':resize +2<CR>' : ':<C-u>resize +' . v:count1 . '<CR>'",                   { expr = true }, },
        { "<M-h>", "v:count == 0 ? ':vertical resize +5<CR>' : ':<C-u>vertical resize +' . v:count1 . '<CR>'", { expr = true }, },
        { "<M-l>", "v:count == 0 ? ':vertical resize -5<CR>' : ':<C-u>vertical resize -' . v:count1 . '<CR>'", { expr = true }, },
    },
})
