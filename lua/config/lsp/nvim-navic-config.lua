local loaded, navic = pcall(require, "nvim-navic")
if not loaded then
    return
end

local i = USER.styling.icons
local navic_kinds = function()
    local lsp_kinds = vim.deepcopy(i.lsp.kinds)
    for kind, icon in pairs(lsp_kinds) do
        lsp_kinds[kind] = icon .. " "
    end
    return lsp_kinds
end

navic.setup({
    icons = navic_kinds(),
    highlight = true,
    separator = string.format(" %s ", i.arrow.hollow.r),
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.supports_method "textDocument/documentSymbol" then
            navic.attach(client, bufnr)
        end
    end,
})

