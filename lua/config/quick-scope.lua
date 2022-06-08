local g = vim.g

-- g.qs_highlight_on_keys = { "f", "F", "t", "T" }
g.qs_delay = 200
g.qs_max_chars = 200
g.qs_buftype_blacklist = {
    "terminal",
    "nofile"
}
g.qs_filetype_blacklist = {
    "alpha",
    "diff",
    "help",
    "lsp-installer",
    "minimap",
    "NvimTree",
    "Outline",
    "packer",
    "qf",
    "TelescopePrompt",
    "Trouble",
    "undotree"
}
