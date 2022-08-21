require("illuminate").configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        "lsp",
        "treesitter",
        "regex",
    },
    -- delay: delay in milliseconds
    delay = 500,
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
        "aerial",
        "alpha",
        "lspinfo",
        "mason.nvim",
        "minimap",
        "NvimTree",
        "Outline",
        "packer",
        "qf",
        "Trouble",
        "undotree",
    },
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    modes_denylist = { "i", "v" },
    -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
    modes_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
})
