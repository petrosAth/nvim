local hydra = require("hydra")
local b = require("styling").borders.default
local border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l }

hydra({
    name = "Side scroll",
    hint = [[
   _h_  Scroll to the left     _H_  Scroll half screen to the left
   _l_  Scroll to the right    _L_  Scroll half screen to the right   ]],
    mode = { "n", "x" },
    body = "z",
    config = {
        hint = {
            position = "top",
            offset = 2,
            border = border,
        },
    },
    heads = {
        { "h", "zh" },
        { "l", "zl" },

        { "H", "zH" },
        { "L", "zL" },

        { "q",     nil, { exit = true, nowait = true, desc = false } },
        { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
})
hydra({
    name = "Windows navigation",
    hint = [[
   _<C-k>_  Go to the upper window   _<C-l>_  Go to the right window
   _<C-j>_  Go to the lower window   _<C-h>_  Go to the left window   ]],
    mode = { "n" },
    body = "<C-w>",
    config = {
        hint = {
            position = "top",
            offset = 2,
            border = border,
        },
    },
    heads = {
        { "<C-j>", "<C-w>j" },
        { "<C-k>", "<C-w>k" },
        { "<C-h>", "<C-w>h" },
        { "<C-l>", "<C-w>l" },

        { "q",     nil, { exit = true, nowait = true, desc = false } },
        { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
})
hydra({
    name = "Resize Window",
    hint = [[
   _K_ / _k_  Increase height by 1 / 3      _H_ / _h_  Increase width by 1 / 5
   _J_ / _j_  Decrease height by 1 / 3      _L_ / _l_  Decrease width by 1 / 5   ]],
    mode = { "n", "x" },
    body = "<M-w>",
    config = {
        hint = {
            position = "top",
            offset = 2,
            border = border,
        },
        invoke_on_body = true,
    },
    heads = {
        { "K", "<C-w>+" },
        { "J", "<C-w>-" },
        { "H", "<C-w><" },
        { "L", "<C-w>>" },

        { "k", "<C-w>3+" },
        { "j", "<C-w>3-" },
        { "h", "<C-w>5<" },
        { "l", "<C-w>5>" },

        { "q",     nil, { exit = true, nowait = true, desc = false } },
        { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
})
hydra({
    name = "Next",
    hint = [[
   _b_  Next buffer       _d_  Next lsp diagnostic      _t_  Next tab
   _c_  Next git hunk     _s_  Next misspelled word   ]],
    mode = { "n" },
    body = "]",
    config = {
        hint = {
            position = "top",
            offset = 2,
            border = border,
        },
    },
    heads = {
        { "b", "<CMD>bn<CR>"                                                    },
        { "c", "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", {  expr = true } },
        { "d", "<CMD>lua vim.diagnostic.goto_next()<CR>"                        },
        { "s", "]s"                                                             },
        { "t", "<CMD>tabnext<CR>"                                               },

        { "q",     nil, { exit = true, nowait = true, desc = false } },
        { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
})
hydra({
    name = "Previous",
    hint = [[
   _b_  Previous buffer       _d_  Previous lsp diagnostic      _t_  Previous tab
   _c_  Previous git hunk     _s_  Previous misspelled word   ]],
    mode = { "n" },
    body = "[",
    config = {
        hint = {
            position = "top",
            offset = 2,
            border = border,
        },
    },
    heads = {
        { "b", "<CMD>bp<CR>"                                                    },
        { "c", "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", {  expr = true } },
        { "d", "<CMD>lua vim.diagnostic.goto_prev()<CR>"                        },
        { "s", "]s"                                                             },
        { "t", "<CMD>tabprevious<CR>"                                           },

        { "q",     nil, { exit = true, nowait = true, desc = false } },
        { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
})
