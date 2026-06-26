return function(shared)
    return {
        root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            on_dir(shared.lspconfig.util.root_pattern(shared.root_files)(fname))
        end,
        settings = {
            Lua = {
                telemetry = {
                    enable = false,
                },
                format = {
                    enable = false,
                },
                hint = {
                    enable = true,
                },
            },
        },
        on_attach = shared.on_attach,
        capabilities = shared.capabilities(),
        handlers = shared.handlers,
    }
end
