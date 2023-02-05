local M = {}

local navic_kinds = function(icons)
    local lsp_kinds = vim.deepcopy(icons.lsp.kinds)
    for kind, icon in pairs(lsp_kinds) do
        lsp_kinds[kind] = icon .. " "
    end
    return lsp_kinds
end

function M.setup(client, bufnr)
    local loaded, navic = pcall(require, "nvim-navic")
    if not loaded then
        USER.loading_error_msg("nvim-navic")
        return
    end

    local icons = USER.styling.icons

    navic.setup({
        icons = navic_kinds(icons),
        highlight = true,
        separator = string.format(" %s ", icons.arrow.hollow.r),
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = true,
    })

    navic.attach(client, bufnr)
end

return M
