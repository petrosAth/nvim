local function setup(aerial)
    local icons = USER.styling.icons
    local borders = USER.styling.borders.default
    local kinds = icons.lsp.kinds
    local fillchars = icons.fillchars.global

    aerial.setup({
        -- Priority list of preferred backends for aerial.
        -- This can be a filetype map (see :help aerial-filetype-map)
        backends = { "lsp", "treesitter", "markdown", "man" },
        layout = {
            -- These control the width of the aerial window.
            -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_width and max_width can be a list of mixed types.
            -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
            max_width = { 50, 0.25 },
            width = nil,
            min_width = 10,
            -- key-value pairs of window-local options for aerial window (e.g. winhl)
            win_opts = {},
            -- Determines the default direction to open the aerial window. The 'prefer'
            -- options will open the window in the other direction *if* there is a
            -- different buffer in the way of the preferred direction
            -- Enum: prefer_right, prefer_left, right, left, float
            default_direction = "prefer_right",
            -- Determines where the aerial window will be opened
            --   edge   - open aerial at the far right/left of the editor
            --   window - open aerial to the right/left of the current window
            placement = "edge",
            -- Preserve window size equality with (:help CTRL-W_=)
            preserve_equality = true,
        },
        -- Determines how the aerial window decides which buffer to display symbols for
        --   window - aerial window will display symbols for the buffer in the window from which it was opened
        --   global - aerial window will display symbols for the current window
        attach_mode = "global",
        -- List of enum values that configure when to auto-close the aerial window
        --   unfocus       - close aerial when you leave the original source window
        --   switch_buffer - close aerial when you change buffers in the source window
        --   unsupported   - close aerial when attaching to a buffer that has no symbol source
        close_automatic_events = { "unsupported" },
        -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("aerial.actions").<name>
        -- Set to `false` to remove a keymap
        keymaps = {
            ["?"] = "actions.show_help",
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.jump",
            ["<2-LeftMouse>"] = "actions.jump",
            ["<C-v>"] = "actions.jump_vsplit",
            ["<C-s>"] = "actions.jump_split",
            ["p"] = "actions.scroll",
            ["<C-j>"] = "actions.down_and_scroll",
            ["<C-k>"] = "actions.up_and_scroll",
            ["{"] = "actions.prev",
            ["}"] = "actions.next",
            ["[["] = "actions.prev_up",
            ["]]"] = "actions.next_up",
            ["q"] = "actions.close",
            ["o"] = "actions.tree_toggle",
            ["za"] = "actions.tree_toggle",
            ["O"] = "actions.tree_toggle_recursive",
            ["zA"] = "actions.tree_toggle_recursive",
            ["l"] = "actions.tree_open",
            ["zo"] = "actions.tree_open",
            ["L"] = "actions.tree_open_recursive",
            ["zO"] = "actions.tree_open_recursive",
            ["h"] = "actions.tree_close",
            ["zc"] = "actions.tree_close",
            ["H"] = "actions.tree_close_recursive",
            ["zC"] = "actions.tree_close_recursive",
            ["zr"] = "actions.tree_increase_fold_level",
            ["zR"] = "actions.tree_open_all",
            ["zm"] = "actions.tree_decrease_fold_level",
            ["zM"] = "actions.tree_close_all",
            ["zx"] = "actions.tree_sync_folds",
            ["zX"] = "actions.tree_sync_folds",
        },
        -- When true, don't load aerial until a command or function is called
        -- Defaults to true, unless `on_attach` is provided, then it defaults to false
        lazy_load = true,
        -- Disable aerial on files with this many lines
        disable_max_lines = 10000,
        -- Disable aerial on files this size or larger (in bytes)
        disable_max_size = 2000000, -- Default 2MB
        -- A list of all symbols to display. Set to false to display all symbols.
        -- This can be a filetype map (see :help aerial-filetype-map)
        -- To see all available values, see :help SymbolKind
        filter_kind = {
            -- "Array",
            -- "Boolean",
            "Class",
            "Constant",
            "Constructor",
            "Enum",
            -- "EnumMember",
            -- "Event",
            -- "Field",
            -- "File",
            "Function",
            "Interface",
            -- "Key",
            "Method",
            "Module",
            -- "Namespace",
            -- "Null",
            -- "Number",
            -- "Object",
            -- "Operator",
            "Package",
            -- "Property",
            -- "String",
            "Struct",
            -- "TypeParameter",
            -- "Variable",
        },
        -- Determines line highlighting mode when multiple splits are visible.
        -- split_width   Each open window will have its cursor location marked in the
        --               aerial buffer. Each line will only be partially highlighted
        --               to indicate which window is at that location.
        -- full_width    Each open window will have its cursor location marked as a
        --               full-width highlight in the aerial buffer.
        -- last          Only the most-recently focused window will have its location
        --               marked in the aerial buffer.
        -- none          Do not show the cursor locations in the aerial window.
        highlight_mode = "split_width",
        -- Highlight the closest symbol if the cursor is not exactly on one.
        highlight_closest = true,
        -- Highlight the symbol in the source buffer when cursor is in the aerial win
        highlight_on_hover = true,
        -- When jumping to a symbol, highlight the line for this many ms.
        -- Set to false to disable
        highlight_on_jump = 300,
        -- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
        -- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
        -- default collapsed icon. The default icon set is determined by the
        -- "nerd_font" option below.
        -- If you have lspkind-nvim installed, it will be the default icon set.
        -- This can be a filetype map (see :help aerial-filetype-map)
        icons = {
            -- TODO: Use a function
            Array = "  " .. kinds.Array,
            ArrayCollapsed = fillchars.foldclose .. " " .. kinds.Array,
            Boolean = "  " .. kinds.Boolean,
            BooleanCollapsed = fillchars.foldclose .. " " .. kinds.Boolean,
            Class = "  " .. kinds.Class,
            ClassCollapsed = fillchars.foldclose .. " " .. kinds.Class,
            Constant = "  " .. kinds.Constant,
            ConstantCollapsed = fillchars.foldclose .. " " .. kinds.Constant,
            Constructor = "  " .. kinds.Constructor,
            ConstructorCollapsed = fillchars.foldclose .. " " .. kinds.Constructor,
            Enum = "  " .. kinds.Enum,
            EnumCollapsed = fillchars.foldclose .. " " .. kinds.Enum,
            EnumMember = "  " .. kinds.EnumMember,
            EnumMemberCollapsed = fillchars.foldclose .. " " .. kinds.EnumMember,
            Event = "  " .. kinds.Event,
            EventCollapsed = fillchars.foldclose .. " " .. kinds.Event,
            Field = "  " .. kinds.Field,
            FieldCollapsed = fillchars.foldclose .. " " .. kinds.Field,
            File = "  " .. kinds.File,
            FileCollapsed = fillchars.foldclose .. " " .. kinds.File,
            Function = "  " .. kinds.Function,
            FunctionCollapsed = fillchars.foldclose .. " " .. kinds.Function,
            Interface = "  " .. kinds.Interface,
            InterfaceCollapsed = fillchars.foldclose .. " " .. kinds.Interface,
            Key = "  " .. kinds.Key,
            KeyCollapsed = fillchars.foldclose .. " " .. kinds.Key,
            Method = "  " .. kinds.Method,
            MethodCollapsed = fillchars.foldclose .. " " .. kinds.Method,
            Module = "  " .. kinds.Module,
            ModuleCollapsed = fillchars.foldclose .. " " .. kinds.Module,
            Namespace = "  " .. kinds.Namespace,
            NamespaceCollapsed = fillchars.foldclose .. " " .. kinds.Namespace,
            Null = "  " .. kinds.Null,
            NullCollapsed = fillchars.foldclose .. " " .. kinds.Null,
            Number = "  " .. kinds.Number,
            NumberCollapsed = fillchars.foldclose .. " " .. kinds.Number,
            Object = "  " .. kinds.Object,
            ObjectCollapsed = fillchars.foldclose .. " " .. kinds.Object,
            Operator = "  " .. kinds.Operator,
            OperatorCollapsed = fillchars.foldclose .. " " .. kinds.Operator,
            Package = "  " .. kinds.Package,
            PackageCollapsed = fillchars.foldclose .. " " .. kinds.Package,
            Property = "  " .. kinds.Property,
            PropertyCollapsed = fillchars.foldclose .. " " .. kinds.Property,
            String = "  " .. kinds.String,
            StringCollapsed = fillchars.foldclose .. " " .. kinds.String,
            Struct = "  " .. kinds.Struct,
            StructCollapsed = fillchars.foldclose .. " " .. kinds.Struct,
            TypeParameter = "  " .. kinds.TypeParameter,
            TypeParameterCollapsed = fillchars.foldclose .. " " .. kinds.TypeParameter,
            Variable = "  " .. kinds.Variable,
            VariableCollapsed = fillchars.foldclose .. " " .. kinds.Variable,
        },
        -- Control which windows and buffers aerial should ignore.
        -- Aerial will not open when these are focused, and existing aerial windows will not be updated
        ignore = {
            -- Ignore unlisted buffers. See :help buflisted
            unlisted_buffers = true,
            -- List of filetypes to ignore.
            filetypes = {},
            -- Ignored buftypes.
            -- Can be one of the following:
            -- false or nil - No buftypes are ignored.
            -- "special"    - All buffers other than normal and help buffers are ignored.
            -- table        - A list of buftypes to ignore. See :help buftype for the
            --                possible values.
            -- function     - A function that returns true if the buffer should be
            --                ignored or false if it should not be ignored.
            --                Takes two arguments, `bufnr` and `buftype`.
            buftypes = "special",
            -- Ignored wintypes.
            -- Can be one of the following:
            -- false or nil - No wintypes are ignored.
            -- "special"    - All windows other than normal windows are ignored.
            -- table        - A list of wintypes to ignore. See :help win_gettype() for the
            --                possible values.
            -- function     - A function that returns true if the window should be
            --                ignored or false if it should not be ignored.
            --                Takes two arguments, `winid` and `wintype`.
            wintypes = "special",
        },
        -- Use symbol tree for folding. Set to true or false to enable/disable
        -- Set to "auto" to manage folds if your previous foldmethod was 'manual'
        -- This can be a filetype map (see :help aerial-filetype-map)
        manage_folds = false,
        -- When you fold code with za, zo, or zc, update the aerial tree as well.
        -- Only works when manage_folds = true
        link_folds_to_tree = false,
        -- Fold code when you open/collapse symbols in the tree.
        -- Only works when manage_folds = true
        link_tree_to_folds = true,
        -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
        -- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
        nerd_font = "auto",
        -- When true, aerial will automatically close after jumping to a symbol
        close_on_select = false,
        -- The autocmds that trigger symbols update (not used for LSP backend)
        update_events = "TextChanged,InsertLeave",
        -- Show box drawing characters for the tree hierarchy
        show_guides = false,
        -- Customize the characters used when show_guides = true
        guides = {
            -- When the child item has a sibling below it
            mid_item = "├─",
            -- When the child item is the last in the list
            last_item = "└─",
            -- When there are nested child guides to the right
            nested_top = "│ ",
            -- Raw indentation
            whitespace = "  ",
        },
        -- Options for opening aerial in a floating win
        float = {
            -- Controls border appearance. Passed to nvim_open_win
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
            -- Determines location of floating window
            --   cursor - Opens float on top of the cursor
            --   editor - Opens float centered in the editor
            --   win    - Opens float centered in the window
            relative = "cursor",
            -- These control the height of the floating window.
            -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_height and max_height can be a list of mixed types.
            -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
            max_height = 0.9,
            height = nil,
            min_height = { 8, 0.1 },
        },
        lsp = {
            -- Fetch document symbols when LSP diagnostics update.
            -- If false, will update on buffer changes.
            diagnostics_trigger_update = true,
            -- Set to false to not update the symbols when there are LSP errors
            update_when_errors = true,
            -- How long to wait (in ms) after a buffer change before updating
            -- Only used when diagnostics_trigger_update = false
            update_delay = 300,
        },
        treesitter = {
            -- How long to wait (in ms) after a buffer change before updating
            update_delay = 300,
        },
        markdown = {
            -- How long to wait (in ms) after a buffer change before updating
            update_delay = 300,
        },
        man = {
            -- How long to wait (in ms) after a buffer change before updating
            update_delay = 300,
        },
    })
