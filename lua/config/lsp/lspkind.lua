local lspkind = require("lspkind")
local M = {}

M.symbol_map = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = ""
}

M.config = function()
    require('lspkind').init({
        -- enables text annotations
        -- default: true
        with_text = true,

        -- default: {}
        symbol_map = M.symbol_map
    })
end

return M
