-- Remove trailing whitespace and newlines
vim.cmd([[
    augroup CLEANUP
        autocmd!
        autocmd BufWritePre * silent! lua perform_cleanup()
    augroup END
]])

-- Restore terminal cursor after quit
vim.cmd([[
    augroup RESTORE_CURSOR
        autocmd!
        autocmd VimLeave * set guicursor=n:ver25,a:blinkwait750-blinkoff750-blinkon750-Cursor/lCursor
    augroup END
]])

-- Activate search highlight after search initiation
-- Deactivate search highlight after entering insert mode
-- vim.cmd([[
--     augroup HL_SEARCH
--         autocmd!
--         autocmd CmdlineEnter /,\? set hlsearch
--         autocmd InsertEnter * set nohlsearch
--     augroup END
-- ]])

-- Toggle relativenumber after entering and leaving insert mode
vim.cmd([[
    augroup NUMBER_TOGGLE
        autocmd!
        autocmd InsertEnter * set norelativenumber
        autocmd InsertLeave * set relativenumber
    augroup END
]])

-- Highlight on yank
vim.cmd([[
    augroup HL_ON_YANK
        autocmd!
        autocmd TextYankPost * lua vim.highlight.on_yank { higroup = 'Visual', timeout = 500, on_visual = true, on_macro = true }
    augroup END
]])

-- Automatically reload the file if it is changed outside of nvim
vim.cmd([[
    augroup AUTO_READ
        autocmd!
        autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
        autocmd FileChangedShellPost * echohl WarningMsg | redraw | echo 'File changed on disk. Buffer reloaded!' | echohl None
    augroup END
]])

-- Save and restore folds
-- Also resumes edit position
vim.cmd([[
    augroup SAVE_VIEW
        autocmd!
        autocmd BufWinLeave *.* if expand('%') != '' | mkview | endif
        autocmd BufWinEnter *.* if expand('%') != '' | silent! loadview | endif
    augroup END
]])

vim.cmd([[
    augroup RESTORE_WIN_VIEW
        autocmd!
        autocmd BufLeave * lua auto_save_win_view()
        autocmd BufEnter * lua auto_restore_win_view()
    augroup END
]])

-- Force disable inserting comment leader after hitting o or O
-- Force disable inserting comment leader after hitting <Enter> in insert mode
vim.cmd([[
    augroup FORCE_FORMAT_OPTIONS
        autocmd!
        autocmd BufEnter * setlocal formatoptions-=r formatoptions-=o
    augroup END
]])

-- Setup neovim-remote
-- vim.cmd([[
--     augroup SETUP_NVR
--         autocmd!
--         autocmd VimEnter * lua set_servername()
--     augroup END
-- ]])
