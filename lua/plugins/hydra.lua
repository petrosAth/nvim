local function setup(hydra)
    local arrow = USER.styling.icons.arrow.hollow.r
    local borders = USER.styling.borders.default
    local border = {
        borders.tl,
        borders.t,
        borders.tr,
        borders.r,
        borders.br,
        borders.b,
        borders.bl,
        borders.l,
    }

    hydra.setup({
        hint = {
            position = "top",
            offset = 2,
            float_opts = {
                border = border,
            },
        },
    })

    hydra({
        name = "Side scroll",
        -- stylua: ignore
        hint = string.format([[
   _h_ %s Scroll left    _H_ %s Scroll half screen left
   _l_ %s Scroll right   _L_ %s Scroll half screen right   ]], arrow, arrow, arrow, arrow),
        mode = { "n", "x" },
        body = "z",
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
        -- stylua: ignore
        hint = string.format([[
   _m_ %s Fold more   _j_ %s Next fold
   _r_ %s Fold less   _k_ %s Previous fold   ]], arrow, arrow, arrow, arrow),
        mode = { "n", "x" },
        body = "z",
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
        -- stylua: ignore
        hint = string.format([[
   _+_ %s Increase height by 3   _>_ %s Increase width by 5
   _-_ %s Decrease height by 3   _<_ %s Decrease width by 5   ]], arrow, arrow, arrow, arrow),
        mode = { "n", "v" },
        body = "<C-w>",
        heads = {
            { "+", "<C-w>3+" },
            { "-", "<C-w>3-" },
            { "<", "<C-w>5<" },
            { ">", "<C-w>5>" },

            { "q", nil, { exit = true, nowait = true, desc = false } },
            { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
        },
    })
end

return {
    {
        -- This is the Neovim implementation of the famous Emacs Hydra package.
        "nvimtools/hydra.nvim",
        event = { "VimEnter" },
        config = function()
            local loaded, hydra = pcall(require, "hydra")
            if not loaded then
                USER.loading_error_msg("hydra.nvim")
                return
            end

            setup(hydra)
        end,
    },
}
