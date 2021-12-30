vim.cmd([[
    augroup custom_minimap
        autocmd!
        autocmd FileType undotree setlocal
                \ colorcolumn=0
                \ fillchars+=eob:\ "
        autocmd FileType diff setlocal
                \ colorcolumn=0
                \ fillchars+=eob:\ "
    augroup END
]])

local g = vim.g

g.undotree_WindowLayout       = 2
g.undotree_ShortIndicators    = 1
g.undotree_SplitWidth         = 40
g.undotree_DiffpanelHeight    = 10
g.undotree_DiffAutoOpen       = 0
g.undotree_SetFocusWhenToggle = 1
-- g.undotree_TreeNodeShape      = "*"
-- g.undotree_TreeVertShape      = "│"
g.undotree_HelpLine           = 0
g.undotree_CursorLine         = 1
