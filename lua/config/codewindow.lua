local b = USER.styling.borders.default

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
    minimap_width = 10, -- The width of the text part of the minimap
    width_multiplier = 8, -- How many characters one dot represents
    z_index = 45, -- The z-index the floating window will be on
    window_border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l }, -- The border style of the floating window (accepts all usual options)
})
