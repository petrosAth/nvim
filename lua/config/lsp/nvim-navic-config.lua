local M = {}

local navic_kinds = function(icons)
    local lsp_kinds = vim.deepcopy(icons.lsp.kinds)
    for kind, icon in pairs(lsp_kinds) do
        lsp_kinds[kind] = icon .. " "
    end
    return lsp_kinds
end

function M.setup(icons)
    local loaded, navic = pcall(require, "nvim-navic")
    if not loaded then
        vim.notify("nvim-navic", "ERROR", { title = "Loading failed" })
        return
    end

    navic.setup({
        icons = navic_kinds(icons),
        highlight = true,
        separator = string.format(" %s ", icons.arrow.hollow.r),
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = true,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client.supports_method("textDocument/documentSymbol") then
                navic.attach(client, bufnr)
            end
        end,
    })
end

return M
