local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end

local function stylize_markdown()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
        contents = vim.lsp.util._normalize_markdown(contents, {
            width = vim.lsp.util._make_floating_popup_size(contents, opts),
        })

        vim.bo[bufnr].filetype = "markdown"
        vim.treesitter.start(bufnr)
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

        return contents
    end
end

-- Source: LazyVim/LazyVim
-- https://github.com/LazyVim/LazyVim/blob/7c7c196a78e936a1bc4cf28e7908e9bd96d75607/lua/lazyvim/util/cmp.lua#L154C1-L156C7
local function snippet_replace(snippet, fn)
    return snippet:gsub("%$%b{}", function(m)
        local n, name = m:match("^%${(%d+):(.+)}$")
        return n and fn({ n = n, text = name }) or m
    end) or snippet
end

local function snippet_preview(snippet)
    local ok, parsed = pcall(function() return vim.lsp._snippet_grammar.parse(snippet) end)
    return ok and tostring(parsed)
        or snippet_replace(snippet, function(placeholder) return snippet_preview(placeholder.text) end):gsub("%$0", "")
end

local function add_missing_snippet_docs(cmp, window)
    local Kind = cmp.lsp.CompletionItemKind
    local entries = window:get_entries()
    for _, entry in ipairs(entries) do
        if entry:get_kind() == Kind.Snippet then
            local item = entry:get_completion_item()
            if not item.documentation and item.insertText then
                item.documentation = {
                    kind = cmp.lsp.MarkupKind.Markdown,
                    value = string.format("```%s\n%s\n```", vim.bo.filetype, snippet_preview(item.insertText)),
                }
            end
        end
    end
end

local function setup(cmp)
    local borders = USER.styling.borders.default
    local kinds = USER.styling.icons.lsp.kinds
    local loaded_luasnip, luasnip = pcall(require, "luasnip")
    if not loaded_luasnip then
        USER.loading_error_msg("LuaSnip")
        return
    end

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        window = {
            documentation = cmp.config.window.bordered({
                border = {
                    borders.tl,
                    borders.t,
                    borders.tr,
                    borders.r,
                    borders.br,
                    borders.b,
                    borders.bl,
                    borders.l,
                },
                winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None",
            }),
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
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "path" },
            { name = "spell" },
        }),
        preselect = cmp.PreselectMode.None,
        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = string.format("  %s %s ", kinds[vim_item.kind], vim_item.kind)
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    buffer = "[BFR]",
                    nvim_lua = "[LUA]",
                    luasnip = "[SNP]",
                    path = "[PTH]",
                    spell = "[ABC]",
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
            { name = "path" },
            { name = "cmdline" },
        }),
    })

    cmp.event:on("menu_opened", function(event)
        add_missing_snippet_docs(cmp, event.window)
        stylize_markdown()
    end)
end

return {
    {
        -- A completion engine plugin for neovim written in Lua. Completion sources are installed from external
        -- repositories and "sourced".
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            -- nvim-cmp source for neovim Lua API.
            "hrsh7th/cmp-nvim-lua",
            -- nvim-cmp source for neovim's built-in language server client.
            "hrsh7th/cmp-nvim-lsp",
            -- nvim-cmp source for buffer words.
            "hrsh7th/cmp-buffer",
            -- spell source for nvim-cmp based on vim's spellsuggest.
            "f3fora/cmp-spell",
            -- nvim-cmp source for filesystem paths.
            "hrsh7th/cmp-path",
            -- nvim-cmp source for vim's cmdline.
            "hrsh7th/cmp-cmdline",
            -- Snippet Engine for Neovim written in Lua.
            "L3MON4D3/LuaSnip",
            -- luasnip completion source for nvim-cmp
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local loaded_cmp, cmp = pcall(require, "cmp")
            if not loaded_cmp then
                USER.loading_error_msg("nvim-cmp")
                return
            end

            setup(cmp)
        end,
    },
}
