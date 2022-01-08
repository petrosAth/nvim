require("nvim-treesitter.configs").setup({
    -- TODO: change to maintained when heavy config editing is done
    ensure_installed = { "bash", "c", "css", "c_sharp", "html", "json", "lua", "markdown", "python" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    autotag = {
        enable = true,
        filetypes = { "html" , "xml" },
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- TODO: make colors change based on theme
        colors = { -- table of hex strings
            "#50fa7b",
            "#bd93f9",
            "#f1fa8c",
            "#8be9fd",
            "#ff79c6",
            "#f8f8f2",
        },
    },
})
