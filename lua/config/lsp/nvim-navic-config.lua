local i = USER.styling.icons
local navic_kinds = function()
    local lsp_kinds = vim.deepcopy(i.lsp.kinds)
    for kind, icon in pairs(lsp_kinds) do
        lsp_kinds[kind] = icon .. " "
    end
    return lsp_kinds
end

require("nvim-navic").setup({
    icons = navic_kinds(),
    highlight = true,
    separator = string.format(" %s ", i.arrowr[1]),
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true,
})
