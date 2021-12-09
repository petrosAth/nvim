local M = {}

function M.setup()
    vim.cmd([[
        augroup MINIMAP
            autocmd!
            autocmd FileType minimap
                \ setlocal colorcolumn=0 |
                \ lua vim.opt_local.fillchars = { vert = require("cosmetics").icon.nvim_ui.vert[1], eob = " " }
            autocmd ColorScheme *
                \ highlight mmCursor ctermbg=59  ctermfg=84 guibg=#424450 guifg=#50fa7b |
                \ highlight mmRange  ctermbg=237  ctermfg=84 guibg=#343746 guifg=#50fa7b
        augroup END
    ]])

    local excFiletypes = { "NvimTree", "packer", "dashboard", "alpha", "lsp-installer", "Outline", "Trouble" }
    local excBuftypes = { "nofile", "nowrite", "quickfix", "terminal", "prompt", }
    local g = vim.g

    g.minimap_auto_start = 0
    g.minimap_auto_start_win_enter = 0
    g.minimap_width = 15
    g.minimap_block_filetypes = excFiletypes
    g.minimap_close_filetypes = excFiletypes
    g.minimap_block_buftypes = excBuftypes
    g.minimap_close_buftypes = excBuftypes
    g.minimap_left = 0
    g.minimap_highlight_range = 1
    g.minimap_highlight_search = 1
    g.minimap_git_colors = 1
    g.minimap_cursor_color = "mmCursor"
    g.minimap_range_color = "mmRange"
end

function M.config()
    -- minimap mappings
    local map = vim.api.nvim_set_keymap
    local ns_opts = { noremap = true, silent = true }

    map("n", "<M-m>", "<cmd>MinimapRefresh<CR>", ns_opts)
    map("n", "<Leader>m", "<cmd>MinimapToggle<CR>", ns_opts)
end

return M
