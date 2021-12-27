local g = vim.g

-- g.qs_highlight_on_keys = { "f", "F", "t", "T" }
g.qs_delay = 200
g.qs_max_chars = 200
g.qs_buftype_blacklist = {
    "terminal",
    "nofile"
}
g.qs_filetype_blacklist = {
    "packer",
    "lsp-installer",
    "qf",
    "alpha",
    "minimap",
    "Outline",
    "help",
    "Trouble"
}
