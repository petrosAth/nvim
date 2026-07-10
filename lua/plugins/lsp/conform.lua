local M = {}

-- Filetype → formatters. Mirrors the formatters previously registered via
-- none-ls. Conform runs the listed formatters sequentially; an empty/absent
-- entry falls back to the LSP server (see `default_format_opts` below).
local formatters_by_ft = {
    lua              = { "stylua" },
    python           = { "black" },
    php              = { "php_cs_fixer" },
    javascript       = { "prettierd" },
    javascriptreact  = { "prettierd" },
    typescript       = { "prettierd" },
    typescriptreact  = { "prettierd" },
    vue              = { "prettierd" },
    css              = { "prettierd" },
    scss             = { "prettierd" },
    less             = { "prettierd" },
    html             = { "prettierd" },
    json             = { "prettierd" },
    jsonc            = { "prettierd" },
    yaml             = { "prettierd" },
    markdown         = { "prettierd" },
    ["markdown.mdx"] = { "prettierd" },
    graphql          = { "prettierd" },
    handlebars       = { "prettierd" },
    sh               = { "shfmt" },
    zsh              = { "shfmt" },
    htmldjango       = { "djlint" },
    jinja            = { "djlint" },
}

function M.setup()
    local loaded, conform = pcall(require, "conform")
    if not loaded then
        USER.loading_error_msg("conform.nvim")
        return
    end

    conform.setup({
        formatters_by_ft = formatters_by_ft,
        -- Run the configured formatter, falling back to the LSP server when a
        -- filetype has no formatter. Inherited by `conform.format` calls
        -- (format-on-save augroup, `<Space>lf`).
        default_format_opts = {
            lsp_format = "fallback",
        },
        notify_on_error = true,
        -- Preserve the previous shfmt arguments: 4-space indent, binary ops may
        -- start a line, redirect operators followed by a space.
        formatters = {
            shfmt = {
                prepend_args = { "-i", "4", "-bn", "-sr" },
            },
        },
    })
end

return M
