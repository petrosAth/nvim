local cb = require("cosmetics").border.table

require("gitsigns").setup {
    signs = {
        add          = { hl = "DraculaGreen",  text = "┃", numhl = "DraculaGreen",  linehl = "DraculaGreen"  },
        change       = { hl = "DraculaOrange", text = "┃", numhl = "DraculaOrange", linehl = "DraculaOrange" },
        delete       = { hl = "DraculaRed",    text = "▁", numhl = "DraculaRed",    linehl = "DraculaRed"    },
        topdelete    = { hl = "DraculaRed",    text = "▔", numhl = "DraculaRed",    linehl = "DraculaRed"    },
        changedelete = { hl = "DraculaRed",    text = "━", numhl = "DraculaRed",    linehl = "DraculaRed"    }
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    -- keymaps = {
    --     -- Default keymap options
    --     noremap = true,
    --
    --     ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"},
    --     ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'"},
    --
    --     ["n <Space>gs"] = "<cmd>Gitsigns stage_hunk<CR>",
    --     ["v <Space>gs"] = ":Gitsigns stage_hunk<CR>",
    --     ["n <Space>gu"] = "<cmd>Gitsigns undo_stage_hunk<CR>",
    --     ["n <Space>gr"] = "<cmd>Gitsigns reset_hunk<CR>",
    --     ["v <Space>gr"] = ":Gitsigns reset_hunk<CR>",
    --     ["n <Space>gR"] = "<cmd>Gitsigns reset_buffer<CR>",
    --     ["n <Space>gp"] = "<cmd>Gitsigns preview_hunk<CR>",
    --     ["n <Space>gb"] = "<cmd>lua require('gitsigns').blame_line{full=true}<CR>",
    --     ["n <Space>gS"] = "<cmd>Gitsigns stage_buffer<CR>",
    --     ["n <Space>gU"] = "<cmd>Gitsigns reset_buffer_index<CR>",
    --
    --     -- Text objects
    --     ["o ih"] = ":<C-U>Gitsigns select_hunk<CR>",
    --     ["x ih"] = ":<C-U>Gitsigns select_hunk<CR>"
    -- },
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
        row = 0,
        col = 1
    },
    yadm = {
        enable = false
    },
}

-- gitsigns mappings
local map = vim.api.nvim_set_keymap
local ns_opts = { noremap = true, silent = true }
local nse_opts = { noremap = true, silent = true, expr = true }

map("n", "]c",        "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'",          nse_opts)
map("n", "[c",        "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'",          nse_opts)

map("n", "<Space>gs", "<cmd>Gitsigns stage_hunk<CR>",                           ns_opts)
map("v", "<Space>gs", ":Gitsigns stage_hunk<CR>",                               ns_opts)
map("n", "<Space>gu", "<cmd>Gitsigns undo_stage_hunk<CR>",                      ns_opts)
map("n", "<Space>gr", "<cmd>Gitsigns reset_hunk<CR>",                           ns_opts)
map("v", "<Space>gr", ":Gitsigns reset_hunk<CR>",                               ns_opts)
map("n", "<Space>gR", "<cmd>Gitsigns reset_buffer<CR>",                         ns_opts)
map("n", "<Space>gp", "<cmd>Gitsigns preview_hunk<CR>",                         ns_opts)
map("n", "<Space>gb", "<cmd>lua require('gitsigns').blame_line{full=true}<CR>", ns_opts)
map("n", "<Space>gS", "<cmd>Gitsigns stage_buffer<CR>",                         ns_opts)
map("n", "<Space>gU", "<cmd>Gitsigns reset_buffer_index<CR>",                   ns_opts)

-- Text objects
map("o", "ih",        ":<C-U>Gitsigns select_hunk<CR>",                         ns_opts)
map("x", "ih",        ":<C-U>Gitsigns select_hunk<CR>",                         ns_opts)
