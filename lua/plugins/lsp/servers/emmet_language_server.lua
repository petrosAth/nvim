return function(shared)
    return {
        filetypes = {
            "css",
            "eruby",
            "html",
            "htmldjango",
            "javascriptreact",
            "less",
            "php",
            "pug",
            "sass",
            "scss",
            "smarty",
            "typescriptreact",
            "vue",
        },
        on_attach = shared.on_attach,
        capabilities = shared.capabilities(),
        handlers = shared.handlers,
    }
end
