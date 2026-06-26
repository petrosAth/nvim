return function(shared)
    return {
        init_options = {
            settings = {
                lint = {
                    preview = true,
                },
            },
        },
        on_attach = function(client, bufnr)
            client.server_capabilities.document_formatting = false
            client.server_capabilities.document_range_formatting = false
            shared.on_attach(client, bufnr)
        end,
        capabilities = shared.capabilities(),
        handlers = shared.handlers,
    }
end
