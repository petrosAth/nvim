local function setup(indent_blankline)
    local icons = USER.styling.icons.indentLine

    indent_blankline.setup({
        indent = {
            char = { icons.char[1], icons.char[2] },
        },
        scope = {
            char = { icons.context_char[1] },
            include = {
                node_type = {
                    lua = {
                        "chunk",
                        "do_statement",
                        "while_statement",
                        "repeat_statement",
                        "if_statement",
                        "for_statement",
                        "function_declaration",
                        "function_definition",
                        "table_constructor",
                        -- "assignment_statement",
                    },
                    typescript = {
                        "statement_block",
                        "function",
                        "arrow_function",
                        "function_declaration",
                        "method_definition",
                        "for_statement",
                        "for_in_statement",
                        "catch_clause",
                        "object_pattern",
                        "arguments",
                        "switch_case",
                        "switch_statement",
                        "switch_default",
                        "object",
                        "object_type",
                        "ternary_expression",
                    },
                },
            },
        },
        exclude = {
            filetypes = {
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
            buftypes = {
                "nofile",
                "nowrite",
                "quickfix",
                "terminal",
                "prompt",
            },
        },
    })
end

return {
    {
        -- This plugin adds indentation guides to all lines (including empty lines).
        "lukas-reineke/indent-blankline.nvim",
        -- commit = "9637670896b68805430e2f72cf5d16be5b97a22a",
        dependencies = {
            -- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter
            -- in Neovim and to provide some basic functionality such as highlighting based on it
            "nvim-treesitter/nvim-treesitter",
        },
        event = { "BufReadPre" },
        config = function()
            local loaded, indent_blankline = pcall(require, "ibl")
            if not loaded then
                USER.loading_error_msg("indent-blankline.nvim")
                return
            end

            setup(indent_blankline)
        end,
    },
}
