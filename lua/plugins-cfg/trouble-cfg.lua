-- Reset fillchars that trouble.nvim defaulted
vim.cmd([[
    augroup TROUBLE_AU
        autocmd!
        autocmd FileType Trouble
                \ setlocal nolist
                \ colorcolumn=0
                \ nonumber relativenumber |
                \ lua local cui = require("cosmetics").icon.nvim_ui
                \ vim.opt_local.fillchars = {
                \     vert = cui.vert[1],
                \     fold = cui.fold[1],
                \     foldopen = cui.foldopen[1],
                \     foldclose = cui.foldclose[1],
                \     foldsep = cui.foldsep[1],
                \     msgsep = cui.msgsep[1],
                \     eob = ' '
                \ }
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
    mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = cui.foldopen[1], -- icon used for open folds
    fold_closed = cui.foldclose[1], -- icon used for closed folds
    group = true, -- group results by file
    padding = false, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = {}, -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "R", -- manually refresh
        jump = "<CR>", -- jump to the diagnostic or open / close folds
        open_split = "<C-s>", -- open buffer in new split
        open_vsplit = "<C-v>", -- open buffer in new vsplit
        open_tab = "<C-t>", -- open buffer in new tab
        jump_close = "<C-y>", -- jump to the diagnostic and close the list
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
    auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = {}, -- for the given modes, automatically jump if there is only a single result
    use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
})
