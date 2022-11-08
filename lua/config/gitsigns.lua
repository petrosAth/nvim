local i = PA.styling.icons.git.signs
local b = PA.styling.borders.outline

require("gitsigns").setup {
    signs = {
        add          = { hl = "GitSignsAdd",    text = i.add,          numhl="GitSignsAddNr",    linehl="GitSignsAddLn"    },
        change       = { hl = "GitSignsChange", text = i.change,       numhl="GitSignsChangeNr", linehl="GitSignsChangeLn" },
        delete       = { hl = "GitSignsDelete", text = i.delete,       numhl="GitSignsDeleteNr", linehl="GitSignsDeleteLn" },
        topdelete    = { hl = "GitSignsDelete", text = i.topdelete,    numhl="GitSignsDeleteNr", linehl="GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = i.changedelete, numhl="GitSignsChangeNr", linehl="GitSignsChangeLn" },
        untracked    = { hl = "GitSignsAdd"   , text = i.untracked,    numhl='GitSignsAddNr',    linehl="GitSignsAddLn"    },
    },
    signcolumn   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl       = false, -- Toggle with `:Gitsigns toggle_linehl`
    show_deleted = false, -- Toggle with `:Gitsigns toggle_deleted`
    word_diff    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    keymaps = {},
    watch_gitdir = {
        interval = 1000,
        follow_files = true
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
        border = { b.tl,  b.t, b.tr,  b.r, b.br,  b.b, b.bl, b.l },
        style = "minimal",
        relative = "cursor",
        row = 1,
        col = 1
    },
    yadm = {
        enable = false
    },
}
