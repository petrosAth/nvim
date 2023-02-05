local M = {}

local function opts(icons)
    local kinds = icons.lsp.kinds
    local fillchars = icons.fillchars.global

    return {
        ui = {
            -- Currently, only the round theme exists
            theme = "round",
            -- This option only works in Neovim 0.9
            title = false,
            -- Border type can be single, double, rounded, solid, shadow.
            border = "solid",
            winblend = USER.styling.variables.transparency,
            expand = fillchars.foldclose,
            collapse = fillchars.foldopen,
            preview = icons.preview[1],
            code_action = icons.lsp.action[1],
            diagnostic = icons.bug[1] .. " ",
            incoming = icons.lsp.callIn[1],
            outgoing = icons.lsp.callOut[1],
            hover = icons.hover[1],
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
            jump_num_shortcut = false,
            max_width = 1,
            custom_fix = icons.lsp.action[1] .. " Code Actions",
            custom_msg = icons.lsp.diagnostics[1] .. " Diagnostics",
            text_hl_follow = false,
            border_follow = false,
            keys = {
                exec_action = "o",
                quit = "q",
                go_action = "g",
            },
        },
        code_action = {
            num_shortcut = true,
            keys = {
                quit = { "q", "<ESC>" },
                exec = { "<C-y>", "<CR>" },
            },
        },
        lightbulb = {
            enable = true,
            enable_in_insert = false,
            sign = true,
            sign_priority = 40,
            virtual_text = true,
        },
        preview = {
            lines_above = 0,
            lines_below = 10,
        },
        scroll_preview = {
            scroll_down = "<C-d>",
            scroll_up = "<C-u>",
        },
        request_timeout = 2000,
        finder = {
            max_height = 1,
            keys = {
                jump_to = "p",
                edit = { "<C-y>", "<CR>" },
                vsplit = "<M-v>",
                split = "<M-o>",
                tabe = "<M-t>",
                quit = { "q", "<ESC>" },
                close_in_preview = "<ESC>",
            },
        },
        definition = {
            edit = "<C-y>",
            vsplit = "<M-v>",
            split = "<M-o>",
            tabe = "<M-t>",
            quit = "q",
            close = "<Esc>",
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
        outline = {
            win_position = "right",
            win_with = "",
            win_width = 40,
            show_detail = true,
            auto_preview = true,
            auto_refresh = true,
            auto_close = true,
            custom_sort = nil,
            keys = {
                jump = "<CR>",
                expand_collapse = "za",
                quit = "q",
            },
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
        Enum = getHl("@structure"),
        Key = getHl("@keyword"),
        Sep = getHl("WinBar"),
    }

    for hl_group, hl in pairs(hl_groups) do
        vim.api.nvim_set_hl(0, "LspSagaWinbar" .. hl_group, { fg = hl.fg, bg = getHl("WinBar").bg })
        vim.api.nvim_set_hl(0, "LSOutline" .. hl_group, { fg = hl.fg })
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
