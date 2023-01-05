local M = {}

function M.setup()
    local loaded, hydra = pcall(require, "hydra")
    if not loaded then
        USER.loading_error_msg("hydra.nvim")
        return
    end

    local arrow = USER.styling.icons.arrow.hollow.r
    local b = USER.styling.borders.default
    local border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l }

    hydra({
        name = "Side scroll",
        hint = [[
       _h_ ]] .. arrow .. [[ Scroll left    _H_ ]] .. arrow .. [[ Scroll half screen left
       _l_ ]] .. arrow .. [[ Scroll right   _L_ ]] .. arrow .. [[ Scroll half screen right   ]],
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
        hint = [[
       _m_ ]] .. arrow .. [[ Fold more   _j_ ]] .. arrow .. [[ Next fold
       _r_ ]] .. arrow .. [[ Fold less   _k_ ]] .. arrow .. [[ Previous fold   ]],
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
            { "m", "zm" },
            { "r", "zr" },
            { "j", "zj" },
            { "k", "zk" },

            { "q", nil, { exit = true, nowait = true, desc = false } },
            { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
        },
    })
    hydra({
        name = "Resize Window",
        hint = [[
       _+_ ]] .. arrow .. [[ Increase height   _>_ ]] .. arrow .. [[ Increase width
       _-_ ]] .. arrow .. [[ Decrease height   _<_ ]] .. arrow .. [[ Decrease width   ]],
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
       _b_ ]] .. arrow .. [[ Next buffer     _d_ ]] .. arrow .. [[ Next lsp diagnostic    _t_ ]] .. arrow .. [[ Next tab
       _c_ ]] .. arrow .. [[ Next git hunk   _s_ ]] .. arrow .. [[ Next misspelled word                  ]],
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
       _b_ ]] .. arrow .. [[ Previous buffer     _d_ ]] .. arrow .. [[ Previous lsp diagnostic    _t_ ]] .. arrow .. [[ Previous tab
       _c_ ]] .. arrow .. [[ Previous git hunk   _s_ ]] .. arrow .. [[ Previous misspelled word                      ]],
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
end

return M
