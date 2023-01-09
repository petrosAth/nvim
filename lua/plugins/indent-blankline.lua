local excFiletypes = {
    "aerial",
    "alpha",
    "diff",
    "help",
    "man",
    "minimap",
    "neo-tree",
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

return {
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            local loaded, indent_blankline = pcall(require, "indent_blankline")
            if not loaded then
                USER.loading_error_msg("indent-blankline.nvim")
                return
            end

            local i = USER.styling.icons.indentLine

            indent_blankline.setup({
                char_list = { i.char[1], i.char[2] },
                context_char_list = { i.context_char[1] },
                space_char_blankline = " ",
                filetype_exclude = excFiletypes,
                buftype_exclude = excBuftypes,
                show_first_indent_level = true,
                show_trailing_blankline_indent = true,
                show_end_of_line = false,
                show_current_context = true, -- Need treesitter
                show_current_context_start = true, -- Need treesitter
                show_current_context_start_on_current_line = true, -- Need treesitter
                use_treesitter = true, -- Need treesitter
                indent_level = 20,
                show_foldtext = true,
            })
        end,
    },
}
