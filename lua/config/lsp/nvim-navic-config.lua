local i = USER.styling.icons
local k = USER.styling.icons.lsp.kinds
local kp = USER.styling.icons.lsp.kinds_plus
local navic_kinds = function()
    local lsp_kinds = vim.tbl_extend("keep", k, kp)
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
