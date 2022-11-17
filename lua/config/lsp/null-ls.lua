local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    sources = {
        formatting.stylua,
        formatting.prettierd.with({
            filetypes = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
                "css",
                "scss",
                "less",
                "html",
                "json",
                "jsonc",
                "yaml",
                -- "markdown",
                -- "markdown.mdx",
                "graphql",
                "handlebars",
            },
            command = "prettierd",
        }),
        diagnostics.selene,
        diagnostics.zsh
    },
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".nvim", ".git"),
})
