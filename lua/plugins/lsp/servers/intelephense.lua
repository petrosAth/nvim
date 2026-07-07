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
        -- Detect the target PHP version from the resolved project root's own
        -- `php` (mise, asdf, or plain PATH all resolve correctly here, since
        -- this shells out with cwd = root_dir). Without an explicit
        -- environment.phpVersion, intelephense defaults to assuming its
        -- latest supported PHP version, which produces wrong
        -- diagnostics/suggestions on older codebases. Runs once per client
        -- start (i.e. once per distinct project root), not per buffer.
        before_init = function(_, config)
            local result = vim.system(
                { "php", "-r", "echo PHP_MAJOR_VERSION . '.' . PHP_MINOR_VERSION;" },
                { cwd = config.root_dir, text = true }
            ):wait()
            if result.code == 0 and vim.trim(result.stdout or "") ~= "" then
                config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
                    intelephense = { environment = { phpVersion = vim.trim(result.stdout) } },
                })
            end
        end,
        on_attach = shared.on_attach,
        capabilities = shared.capabilities(),
        handlers = shared.handlers,
    }
end
