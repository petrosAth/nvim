local g = vim.g

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("undoTreeFileTypeAutoCMD", { clear = true }),
    pattern = { "undotree", "diff", },
    desc = "Disable color column and hide end of buffer fillchars.",
    callback = function ()
        local f = require("options")

        vim.opt_local.colorcolumn = ""
        vim.opt_local.fillchars = f.localFillchars
    end
})

g.undotree_WindowLayout       = 2
g.undotree_ShortIndicators    = 1
g.undotree_SplitWidth         = 30
g.undotree_DiffpanelHeight    = 10
g.undotree_DiffAutoOpen       = 0
g.undotree_SetFocusWhenToggle = 1
g.undotree_HelpLine           = 0
g.undotree_CursorLine         = 1
