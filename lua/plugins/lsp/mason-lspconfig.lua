local M = {}

function M.setup(servers)
    local loaded, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not loaded then
        USER.loading_error_msg("mason-lspconfig")
        return
    end

    mason_lspconfig.setup({
        automatic_enable = servers,
    })
end

return M
