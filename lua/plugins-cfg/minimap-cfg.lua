vim.cmd([[
    augroup custom_minimap
        autocmd!
        autocmd FileType minimap setlocal
                \ colorcolumn=0
                \ fillchars+=eob:\ "
        autocmd ColorScheme *
            \ highlight mmCursor           ctermbg=59  ctermfg=253 guibg=#424450 guifg=#F8F8F2 |
            \ highlight mmRange            ctermbg=237 ctermfg=253 guibg=#343746 guifg=#F8F8F2 |
            \ highlight mmDiffAdd                      ctermfg=84                guifg=#50FA7B |
            \ highlight mmDiffRemove                   ctermfg=203               guifg=#FF5555 |
            \ highlight mmDiffChange                   ctermfg=215               guifg=#FFB86C |
            \ highlight mmCursorDiffAdd    ctermbg=59  ctermfg=84  guibg=#424450 guifg=#50FA7B |
            \ highlight mmCursorDiffRemove ctermbg=59  ctermfg=203 guibg=#424450 guifg=#FF5555 |
            \ highlight mmCursorDiffChange ctermbg=59  ctermfg=215 guibg=#424450 guifg=#FFB86C |
            \ highlight mmRangeDiffAdd     ctermbg=237 ctermfg=84  guibg=#343746 guifg=#50FA7B |
            \ highlight mmRangeDiffRemove  ctermbg=237 ctermfg=203 guibg=#343746 guifg=#FF5555 |
            \ highlight mmRangeDiffChange  ctermbg=237 ctermfg=215 guibg=#343746 guifg=#FFB86C
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
local block_buffers = { "nofile", "nowrite", "quickfix", "terminal", "prompt", }
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
