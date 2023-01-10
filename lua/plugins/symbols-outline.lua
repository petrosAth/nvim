local function setup(symbols_outline, icons, borders)
    local fillchars = icons.fillchars.global
    local kinds = icons.lsp.kinds

    symbols_outline.setup({
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = "right",
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
        relative_width = true,
        width = 25,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = "Pmenu",
        autofold_depth = nil,
        auto_unfold_hover = true,
        fold_markers = { fillchars.foldopen, fillchars.foldclose },
        wrap = false,
        keymaps = {
            close = { "<Esc>", "q" },
            goto_location = "L",
            focus_location = "l",
            hover_symbol = "h",
            toggle_preview = "<M-p>",
            rename_symbol = "R",
            code_actions = "a",
            fold = "zc",
            unfold = "zo",
            fold_all = "zM",
            unfold_all = "zR",
            fold_reset = "za",
        },
        lsp_blacklist = {},
        symbol_blacklist = {},
        symbols = {
            Method = { icon = kinds.Method, hl = "@method" },
            Function = { icon = kinds.Function, hl = "@function" },
            Constructor = { icon = kinds.Constructor, hl = "@constructor" },
            Field = { icon = kinds.Field, hl = "@field" },
            Variable = { icon = kinds.Variable, hl = "@variable" },
            Class = { icon = kinds.Class, hl = "@type" },
            Interface = { icon = kinds.Interface, hl = "@type" },
            Module = { icon = kinds.Module, hl = "@include" },
            Namespace = { icon = kinds.Module, hl = "@namespace" },
            Package = { icon = kinds.Module, hl = "@include" },
            Property = { icon = kinds.Property, hl = "@method" },
            Enum = { icon = kinds.Enum, hl = "@type" },
            Object = { icon = kinds.Enum, hl = "@type" },
            Null = { icon = kinds.Enum, hl = "@type" },
            Key = { icon = kinds.Keyword, hl = "@keyword" },
            File = { icon = kinds.File, hl = "Directory" },
            EnumMember = { icon = kinds.EnumMember, hl = "@field" },
            Constant = { icon = kinds.Constant, hl = "@constant" },
            Array = { icon = kinds.Constant, hl = "@constant" },
            Struct = { icon = kinds.Struct, hl = "@type" },
            Event = { icon = kinds.Event, hl = "@type" },
            Operator = { icon = kinds.Operator, hl = "@operator" },
            TypeParameter = { icon = kinds.TypeParameter, hl = "@parameter" },
            String = { icon = kinds.Text, hl = "@string" },
            Number = { icon = kinds.Number, hl = "@number" },
            Boolean = { icon = kinds.Boolean, hl = "@boolean" },
        },
    })
end

return {
    {
        -- symbols-outline.nvim
        -- A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite
        -- languages.
        "simrat39/symbols-outline.nvim",
        cmd = {
            "SymbolsOutline",
            "SymbolsOutlineOpen",
            "SymbolsOutlineClose",
        },
        config = function()
            local loaded, symbols_outline = pcall(require, "symbols-outline")
            if not loaded then
                USER.loading_error_msg("symbols-outline.nvim")
                return
            end

            local icons = USER.styling.icons
            local borders = USER.styling.borders.default
            setup(symbols_outline, icons, borders)
        end,
    },
}
