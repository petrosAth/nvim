local M = {}

function M.setup()
    local loaded, config_local = pcall(require, "config-local")
    if not loaded then
        USER.loading_error_msg("nvim-config-local")
        return
    end

    config_local.setup({
        config_files = { USER.local_config.dir .. "/" .. USER.local_config.file }, -- Config file patterns to load
    })
end

return M
