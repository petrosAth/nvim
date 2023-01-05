local M = {}

function M.setup()
    local loaded, symbols_outline = pcall(require, "symbols-outline")
    if not loaded then
        USER.loading_error_msg("symbols-outline.nvim")
        return
    end

    local s = USER.styling
    local f = s.icons.fillchars.global
    local k = s.icons.lsp.kinds
    local b = s.borders.default

    require("symbols-outline").setup({
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = "right",
        border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l },
        relative_width = true,
        width = 25,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = "Pmenu",
        autofold_depth = nil,
        auto_unfold_hover = true,
        fold_markers = { f.foldopen, f.foldclose },
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
            Method = { icon = k.Method, hl = "@method" },
            Function = { icon = k.Function, hl = "@function" },
            Constructor = { icon = k.Constructor, hl = "@constructor" },
            Field = { icon = k.Field, hl = "@field" },
            Variable = { icon = k.Variable, hl = "@variable" },
            Class = { icon = k.Class, hl = "@type" },
            Interface = { icon = k.Interface, hl = "@type" },
            Module = { icon = k.Module, hl = "@include" },
            Namespace = { icon = k.Module, hl = "@namespace" },
            Package = { icon = k.Module, hl = "@include" },
            Property = { icon = k.Property, hl = "@method" },
            Enum = { icon = k.Enum, hl = "@type" },
            Object = { icon = k.Enum, hl = "@type" },
            Null = { icon = k.Enum, hl = "@type" },
            Key = { icon = k.Keyword, hl = "@keyword" },
            File = { icon = k.File, hl = "Directory" },
            EnumMember = { icon = k.EnumMember, hl = "@field" },
            Constant = { icon = k.Constant, hl = "@constant" },
            Array = { icon = k.Constant, hl = "@constant" },
            Struct = { icon = k.Struct, hl = "@type" },
            Event = { icon = k.Event, hl = "@type" },
            Operator = { icon = k.Operator, hl = "@operator" },
            TypeParameter = { icon = k.TypeParameter, hl = "@parameter" },
            String = { icon = k.Text, hl = "@string" },
            Number = { icon = k.Number, hl = "@number" },
            Boolean = { icon = k.Boolean, hl = "@boolean" },
        },
    })
end

return M
