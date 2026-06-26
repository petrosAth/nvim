return function(shared)
    return {
        filetypes = { "makefile", "sh", "zsh" },
        on_attach = shared.on_attach,
        capabilities = shared.capabilities(),
        handlers = shared.handlers,
    }
end
