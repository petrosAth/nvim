local excFiletypes = { "NvimTree", "packer", "dashboard", "alpha", "help", "lsp-installer", "Outline", "minimap" }
local excBuftypes = { "nofile", "nowrite", "quickfix", "terminal", "prompt", }

require("indent_blankline").setup {
    filetype_exclude = excFiletypes,
    buftype_exclude = excBuftypes,
    char_list = { "│", '¦', }, -- '¦', '┆', '┊', "│", '|',
    space_char_blankline = " ",
    indent_blankline_use_treesitter = true, -- Need treesitter
    show_current_context = true, -- Need treesitter
    show_current_context_start = true, -- Need treesitter
    indent_blankline_show_foldtext = false,
}
