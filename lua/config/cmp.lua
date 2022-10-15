local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
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

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
        ["<C-y>"] = cmp.mapping({
            c = cmp.mapping.confirm({ select = true }),
            i = function()
                if cmp.visible() then
                    -- cmp.confirm({ select = true })
                    local entry = cmp.get_selected_entry()
                    if not entry then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        cmp.confirm({ select = true })
                    else
                        cmp.confirm({ select = true })
                    end
                else
                    cmp.complete()
                end
            end,
        }),
        ["<Tab>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    cmp.complete()
                end
            end,
            i = function(fallback)
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end,
        }),
        ["<S-Tab>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    cmp.complete()
                end
            end,
            i = function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
        }),
        ["<C-n>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    vim.api.nvim_feedkeys(t("<Down>"), "n", true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    fallback()
                end
            end,
        }),
        ["<C-p>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    vim.api.nvim_feedkeys(t("<Up>"), "n", true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    fallback()
                end
            end,
        }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp", keyword_length = 0 },
        { name = "buffer",   keyword_length = 1 },
        { name = "nvim_lua", keyword_length = 3 },
        { name = "luasnip",  keyword_length = 0 },
        { name = "path",     keyword_length = 1 },
        { name = "calc",     keyword_length = 3 },
        { name = "spell",    keyword_length = 2 },
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", kinds[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
                buffer   = "[BFR]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[LUA]",
                luasnip  = "[SNP]",
                path     = "[PTH]",
                spell    = "[ABC]",
            })[entry.source.name]
            return vim_item
        end,
    },
    experimental = {
        ghost_text = {
            hl_group = "CmpGhostText",
        },
    },
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
    completion = { autocomplete = false },
    sources = cmp.config.sources({
        { name = "buffer" },
    }),
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
    completion = { autocomplete = false },
    sources = cmp.config.sources({
        {
            name = "path",
            -- max_item_count = 20,
            -- keyword_length = 1
        },
        {
            name = "cmdline",
            -- max_item_count = 20
            -- keyword_length = 1
        },
    }),
})
