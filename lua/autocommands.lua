-- Sources:
-- https://github.com/Neelfrost/nvim-config/blob/bdffbc3c74fc5ee8b5789c8d9e3e68c0f1163e34/lua/user/autocmds.lua
-- https://gitlab.com/Groctel/dotfiles/-/blob/c94a6b68cddffee5df42e7d46f48c4abf1ddd67d/files-common/.config/nvim/lua/user/autocmd.lua
-- https://github.com/Allaman/nvim/blob/2e07f43d992f3858bd0527b00289a51ea00099f6/lua/autocmd.lua
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local YankHighlight = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    group = YankHighlight,
    desc  = "Configure Yank Highlight.",
    callback = function()
        vim.highlight.on_yank({ higroup='Yank', timeout = 300, on_visual = true, on_macro = true })
    end,
})

local FileTypeAutocmd = augroup("FileTypeAutocmd", { clear = true })
autocmd("FileType", {
    group = FileTypeAutocmd,
    pattern = {
        "checkhealth",
        "help",
        "lspinfo",
        "lsp-installer",
        "man",
        "packer",
    },
    desc = "Exit specific FileTypes using 'q'.",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "q", "<CMD>close!<CR>", { noremap = true, silent = true })
    end,
})

local ToggleRelativeNumber = augroup("ToggleRelativeNumber", { clear = true })
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    group = ToggleRelativeNumber,
    desc = "Enable relative number.",
    command = [[ if &nu && mode() != "i" | set rnu | endif ]],
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    group = ToggleRelativeNumber,
    desc = "Disable relative number while in insert mode.",
    command = [[if &nu | set nornu | endif]],
})

local SaveAndRestoreFolds = augroup("SaveAndRestoreFolds", { clear = true })
autocmd("BufWinLeave", {
    group = SaveAndRestoreFolds,
    desc = "Save folds state.",
    command = [[
        if expand('%') != '' | mkview | endif
    ]],
})
autocmd("BufWinEnter", {
    group = SaveAndRestoreFolds,
    desc = "Restore folds to the last known state.",
    command = [[
        if expand('%') != '' | silent! loadview | endif
    ]],
})

local BufEnterAutocmd = augroup("BufEnterAutocmd", { clear = true })
-- r - Automatically insert the current comment leader after hitting <Enter> in Insert mode.
-- o - Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
autocmd("BufEnter", {
    group = BufEnterAutocmd,
    pattern = "*",
    desc = "Don't automatically insert comment leader.",
    callback = function()
        vim.opt_local.formatoptions:remove({ "r", "o" })
    end,
})
