local cwd = vim.fn.getcwd()

vim.opt.spellfile = _G.user.spell_file_dir(cwd) .. "en.utf-8.add"
vim.g.Hexokinase_palettes = _G.user.load_palettes(cwd)
