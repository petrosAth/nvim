local M = {}

local function opts(icons)
    local kinds = icons.lsp.kinds
    local fillchars = USER.styling.icons.fillchars.global

    return {
        preview = {
            lines_above = 3,
            lines_below = 7,
        },
        scroll_preview = {
            scroll_down = "<C-d>",
            scroll_up = "<C-u>",
        },
        request_timeout = 2000,
        ui = {
            -- Currently, only the round theme exists
            theme = "round",
            -- This option only works in Neovim 0.9
            title = true,
            -- Border type can be single, double, rounded, solid, shadow.
            border = "rounded",
            winblend = USER.styling.variables.transparency,
            expand = fillchars.foldclose,
            collapse = fillchars.foldopen,
            preview = " ",
            code_action = icons.lsp.action[1],
            diagnostic = "🐞",
            incoming = " ",
            outgoing = " ",
            hover = " ",
            kind = {
                Text = kinds.Text .. " ",
                Method = kinds.Method .. " ",
                Function = kinds.Function .. " ",
                Constructor = kinds.Constructor .. " ",
                Field = kinds.Field .. " ",
                Variable = kinds.Variable .. " ",
                Class = kinds.Class .. " ",
                Interface = kinds.Interface .. " ",
                Module = kinds.Module .. " ",
                Property = kinds.Property .. " ",
                Unit = kinds.Unit .. " ",
                Value = kinds.Value .. " ",
                Enum = kinds.Enum .. " ",
                Snippet = kinds.Snippet .. " ",
                File = kinds.File .. " ",
                Folder = kinds.Folder .. " ",
                EnumMember = kinds.EnumMember .. " ",
                Constant = kinds.Constant .. " ",
                Struct = kinds.Struct .. " ",
                Event = kinds.Event .. " ",
                Operator = kinds.Operator .. " ",
                TypeParameter = kinds.TypeParameter .. " ",
                Number = kinds.Number .. " ",
                Boolean = kinds.Boolean .. " ",
                Namespace = kinds.Namespace .. " ",
                Package = kinds.Package .. " ",
                String = kinds.String .. " ",
                Array = kinds.Array .. " ",
                Object = kinds.Object .. " ",
                Key = kinds.Key .. " ",
                Null = kinds.Null .. " ",
                TypeAlias = kinds.TypeParameter .. " ",
                Parameter = kinds.Reference .. " ",
                StaticMethod = kinds.Function .. " ",
                Macro = kinds.Function .. " ",
            },
        },
        diagnostic = {
            show_code_action = true,
            show_source = true,
            jump_num_shortcut = true,
            max_width = 0.7,
            custom_fix = nil,
            custom_msg = nil,
            text_hl_follow = false,
            keys = {
                exec_action = "o",
                quit = "q",
                go_action = "g",
            },
        },
        finder = {
            jump_to = "p",
            edit = { "<C-y>", "<CR>" },
            vsplit = "<M-v>",
            split = "<M-o>",
            tabe = "<M-t>",
            quit = { "q", "<ESC>" },
        },
        definition = {
            edit = "<C-y>",
            vsplit = "<M-v>",
            split = "<M-o>",
            tabe = "<M-t>",
            quit = "q",
            close = "<Esc>",
        },
        code_action = {
            num_shortcut = true,
            keys = {
                quit = { "q", "<ESC>" },
                exec = { "<C-y>", "<CR>"  },
            },
        },
        lightbulb = {
            enable = true,
            enable_in_insert = false,
            sign = true,
            sign_priority = 40,
            virtual_text = true,
        },
        symbol_in_winbar = {
            enable = false,
            separator = string.format(" %s ", icons.arrow.hollow.r),
            hide_keyword = true,
            show_file = false,
            folder_level = 2,
            respect_root = false,
            color_mode = true,
        },
    }
end

local function set_hl_groups()
    local getHl = require("themes.utilities").getHl
    local hl_groups = {
        TypeParameter = getHl("@type"),
        StaticMethod = getHl("@method"),
        Constructor = getHl("@constructor"),
        FolderName = getHl("Directory"),
        EnumMember = getHl("@structure"),
        TypeAlias = getHl("@type"),
        Parameter = getHl("@parameter"),
        Namespace = getHl("@namespace"),
        Interface = getHl("@type"),
        Variable = getHl("@variable"),
        Property = getHl("@property"),
        Operator = getHl("@operator"),
        Function = getHl("@function"),
        Constant = getHl("@constant"),
        Snippet = getHl("@string"),
        Package = getHl("@include"),
        Boolean = getHl("@boolean"),
        Struct = getHl("@structure"),
        String = getHl("@string"),
        Object = getHl("@type"),
        Number = getHl("@number"),
        Module = getHl("@include"),
        Method = getHl("@method"),
        Folder = getHl("Directory"),
        Value = getHl("@keyword"),
        Macro = getHl("@function"),
        Field = getHl("@field"),
        Event = getHl("@keyword"),
        Class = getHl("@function"),
        Array = getHl("@field"),
        Word = getHl("@text"),
        Unit = getHl("@number"),
        Text = getHl("@text"),
        Null = getHl("@comment"),
        File = getHl("Directory"),
        Enum = getHl("@field"),
        Key = getHl("@keyword"),
        Sep = getHl("WinBar"),
    }

    for hl_group, hl in pairs(hl_groups) do
        vim.api.nvim_set_hl(0, "LspSagaWinbar" .. hl_group, { fg = hl.fg, bg = getHl("WinBar").bg })
    end
end

function M.setup(icons)
    local loaded, lspsaga = pcall(require, "lspsaga")
    if not loaded then
        USER.loading_error_msg("lspsaga.nvim")
        return
    end

    lspsaga.setup(opts(icons))
    set_hl_groups()
end

return M
