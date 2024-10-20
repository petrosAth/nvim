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
   _+_ ]] .. arrow .. [[ Increase height by 3   _>_ ]] .. arrow .. [[ Increase width by 3
   _-_ ]] .. arrow .. [[ Decrease height by 3   _<_ ]] .. arrow .. [[ Decrease width by 3   ]],
        mode = { "n", "v" },
        body = "<C-w>",
        config = {
            hint = {
                position = "top",
                offset = 2,
                border = border,
            },
        },
        heads = {
            { "+", "<C-w>3+" },
            { "-", "<C-w>3-" },
            { "<", "<C-w>3<" },
            { ">", "<C-w>3>" },

            { "q", nil, { exit = true, nowait = true, desc = false } },
            { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
        },
    })
end

return {
    {
        -- Hydra.nvim
        -- This is the Neovim implementation of the famous Emacs Hydra package.
        "anuvyklack/hydra.nvim",
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
