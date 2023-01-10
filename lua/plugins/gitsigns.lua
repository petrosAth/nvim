local function setup(gitsigns, icons, borders)
    gitsigns.setup({
        signs = {
            add = {
                hl = "GitSignsAdd",
                text = icons.add,
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn",
            },
            change = {
                hl = "GitSignsChange",
                text = icons.change,
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
            delete = {
                hl = "GitSignsDelete",
                text = icons.delete,
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = icons.topdelete,
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            changedelete = {
                hl = "GitSignsChange",
                text = icons.changedelete,
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
            untracked = {
                hl = "GitSignsAdd",
                text = icons.untracked,
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn",
            },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        show_deleted = false, -- Toggle with `:Gitsigns toggle_deleted`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        keymaps = {},
        watch_gitdir = {
            interval = 1000,
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
            delay = 500,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = " <author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
            -- Options passed to nvim_open_win
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
            style = "minimal",
            relative = "cursor",
            row = 1,
            col = 1,
        },
        yadm = {
            enable = false,
        },
    })
end

return {
    {
        -- gitsigns.nvim
        -- Super fast git decorations implemented purely in lua/teal.
        "lewis6991/gitsigns.nvim",
        dependencies = {
            -- plenary.nvim
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

            local icons = USER.styling.icons.git.signs
            local borders = USER.styling.borders.default
            setup(gitsigns, icons, borders)
        end,
    },
}
