local cb = require("cosmetics").border.table

require("gitsigns").setup {
    signs = {
        add          = { hl = "DiffAdd",    text = "▎", numhl = "DiffAdd",    linehl = "DiffAdd"    }, -- +
        change       = { hl = "DiffChange", text = "▎", numhl = "DiffChange", linehl = "DiffChange" }, -- ~
        delete       = { hl = "DiffDelete", text = "契", numhl = "DiffDelete", linehl = "DiffDelete" }, -- _
        topdelete    = { hl = "DiffDelete", text = "契", numhl = "DiffDelete", linehl = "DiffDelete" }, -- ‾
        changedelete = { hl = "DiffDelete", text = "▎", numhl = "DiffDelete", linehl = "DiffDelete" }  -- ~
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
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
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
        relative_time = true
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
        -- Options passed to nvim_open_win
        border = { cb.tl,  cb.t, cb.tr,  cb.r, cb.br,  cb.b, cb.bl, cb.l },
        style = "minimal",
        relative = "cursor",
        row = 1,
        col = 1
    },
    yadm = {
        enable = false
    },
}
