return function(shared)
    return {
        init_options = {
            preferences = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
                importModuleSpecifierPreference = "non-relative",
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
