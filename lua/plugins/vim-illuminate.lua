return {
    {
        -- illuminate.vim
        -- (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP,
        -- Tree-sitter, or regex matching.
        "RRethy/vim-illuminate",
        event = { "BufReadPost" },
        config = function()
            local loaded, illuminate = pcall(require, "illuminate")
            if not loaded then
                USER.loading_error_msg("vim-illuminate")
                return
            end

            illuminate.configure({
                -- providers: provider used to get references in the buffer, ordered by priority
                providers = {
                    "lsp",
                    "treesitter",
                    "regex",
                },
                -- delay: delay in milliseconds
                delay = 500,
                -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
                filetypes_denylist = {
                    "aerial",
                    "alpha",
                    "Glance",
                    "lazy",
                    "lspinfo",
                    "lspsagafinder",
                    "lspsagaoutline",
                    "mason",
                    "minimap",
                    "neo-tree",
                    "NvimTree",
                    "Outline",
                    "packer",
                    "qf",
                    "sagacodeaction",
                    "Trouble",
                    "undotree",
                },
                -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
                modes_denylist = { "i", "v" },
                -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
                modes_allowlist = {},
                -- under_cursor: whether or not to illuminate under the cursor
                under_cursor = true,
            })
        end,
    },
}
