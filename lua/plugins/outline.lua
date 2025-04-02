local function setup(outline)
    local icons = USER.styling.icons
    local kinds = icons.lsp.kinds
    local fillchars = icons.fillchars.global
    local borders = USER.styling.borders.default
    local transparency = USER.styling.variables.transparency

    outline.setup({
        outline_window = {
            -- Where to open the split window: right/left
            position = "left",

            -- Percentage or integer of columns
            width = 15,
            -- Whether width is relative to the total width of nvim
            -- When relative_width = true, this means take 25% of the total
            -- screen width for outline window.
            relative_width = true,

            -- Auto close the outline window if goto_location is triggered and not for
            -- peek_location
            auto_close = false,
            -- Automatically scroll to the location in code when navigating outline window.
            auto_jump = false,
            -- boolean or integer for milliseconds duration to apply a temporary highlight
            -- when jumping. false to disable.
            jump_highlight_duration = 300,
            -- Whether to center the cursor line vertically in the screen when
            -- jumping/focusing. Executes zz.
            center_on_jump = true,

            -- Vim options for the outline window
            show_numbers = false,
            show_relative_numbers = true,
            wrap = false,
        },
        -- Options for outline guides which help show tree hierarchy of symbols
        guides = {
            enabled = false,
        },
        symbol_folding = {
            markers = { fillchars.foldclose, fillchars.foldopen },
        },
        preview_window = {
            width = 30, -- Percentage or integer of columns
            min_width = 80, -- Minimum number of columns
            -- Whether width is relative to the total width of nvim.
            -- When relative_width = true, this means take 50% of the total
            -- screen width for preview window, ensure the result width is at least 50
            -- characters wide.
            relative_width = true,
            height = 30, -- Percentage or integer of lines
            min_height = 20, -- Minimum number of lines
            -- Similar to relative_width, except the height is relative to the outline
            -- window's height.
            relative_height = true,
            -- Border option for floating preview window.
            -- Options include: single/double/rounded/solid/shadow or an array of border
            -- characters.
            -- See :help nvim_open_win() and search for "border" option.
            border = {
                { borders.tl, "FloatBorder" },
                { borders.t, "FloatBorder" },
                { borders.tr, "FloatBorder" },
                { borders.r, "FloatBorder" },
                { borders.br, "FloatBorder" },
                { borders.b, "FloatBorder" },
                { borders.bl, "FloatBorder" },
                { borders.l, "FloatBorder" },
            },
            -- winhl options for the preview window, see ':h winhl'
            winhl = "NormalFloat:NormalFloat",
            -- Pseudo-transparency of the preview window, see ':h winblend'
            winblend = transparency,
            -- Experimental feature that let's you edit the source content live
            -- in the preview window. Like VS Code's "peek editor".
            live = false,
        },
        -- These keymaps can be a string or a table for multiple keys.
        -- Set to `{}` to disable. (Using 'nil' will fallback to default keys)
        keymaps = {
            show_help = "?",
            close = { "<Esc>", "q" },
            -- Jump to symbol under cursor.
            -- It can auto close the outline window when triggered, see
            -- 'auto_close' option above.
            goto_location = "<Cr>",
            -- Jump to symbol under cursor but keep focus on outline window.
            peek_location = "p",
            -- Visit location in code and close outline immediately
            goto_and_close = "o",
            -- Change cursor position of outline window to match current location in code.
            -- 'Opposite' of goto/peek_location.
            restore_location = "<C-g>",
            -- Open LSP/provider-dependent symbol hover information
            hover_symbol = "K",
            -- Preview location code of the symbol under cursor
            toggle_preview = "P",
            rename_symbol = "r",
            code_actions = "a",
            -- These fold actions are collapsing tree nodes, not code folding
            fold = { "h", "zc" },
            unfold = { "l", "zo" },
            fold_toggle = "za",
            -- Toggle folds for all nodes.
            -- If at least one node is folded, this action will fold all nodes.
            -- If all nodes are folded, this action will unfold all nodes.
            fold_toggle_all = "zA",
            fold_all = "zM",
            unfold_all = "zR",
            fold_reset = "zN",
            -- Move down/up by one line and peek_location immediately.
            -- You can also use outline_window.auto_jump=true to do this for any
            -- j/k/<down>/<up>.
            down_and_jump = "<C-n>",
            up_and_jump = "<C-p>",
        },
        symbols = {
            -- Filter by kinds (string) for symbols in the outline.
            -- Possible kinds are the Keys in the icons table below.
            -- A filter list is a string[] with an optional exclude (boolean) field.
            -- The symbols.filter option takes either a filter list or ft:filterList
            -- key-value pairs.
            -- Put  exclude=true  in the string list to filter by excluding the list of
            -- kinds instead.
            -- Include all except String and Constant:
            --   filter = { 'String', 'Constant', exclude = true }
            -- Only include Package, Module, and Function:
            --   filter = { 'Package', 'Module', 'Function' }
            -- See more examples below.
            filter = nil,
            icons = {
                Array = { icon = kinds.Constant, hl = "@variable.member" },
                Boolean = { icon = kinds.Boolean, hl = "@boolean" },
                Class = { icon = kinds.Class, hl = "@type" },
                Component = { icon = kinds.Function, hl = "@function" },
                Constant = { icon = kinds.Constant, hl = "@constant" },
                Constructor = { icon = kinds.Constructor, hl = "@constructor" },
                Enum = { icon = kinds.Enum, hl = "Structure" },
                EnumMember = { icon = kinds.EnumMember, hl = "Constant" },
                Event = { icon = kinds.Event, hl = "@keyword" },
                Field = { icon = kinds.Field, hl = "@variable.member" },
                File = { icon = kinds.File, hl = "Directory" },
                Fragment = { icon = kinds.Constant, hl = "@constant" },
                Function = { icon = kinds.Function, hl = "@function" },
                Interface = { icon = kinds.Interface, hl = "@type" },
                Key = { icon = kinds.Keyword, hl = "@keyword" },
                Macro = { icon = kinds.Module, hl = "@macro" },
                Method = { icon = kinds.Method, hl = "@function" },
                Module = { icon = kinds.Module, hl = "@include" },
                Namespace = { icon = kinds.Module, hl = "@module" },
                Null = { icon = kinds.Enum, hl = "@comment" },
                Number = { icon = kinds.Number, hl = "@number" },
                Object = { icon = kinds.Enum, hl = "@type" },
                Operator = { icon = kinds.Operator, hl = "@operator" },
                Package = { icon = kinds.Module, hl = "@include" },
                Parameter = { icon = kinds.TypeParameter, hl = "@variable.parameter" },
                Property = { icon = kinds.Property, hl = "@property" },
                StaticMethod = { icon = kinds.Method, hl = "@constant" },
                String = { icon = kinds.Text, hl = "@string" },
                Struct = { icon = kinds.Struct, hl = "Structure" },
                TypeParameter = { icon = kinds.TypeParameter, hl = "@variable.parameter" },
                TypeAlias = { icon = kinds.TypeParameter, hl = "@type.definition" },
                Variable = { icon = kinds.Variable, hl = "@variable" },
            },
        },
    })
end

return {
    {
        "hedyhli/outline.nvim",
        cmd = { "Outline", "OutlineOpen" },
        config = function()
            local loaded, outline = pcall(require, "outline")
            if not loaded then
                USER.loading_error_msg("outline.nvim")
                return
            end

            setup(outline)
        end,
    },
}
