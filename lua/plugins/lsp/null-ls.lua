local M = {}

local sources = function(null_ls)
    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting

    return {
        diagnostics.selene,
        diagnostics.zsh,
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
        formatting.shfmt.with({
            args = {
                "--filename",
                "$FILENAME",
                "-i",
                "4", -- 0 for tabs (default), >0 for number of spaces
                "-bn", -- binary ops like && and | may start a line
                "-sr", -- redirect operators will be followed by a space
            },
            filetypes = {
                "sh",
                "zsh",
            },
        }),
        formatting.stylua,
    }
end

function M.setup(border, root_files)
    local loaded, null_ls = pcall(require, "null-ls")
    if not loaded then
        USER.loading_error_msg("null-ls.nvim")
        return
    end

    null_ls.setup({
        root_dir = require("null-ls.utils").root_pattern(table.concat(root_files, " ,")),
        sources = sources(null_ls),
        border = border,
    })
end

return M
