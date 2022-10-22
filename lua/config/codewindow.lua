require("codewindow").setup({
    exclude_filetypes = { -- Choose certain filetypes to not show minimap on
        "aerial",
        "alpha",
        "DiffviewFileHistory",
        "DiffviewFiles",
        "diff",
        "help",
        "minimap",
        "neo-tree",
        "NvimTree",
        "Outline",
        "qf",
        "TelescopePrompt",
        "terminal",
        "Trouble",
        "undotree",
    },
    z_index = 50, -- The z-index the floating window will be on
})