end

local function set_kinds_hl_groups()
    local getHl = require("themes.utilities").getHl
    local hl_groups = {
        Array = getHl("@field"),
        Boolean = getHl("@boolean"),
        Class = getHl("@function"),
        Constant = getHl("@constant"),
        Constructor = getHl("@constructor"),
        Enum = getHl("@structure"),
        EnumMember = getHl("@structure"),
        Event = getHl("@keyword"),
        Field = getHl("@field"),
        File = getHl("Directory"),
        Function = getHl("@function"),
        Interface = getHl("@type"),
        Key = getHl("@keyword"),
        Method = getHl("@method"),
        Module = getHl("@include"),
        Namespace = getHl("@namespace"),
        Null = getHl("@comment"),
        Number = getHl("@number"),
        Object = getHl("@type"),
        Operator = getHl("@operator"),
        Package = getHl("@include"),
        Property = getHl("@property"),
        String = getHl("@string"),
        Struct = getHl("@structure"),
        TypeParameter = getHl("@type"),
        Variable = getHl("@variable"),
    }

    for hl_group, hl in pairs(hl_groups) do
        -- vim.api.nvim_set_hl(0, "Aerial" .. hl_group, { fg = hl.fg, bg = getHl("WinBar").bg })
        vim.api.nvim_set_hl(0, "Aerial" .. hl_group, { fg = hl.fg })
        vim.api.nvim_set_hl(0, "Aerial" .. hl_group .. "Icon", { fg = hl.fg })
    end
end

return {
    {
        -- aerial.nvim
        -- Neovim plugin for a code outline window
        "stevearc/aerial.nvim",
        cmd = {
            "AerialToggle",
            "AerialOpen",
            "AerialOpenAll",
            "AerialNext",
            "AerialPrev",
            "AerialGo",
            "AerialInfo",
        },
        config = function()
            local loaded, aerial = pcall(require, "aerial")
            if not loaded then
                USER.loading_error_msg("aerial.nvim")
                return
            end

            setup(aerial)
            set_kinds_hl_groups()
        end,
    },
}
