local ct = require("styling").variables.transparency
local ci = require("styling").icon
local cb = require("styling").border.table

require("dressing").setup({
    input = {
        -- These are passed to nvim_open_win
        anchor = "SW",
        border = { cb.tl, cb.t, cb.tr, cb.r, cb.br, cb.b, cb.bl, cb.l },
        -- 'editor' and 'win' will default to being centered
        relative = "cursor",

        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        prefer_width = 40,
        width = nil,
        -- min_width and max_width can be a list of mixed types.
        -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },

        -- Window transparency (0-100)
        winblend = ct,
    },
    select = {
        -- Set to false to disable the vim.ui.select implementation
        enabled = true,

        -- Priority list of preferred vim.select implementations
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

        -- Options for telescope selector
        -- These are passed into the telescope picker directly. Can be used like:
        -- telescope = require('telescope.themes').get_ivy({...})
        telescope = require("telescope.themes").get_dropdown({
            borderchars = {
                prompt  = { cb.t,  cb.r,  cb.b,  cb.l, cb.tl, cb.tr, cb.br,  cb.bl },
                results = { cb.t,  cb.r,  cb.b,  cb.l, cb.ml, cb.mr, cb.br,  cb.bl },
                preview = { cb.t,  cb.r,  cb.b,  cb.l, cb.tl, cb.tr, cb.br,  cb.bl },
            }
        }),
    },
})
