local M = {}

function M.setup()
    local loaded, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not loaded then
        USER.loading_msg("mason-lspconfig")
        return
    end

    mason_lspconfig.setup()
end

return M
