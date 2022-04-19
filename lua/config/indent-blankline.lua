local excFiletypes = {
    "aerial",
    "alpha",
    "diff",
    "help",
    "lsp-installer",
    "man",
    "minimap",
    "NvimTree",
    "Outline",
    "packer",
    "qf",
    "Trouble",
    "undotree",
}

local excBuftypes = {
    "nofile",
    "nowrite",
    "quickfix",
    "terminal",
    "prompt",
}

require("indent_blankline").setup({
    char_list = { "│", "┆" }, -- '¦', '┆', '┊', "│", '|',
    space_char_blankline = " ",
    filetype_exclude = excFiletypes,
    buftype_exclude = excBuftypes,
    show_first_indent_level = true,
    show_trailing_blankline_indent = true,
    show_end_of_line = false,
    show_current_context = true, -- Need treesitter
    show_current_context_start = true, -- Need treesitter
    show_current_context_start_on_current_line = false,
    use_treesitter = true, -- Need treesitter
    indent_level = 20,
    show_foldtext = true,
})
