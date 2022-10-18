require("codewindow").setup({
    minimap_width = 20, -- The width of the text part of the minimap
    width_multiplier = 4, -- How many characters one dot represents
    use_lsp = true, -- Use the builtin LSP to show errors and warnings
    use_treesitter = true, -- Use nvim-treesitter to highlight the code
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
    z_index = 1, -- The z-index the floating window will be on
})
