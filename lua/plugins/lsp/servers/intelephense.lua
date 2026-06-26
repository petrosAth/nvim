return function(shared)
    return {
        init_options = {
            licenceKey = vim.fn.expand("$HOME/intelephense/licence.txt"),
        },
        settings = {
            intelephense = {
                telemetry = { enabled = false },
                format = { enable = false },
            },
        },
        on_attach = shared.on_attach,
        capabilities = shared.capabilities(),
        handlers = shared.handlers,
    }
end
