local lspkind = require("lspkind")
local cmp = require("cmp")
local luasnip = require("luasnip")
local cb = require("cosmetics").border.table

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Setup nvim-cmp
cmp.setup{
    completion = { completeopt = "menu,menuone,noinsert" },
    view = {
        entries = "custom" -- can be "custom", "wildmenu" or "native"
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ['<C-y>'] = cmp.mapping({
            i = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ select = true }),
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "buffer" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        { name = "calc" },
        { name = "spell" },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            menu = {
                buffer = "[BFR]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[LUA]",
                luasnip = "[SNP]",
                path = "[PTH]",
                calc = "[CLC]",
                spell = "[SPL]",
            }
        }),
    },
    experimental = {
        ghost_text = true,
    },
	-- documentation = {
 --        border = { cb.tl, cb.t, cb.tr, cb.r, cb.br, cb.b, cb.bl, cb.l }
	-- },
}

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':'.
-- cmp.setup.cmdline(':', {
--     sources = {
--         {
--             name = 'path',
--             max_item_count = 20,
--             keyword_length = 2
--         },
--         {
--             name = 'cmdline',
--             max_item_count = 20
--         },
--     }
-- })
