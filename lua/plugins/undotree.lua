return {
    {
        "mbbill/undotree",
        cmd = {
            "UndotreeToggle",
            "UndotreeShow",
            "UndotreeHide",
        },
        config = function()
            local g = vim.g

            g.undotree_WindowLayout = 2
            g.undotree_ShortIndicators = 1
            g.undotree_SplitWidth = 30
            g.undotree_DiffpanelHeight = 10
            g.undotree_DiffAutoOpen = 0
            g.undotree_SetFocusWhenToggle = 1
            g.undotree_HelpLine = 0
            g.undotree_CursorLine = 1
        end,
    },
}
