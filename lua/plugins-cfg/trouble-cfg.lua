vim.cmd([[
    augroup TROUBLE_AU
        autocmd!
        autocmd FileType Trouble
            \ nnoremap <buffer> q <cmd>Trouble quickfix<CR> |
            \ nnoremap <buffer> l <cmd>Trouble loclist<CR> |
            "\ nnoremap <buffer> dd <cmd>Trouble lsp_document_diagnostics<CR> |
            "\ nnoremap <buffer> dw <cmd>Trouble lsp_workspace_diagnostics<CR> |
            "\ nnoremap <buffer> r <cmd>Trouble lsp_references<CR> |
            "\ nnoremap <buffer> d <cmd>Trouble lsp_definitions<CR> |
            "\ nnoremap <buffer> t <cmd>Trouble lsp_type_definitions<CR> |
            "\ nnoremap <buffer> i <cmd>Trouble lsp_implementations<CR>
        autocmd BufEnter Trouble lua vim.opt_local.fillchars = { vert = require("cosmetics").icon.nvim_ui.vert[1], eob = " " }
    augroup END
]])

local trouble = require("trouble")
local ci = require("cosmetics").icon
local cui = ci.nvim_ui

trouble.setup({
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "quickfix", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = cui.foldopen[1], -- icon used for open folds
    fold_closed = cui.foldclose[1], -- icon used for closed folds
    group = true, -- group results by file
    padding = false, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "<esc>", -- close the list
        cancel = {}, -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "R", -- manually refresh
        jump = { "<cr>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-s>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = "<c-y>", -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "l", -- preview the diagnostic location
        close_folds = { "zM", "zm" }, -- close all folds
        open_folds = { "zR", "zr" }, -- open all folds
        toggle_fold = { "zA", "za" }, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = {}, -- for the given modes, automatically jump if there is only a single result
    use_lsp_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
})


-- trouble mappings
local map = vim.api.nvim_set_keymap
local ns_opts = { noremap = true, silent = true }

map("n", "<Space>qq",  "<cmd>TroubleToggle<CR>",                     ns_opts)
map("n", "<Space>qo",  "<cmd>TroubleOpen<CR>",                       ns_opts)
map("n", "<Space>qc",  "<cmd>TroubleClose<CR>",                      ns_opts)
map("n", "<Space>qR",  "<cmd>TroubleRefresh<CR>",                    ns_opts)
-- map("n", "<Space>ql",  "<cmd>Trouble loclist<CR>",                   ns_opts)
-- map("n", "<Space>qq",  "<cmd>Trouble quickfix<CR>",                  ns_opts)
map("n", "<Space>qdd", "<cmd>Trouble lsp_document_diagnostics<CR>",  ns_opts)
map("n", "<Space>qdw", "<cmd>Trouble lsp_workspace_diagnostics<CR>", ns_opts)
map("n", "<Space>qr",  "<cmd>Trouble lsp_references<CR>",            ns_opts)
map("n", "<Space>qd",  "<cmd>Trouble lsp_definitions<CR>",           ns_opts)
map("n", "<Space>qt",  "<cmd>Trouble lsp_type_definitions<CR>",      ns_opts)
map("n", "<Space>qi",  "<cmd>Trouble lsp_implementations<CR>",       ns_opts)
