local M = {}

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

M.sources = {
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
            "markdown",
            "markdown.mdx",
            "graphql",
            "handlebars",
        },
        command = "prettierd",
    }),
    diagnostics.selene,
    diagnostics.vale,
    diagnostics.zsh,
}

function M.setup(root_files, border)
    null_ls.setup({
        root_dir = require("null-ls.utils").root_pattern(table.concat(root_files, " ,")),
        sources = M.sources,
        border = border,
    })
end

return M
