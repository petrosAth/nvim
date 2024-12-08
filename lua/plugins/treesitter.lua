local function setup(nvim_treesitter)
    nvim_treesitter.setup({
        ignore_install = { "comment" },
        ensure_installed = "all",
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
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
                    ["]A"] = "@parameter.outer",
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[a"] = "@parameter.inner",
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[A"] = "@parameter.inner",
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
        },
    })
end

local function setup_context_commentstring()
    local loaded, context_commentstring = pcall(require, "ts_context_commentstring")
    if not loaded then
        USER.loading_error_msg("ts_context_commentstring")
        return
    end

    context_commentstring.setup()
end

return {
    {
        -- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter in
        -- Neovim and to provide some basic functionality such as highlighting based on it
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            -- Syntax aware text-objects, select, move, swap, and peek support.
            "nvim-treesitter/nvim-treesitter-textobjects",
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
            setup_context_commentstring()
        end,
    },
}
