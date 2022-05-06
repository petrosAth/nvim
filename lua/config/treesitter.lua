require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    autotag = {
        enable = true,
        filetypes = { "html" , "xml" },
    },
    context_commentstring = {
        enable = true
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
    }
})
