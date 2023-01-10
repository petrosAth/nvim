local function setup(cmp, luasnip, kinds)
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

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
end

return {
    {
        -- nvim-cmp
        -- A completion engine plugin for neovim written in Lua. Completion sources are installed from external
        -- repositories and "sourced".
        "hrsh7th/nvim-cmp",
        event = {
            "InsertEnter",
        },
        dependencies = {
            -- cmp-nvim-lua
            -- nvim-cmp source for neovim Lua API.
            "hrsh7th/cmp-nvim-lua",
            -- cmp-nvim-lsp
            -- nvim-cmp source for neovim's built-in language server client.
            "hrsh7th/cmp-nvim-lsp",
            -- cmp_luasnip
            -- luasnip completion source for nvim-cmp
            "saadparwaiz1/cmp_luasnip",
            -- cmp-buffer
            -- nvim-cmp source for buffer words.
            "hrsh7th/cmp-buffer",
            -- cmp-spell
            -- spell source for nvim-cmp based on vim's spellsuggest.
            "f3fora/cmp-spell",
            -- cmp-path
            -- nvim-cmp source for filesystem paths.
            "hrsh7th/cmp-path",
            -- cmp-cmdline
            -- nvim-cmp source for vim's cmdline.
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            local loaded_cmp, cmp = pcall(require, "cmp")
            if not loaded_cmp then
                USER.loading_error_msg("nvim-cmp")
                return
            end

            local loaded_luasnip, luasnip = pcall(require, "luasnip")
            if not loaded_luasnip then
                USER.loading_error_msg("LuaSnip")
                return
            end

            local kinds = USER.styling.icons.lsp.kinds
            setup(cmp, luasnip, kinds)
        end,
    },
}
