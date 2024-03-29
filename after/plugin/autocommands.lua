-- Sources:
-- https://github.com/Neelfrost/nvim-config/blob/bdffbc3c74fc5ee8b5789c8d9e3e68c0f1163e34/lua/user/autocmds.lua
-- https://gitlab.com/Groctel/dotfiles/-/blob/c94a6b68cddffee5df42e7d46f48c4abf1ddd67d/files-common/.config/nvim/lua/user/autocmd.lua
-- https://github.com/Allaman/nvim/blob/2e07f43d992f3858bd0527b00289a51ea00099f6/lua/autocmd.lua
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local TextYankHighlight = augroup("TextYankHighlight", { clear = true })
autocmd("TextYankPost", {
    group = TextYankHighlight,
    desc = "Configure Yank Highlight.",
    callback = function()
        vim.highlight.on_yank({
            higroup = "Yank",
            timeout = 300,
            on_visual = true,
            on_macro = true,
        })
    end,
})

local ExitWithQ = augroup("ExitWithQ", { clear = true })
autocmd("FileType", {
    group = ExitWithQ,
    pattern = {
        "checkhealth",
        "Codewindow",
        "diff",
        "DiffviewFileHistory",
        "DiffviewFiles",
        "help",
        "man",
        "notify",
        "packer",
    },
    desc = "Exit specific FileTypes using 'q'.",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "q", "<CMD>close!<CR>", { noremap = true, silent = true })
    end,
})

local RelativeNumberToggle = augroup("RelativeNumberToggle", { clear = true })
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    group = RelativeNumberToggle,
    desc = "Enable relative number.",
    command = [[if &nu && mode() != "i" | set rnu | endif]],
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    group = RelativeNumberToggle,
    desc = "Disable relative number while in insert mode.",
    command = [[if &nu | set nornu | endif]],
})

local UpdateFolds = augroup("UpdateFolds", { clear = true })
autocmd("BufReadPost", {
    group = UpdateFolds,
    desc = "Recalculate buffer folds. Useful when using 'foldexpr'.",
    command = [[normal! zx]],
})

local FormatOptions = augroup("FormatOptions", { clear = true })
autocmd("BufEnter", {
    group = FormatOptions,
    pattern = "*",
    desc = "Set buffer local formatoptions.",
    callback = function()
        vim.opt_local.formatoptions:remove({
            "r", -- Automatically insert the current comment leader after hitting <Enter> in Insert mode.
            "o", -- Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
        })
    end,
})

local TerminalNoSpell = augroup("TerminalNoSpell", { clear = true })
autocmd("TermOpen", {
    group = TerminalNoSpell,
    pattern = "*",
    desc = "Disable spell checking in terminal buffers.",
    callback = function()
        vim.opt_local.spell = false
    end,
})

local WhiteSpaceClear = augroup("WhiteSpaceClear", { clear = true })
autocmd("BufWritePre", {
    group = WhiteSpaceClear,
    desc = "Trim trailing whitespace and redundant blank lines on buffer save.",
    command = [[
        let current_pos = getpos(".")
        silent! %s/\s\+$//e          " trim trailing whitespace
        silent! %s/\($\n\s*\)\+\%$// " trim last line
        silent! %s/\%^\n\+//         " trim first line
        silent! %s/\(\n\n\)\n\+/\1/  " replace multiple blank lines with a single line
        silent! call setpos(".", current_pos)
    ]],
})
