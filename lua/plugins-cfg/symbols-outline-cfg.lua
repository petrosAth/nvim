
local M = {}

function M.setup()
    vim.cmd([[
        augroup OUTLINE
            autocmd!
            autocmd ColorScheme *
                    \ highlight FocusedSymbol cterm=reverse ctermfg=84 gui=reverse guifg=#50fa7b |
                    \ highlight previewBg ctermbg=236 guibg=#282a36
            autocmd FileType Outline setlocal
                    \ nolist
                    \ foldcolumn=0 signcolumn=no colorcolumn=0
                    \ nonumber relativenumber
                    \ fillchars+=eob:\ "
        augroup END
    ]])
    vim.g.symbols_outline = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = "right",
        relative_width = false,
        width = 50,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = "previewBg",
        keymaps = { --{{{
            close = {"<Esc>", "q"},
            goto_location = "<Cr>",
            focus_location = "l",
            hover_symbol = "<C-space>",
            toggle_preview = "K",
            rename_symbol = "R",
            code_actions = "a",
        },--}}}
        lsp_blacklist = {},
        symbol_blacklist = {},
        symbols = {--{{{
            File = {icon = "", hl = "TSURI"},
            Module = {icon = "", hl = "TSNamespace"},
            Namespace = {icon = "", hl = "TSNamespace"},
            Package = {icon = "", hl = "TSNamespace"},
            Class = {icon = "ﴯ", hl = "TSType"},
            Method = {icon = "", hl = "TSMethod"},
            Property = {icon = "ﰠ", hl = "TSMethod"},
            Field = {icon = "ﰠ", hl = "TSField"},
            Constructor = {icon = "", hl = "TSConstructor"},
            Enum = {icon = "", hl = "TSType"},
            Interface = {icon = "", hl = "TSType"},
            Function = {icon = "", hl = "TSFunction"},
            Variable = {icon = "", hl = "TSConstant"},
            Constant = {icon = "", hl = "TSConstant"},
            String = {icon = "", hl = "TSString"},
            Number = {icon = "#", hl = "TSNumber"},
            Boolean = {icon = "⊨", hl = "TSBoolean"},
            Array = {icon = "", hl = "TSConstant"},
            Object = {icon = "⦿", hl = "TSType"},
            Key = {icon = "", hl = "TSType"},
            Null = {icon = "NULL", hl = "TSType"},
            EnumMember = {icon = "", hl = "TSField"},
            Struct = {icon = "פּ", hl = "TSType"},
            Event = {icon = "", hl = "TSType"},
            Operator = {icon = "", hl = "TSOperator"},
            TypeParameter = {icon = "", hl = "TSParameter"},
        }--}}}
    }
end

function M.config()
    -- Symbols-outline mappings
    local map = vim.api.nvim_set_keymap
    local ns_opts = { noremap = true, silent = true }

    map("n", "<Leader>s", "<cmd>SymbolsOutline<CR>", ns_opts)
end

return M
