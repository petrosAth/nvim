local hydra = require("hydra")
local i = USER.styling.icons
local b = USER.styling.borders.default
local border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l }

hydra({
    name = "Side scroll",
    hint = [[
   _h_ ]] .. i.arrow.hollow.r .. [[ Scroll left     _H_ ]] .. i.arrow.hollow.r .. [[ Scroll half screen left
   _l_ ]] .. i.arrow.hollow.r .. [[ Scroll right    _L_ ]] .. i.arrow.hollow.r .. [[ Scroll half screen right   ]],
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

        { "q", nil, { exit = true, nowait = true, desc = false } },
        { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
})
hydra({
    name = "Manipulate folds",
    hint = [[   _r_ ]] .. i.arrow.hollow.r .. [[ Fold less   _m_ ]] .. i.arrow.hollow.r .. [[ Fold more   ]],
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
        { "r", "zr" },
        { "m", "zm" },

        { "q", nil, { exit = true, nowait = true, desc = false } },
        { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
})
hydra({
    name = "Resize Window",
    hint = [[
   _+_ ]] .. i.arrow.hollow.r .. [[ Increase height      _>_ ]] .. i.arrow.hollow.r .. [[ Increase width
   _-_ ]] .. i.arrow.hollow.r .. [[ Decrease height      _<_ ]] .. i.arrow.hollow.r .. [[ Decrease width   ]],
    mode = { "n", "x" },
    body = "<C-w>",
    config = {
        hint = {
            position = "top",
            offset = 2,
            border = border,
        },
    },
    heads = {
        { "+", "<C-w>+" },
        { "-", "<C-w>-" },
        { "<", "<C-w><" },
        { ">", "<C-w>>" },

        { "q", nil, { exit = true, nowait = true, desc = false } },
        { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
})
hydra({
    name = "Next",
    hint = [[
   _b_ ]]
        .. i.arrow.hollow.r
        .. [[ Next buffer       _d_ ]]
        .. i.arrow.hollow.r
        .. [[ Next lsp diagnostic      _t_ ]]
        .. i.arrow.hollow.r
        .. [[ Next tab
   _c_ ]]
        .. i.arrow.hollow.r
        .. [[ Next git hunk     _s_ ]]
        .. i.arrow.hollow.r
        .. [[ Next misspelled word                    ]],
    mode = { "n" },
    body = "]",
    config = {
        hint = {
            position = "top",
            offset = 2,
            border = border,
        },
        on_key = function()
            vim.wait(50)
        end,
    },
    heads = {
        { "b", "<CMD>bn<CR>" },
        {
            "c",
            function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    require("gitsigns").next_hunk()
                end)
                return "<Ignore>"
            end,
            { expr = true },
        },
        {
            "d",
            "<CMD>lua vim.diagnostic.goto_next()<CR><CMD>lua vim.diagnostic.open_float()<CR>",
        },
        { "s", "]s" },
        { "t", "<CMD>tabnext<CR>" },

        { "q", nil, { exit = true, nowait = true, desc = false } },
        { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
})
hydra({
    name = "Previous",
    hint = [[
   _b_ ]]
        .. i.arrow.hollow.r
        .. [[ Previous buffer       _d_ ]]
        .. i.arrow.hollow.r
        .. [[ Previous lsp diagnostic      _t_ ]]
        .. i.arrow.hollow.r
        .. [[ Previous tab
   _c_ ]]
        .. i.arrow.hollow.r
        .. [[ Previous git hunk     _s_ ]]
        .. i.arrow.hollow.r
        .. [[ Previous misspelled word                        ]],
    mode = { "n" },
    body = "[",
    config = {
        hint = {
            position = "top",
            offset = 2,
            border = border,
        },
        on_key = function()
            vim.wait(50)
        end,
    },
    heads = {
        { "b", "<CMD>bp<CR>" },
        {
            "c",
            function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    require("gitsigns").prev_hunk()
                end)
                return "<Ignore>"
            end,
            { expr = true },
        },
        {
            "d",
            "<CMD>lua vim.diagnostic.goto_prev()<CR><CMD>lua vim.diagnostic.open_float()<CR>",
        },
        { "s", "[s" },
        { "t", "<CMD>tabprevious<CR>" },

        { "q", nil, { exit = true, nowait = true, desc = false } },
        { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
})
