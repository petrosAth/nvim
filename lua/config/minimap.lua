local M = {}

M.setup = function()
    vim.cmd([[
        augroup custom_minimap
            autocmd!
            autocmd FileType minimap setlocal
                    \ colorcolumn=0
                    \ fillchars+=eob:\ "
        augroup END
    ]])

    local block_files = {
        "alpha",
        "diff",
        "help",
        "lsp-installer",
        "NvimTree",
        "Outline",
        "packer",
        "qf",
        "Trouble",
        "undotree"
    }

    local block_buffers = {
        "nofile",
        "nowrite",
        "quickfix",
        "terminal",
        "prompt"
    }
    local g = vim.g

    g.minimap_auto_start = 0
    g.minimap_auto_start_win_enter = 0
    g.minimap_window_width_cap = 120
    g.minimap_window_width_override_for_scaling = 2147483647
    g.minimap_width = 15
    g.minimap_block_filetypes = block_files
    g.minimap_close_filetypes = { "alpha" }
    g.minimap_block_buftypes = block_buffers
    g.minimap_close_buftypes = {}
    g.minimap_left = 0
    g.minimap_highlight_range = 1
    g.minimap_highlight_search = 1
    g.minimap_git_colors = 1
    g.minimap_cursor_color            = "mmCursor"
    g.minimap_range_color             = "mmRange"
    g.minimap_diffadd_color           = "mmDiffAdd"
    g.minimap_diffremove_color        = "mmDiffRemove"
    g.minimap_diff_color              = "mmDiffChange"
    g.minimap_cursor_diffadd_color 	  = "mmCursorDiffAdd"
    g.minimap_cursor_diffremove_color = "mmCursorDiffRemove"
    g.minimap_cursor_diff_color 	  = "mmCursorDiffChange"
    g.minimap_range_diffadd_color 	  = "mmRangeDiffAdd"
    g.minimap_range_diffremove_color  = "mmRangeDiffRemove"
    g.minimap_range_diff_color 	      = "mmRangeDiffChange"
end

M.config = function ()
    local hl = vim.api.nvim_set_hl
    hl(0, "mmCursor",           { bg = "#424450", fg = "#F8F8F2" })
    hl(0, "mmRange",            { bg = "#343746", fg = "#F8F8F2" })
    hl(0, "mmDiffAdd",          {                 fg = "#50FA7B" })
    hl(0, "mmDiffRemove",       {                 fg = "#FF5555" })
    hl(0, "mmDiffChange",       {                 fg = "#FFB86C" })
    hl(0, "mmCursorDiffAdd",    { bg = "#424450", fg = "#50FA7B" })
    hl(0, "mmCursorDiffRemove", { bg = "#424450", fg = "#FF5555" })
    hl(0, "mmCursorDiffChange", { bg = "#424450", fg = "#FFB86C" })
    hl(0, "mmRangeDiffAdd",     { bg = "#343746", fg = "#50FA7B" })
    hl(0, "mmRangeDiffRemove",  { bg = "#343746", fg = "#FF5555" })
    hl(0, "mmRangeDiffChange",  { bg = "#343746", fg = "#FFB86C" })
end

return M
