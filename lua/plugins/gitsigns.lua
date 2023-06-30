local function setup(gitsigns, icons, borders)
    gitsigns.setup({
        signs = {
            add = { text = icons.signs.add },
            change = { text = icons.signs.change },
            delete = { text = icons.signs.delete },
            topdelete = { text = icons.signs.topdelete },
            changedelete = { text = icons.signs.changedelete },
            untracked = { text = icons.signs.untracked },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        show_deleted = false, -- Toggle with `:Gitsigns toggle_deleted`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            interval = 1000,
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
            delay = 0,
            ignore_whitespace = false,
            virt_text_priority = 0,
        },
        current_line_blame_formatter = "    " .. icons.commit[1] .. " <author>, <author_time:%Y-%m-%d> - <summary>",
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
        event = { "BufReadPre" },
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

            local icons = USER.styling.icons.git
            local borders = USER.styling.borders.default
            setup(gitsigns, icons, borders)
        end,
    },
}
