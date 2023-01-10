return {
    {
        -- nvim-config-local
        -- Secure load local config files for neovim
        "klen/nvim-config-local",
        config = function()
            local loaded, config_local = pcall(require, "config-local")
            if not loaded then
                USER.loading_error_msg("nvim-config-local")
                return
            end

            config_local.setup({
                config_files = { USER.local_config.dir .. "/" .. USER.local_config.file }, -- Config file patterns to load
            })
        end,
    },
}
