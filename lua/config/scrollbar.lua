require("scrollbar").setup({
    show = true,
    set_highlights = true,
    handle = {
        text = " ",
        color = nil,
        cterm = nil,
        highlight = "CursorColumn",
        hide_if_all_visible = true, -- Hides handle if all lines are visible
    },
    marks = {
        Search = {
            -- text = { "⠒", "⣒" },
            -- text = { "~", "𑇞" },
            text = { "─", "═" },
            priority = 0,
            color = nil,
            cterm = nil,
            highlight = "Search",
        },
        Error = {
            text = { "⠒", "⣒" },
            priority = 1,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
            text = { "⠒", "⣒" },
            priority = 2,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
            text = { "⠒", "⣒" },
            priority = 3,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
            text = { "⠒", "⣒" },
            priority = 4,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
            text = { "⠒", "⣒" },
            priority = 5,
            color = nil,
            cterm = nil,
            highlight = "Normal",
        },
    },
    excluded_buftypes = {
        "aerial",
        "alpha",
        "minimap",
        "NvimTree",
        "Outline",
        "packer",
        "qf",
        "terminal",
        "Trouble",
        "undotree"
    },
    excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
    },
    autocmd = {
        render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
        },
    },
    handlers = {
        diagnostic = true,
        search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
    },
})
