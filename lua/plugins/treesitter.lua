local function setup(nvim_treesitter)
    nvim_treesitter.setup({
        ensure_installed = "all",
        ignore_install = { "comment" },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                scope_incremental = "<S-CR>",
                node_decremental = "<BS>",
            },
        },
        rainbow = {
            enable = true,
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]a"] = "@parameter.inner",
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[a"] = "@parameter.inner",
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
        },
    })
end

return {
    {
        -- nvim-treesitter
        -- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter in
        -- Neovim and to provide some basic functionality such as highlighting based on it
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost" },
        build = ":TSUpdate",
        dependencies = {
            -- nvim-ts-rainbow
            -- Rainbow parentheses for neovim using tree-sitter.
            "mrjones2014/nvim-ts-rainbow",
            -- nvim-treesitter-textobjects
            -- Syntax aware text-objects, select, move, swap, and peek support.
            "nvim-treesitter/nvim-treesitter-textobjects",
            -- nvim-ts-context-commentstring
            -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            local loaded, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
            if not loaded then
                USER.loading_error_msg("nvim-treesitter")
                return
            end

            setup(nvim_treesitter)
        end,
    },
}
