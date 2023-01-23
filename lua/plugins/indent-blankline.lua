local function setup(indent_blankline, icons)
    indent_blankline.setup({
        char_list = { icons.char[1], icons.char[2] },
        context_char_list = { icons.context_char[1] },
        space_char_blankline = " ",
        filetype_exclude = {
            "aerial",
            "alpha",
            "diff",
            "help",
            "man",
            "minimap",
            "markdown",
            "neo-tree",
            "NvimTree",
            "Outline",
            "packer",
            "qf",
            "Trouble",
            "undotree",
        },
        buftype_exclude = {
            "nofile",
            "nowrite",
            "quickfix",
            "terminal",
            "prompt",
        },
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
end

return {
    {
        -- Indent Blankline
        -- This plugin adds indentation guides to all lines (including empty lines).
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            local loaded, indent_blankline = pcall(require, "indent_blankline")
            if not loaded then
                USER.loading_error_msg("indent-blankline.nvim")
                return
            end

            local icons = USER.styling.icons.indentLine
            setup(indent_blankline, icons)
        end,
    },
}
