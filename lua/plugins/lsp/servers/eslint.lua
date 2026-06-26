return function(shared)
    return {
        root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            on_dir(shared.lspconfig.util.root_pattern(shared.root_files)(fname))
        end,
        settings = {
            codeAction = {
                disableRuleComment = {
                    enable = true,
                    location = "separateLine",
                },
                showDocumentation = {
                    enable = true,
                },
            },
            codeActionOnSave = {
                enable = false,
                mode = "all",
            },
            experimental = {
                useFlatConfig = false,
            },
            format = true,
            nodePath = "",
            onIgnoredFiles = "off",
            packageManager = "npm",
            problems = {
                shortenToSingleLine = false,
            },
            quiet = false,
            rulesCustomizations = {},
            run = "onType",
            useESLintClass = false,
            validate = "on",
            workingDirectory = {
                mode = "location",
            },
        },
        on_attach = shared.on_attach,
        capabilities = shared.capabilities(),
        handlers = shared.handlers,
    }
end
