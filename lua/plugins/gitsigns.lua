local function setup(gitsigns)
    local icons = USER.styling.icons.git
    local borders = USER.styling.borders.default

    gitsigns.setup({
        signs = {
            add = { text = icons.signs.add },
            change = { text = icons.signs.change },
            delete = { text = icons.signs.delete },
            topdelete = { text = icons.signs.topdelete },
            changedelete = { text = icons.signs.changedelete },
            untracked = { text = icons.signs.untracked },
        },
        signs_staged = {
            add = { text = icons.signs_staged.add },
            change = { text = icons.signs_staged.change },
            delete = { text = icons.signs_staged.delete },
            topdelete = { text = icons.signs_staged.topdelete },
            changedelete = { text = icons.signs_staged.changedelete },
            untracked = { text = icons.signs_staged.untracked },
        },
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        show_deleted = false, -- Toggle with `:Gitsigns toggle_deleted`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_formatter = "    " .. icons.commit[1] .. " <author>, <author_time:%Y-%m-%d> - <summary>",
        update_debounce = 100,
        preview_config = {
            border = {
                borders.tl,
                borders.t,
                borders.tr,
                borders.r,
                borders.br,
                borders.b,
                borders.bl,
                borders.l,
            },
            row = 1,
        },
    })
end

return {
    {
        -- Super fast git decorations implemented purely in lua/teal.
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre" },
        dependencies = {
            -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write
            -- twice.
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local loaded, gitsigns = pcall(require, "gitsigns")
            if not loaded then
                USER.loading_error_msg("gitsigns.nvim")
                return
            end

            setup(gitsigns)
        end,
    },
}
