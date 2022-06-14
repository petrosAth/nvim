-- Source:
-- https://gitlab.com/Groctel/dotfiles/-/blob/c94a6b68cddffee5df42e7d46f48c4abf1ddd67d/files-common/.config/nvim/lua/user/autocmd.lua
-- https://github.com/Allaman/nvim/blob/2e07f43d992f3858bd0527b00289a51ea00099f6/lua/autocmd.lua
local api = vim.api

local TrimExtraSpacesAndNewLines = api.nvim_create_augroup("TrimExtraSpacesAndNewLines", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
    command = [[
        let current_pos = getpos(".")
        silent! %s/\v\s+$|\n+%$//e
        silent! call setpos(".", current_pos)
    ]],
    group = TrimExtraSpacesAndNewLines,
})

local YankHighlightGroup = api.nvim_create_augroup("YankHighlightGroup", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ timeout = 300, on_visual = true, on_macro = true })
    end,
    group = YankHighlightGroup,
})

api.nvim_create_autocmd("FileType", {
    pattern = {
        "checkhealth",
        "help",
        "lspinfo",
        "lsp-installer",
        "man",
        "packer",
    },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "q", "<CMD>close!<CR>", { noremap = true, silent = true })
    end,
})

local ToggleRelativeNumberInInsertMode = api.nvim_create_augroup("ToggleRelativeNumberInInsertMode", { clear = true })
api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    command = [[ if &nu && mode() != "i" | set rnu   | endif ]],
    group = ToggleRelativeNumberInInsertMode,
})
api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    command = [[if &nu | set nornu | endif]],
    group = ToggleRelativeNumberInInsertMode,
})

local SaveAndRestoreFolds = api.nvim_create_augroup("SaveAndRestoreFolds", { clear = true })
api.nvim_create_autocmd("BufWinLeave", {
    command = [[
        if expand('%') != '' | mkview | endif
    ]],
    group = SaveAndRestoreFolds,
})
api.nvim_create_autocmd("BufWinEnter", {
    command = [[
        if expand('%') != '' | silent! loadview | endif
    ]],
    group = SaveAndRestoreFolds,
})

-- r - Automatically insert the current comment leader after hitting <Enter> in Insert mode.
-- o - Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
api.nvim_create_autocmd("BufEnter", {
    command = [[set formatoptions-=ro]],
})
