local lspkind = require("lspkind")
local cmp = require("cmp")
local luasnip = require("luasnip")
local cb = require("styling").border.outline

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kinds = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "ﰕ",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

cmp.setup{
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"]     = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-u>"]     = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-y>"]     = cmp.mapping(cmp.mapping.confirm({ select = true })),
        ["<Tab>"]     = cmp.mapping(
            function(fallback)
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end,
            { "i", "s" }
        ),
        ["<S-Tab>"]   = cmp.mapping(
            function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
            { "i", "s" }
        ),
    }),
    sources = cmp.config.sources({
        { name = "buffer"   },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip"  },
        { name = "path"     },
        { name = "calc"     },
        { name = "spell"    },
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = string.format('%s %s', kinds[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
                buffer   = "[BFR]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[LUA]",
                luasnip  = "[SNP]",
                path     = "[PTH]",
                spell    = "[SPL]",
            })[entry.source.name]
            return vim_item
        end
    },
    experimental = {
        ghost_text = {
            hl_group = "CmpGhostText"
        },
    },
}

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'buffer' }
    })
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        {
            name = 'path',
            -- max_item_count = 20,
            -- keyword_length = 2
        },
        {
            name = 'cmdline',
            -- max_item_count = 20
        },
    })
})
