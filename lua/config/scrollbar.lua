require("scrollbar").setup({
    show = true,
    set_highlights = true,
    folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
    max_lines = false, -- disables if no. of lines in buffer exceeds this
    handle = {
        text = " ",
        color = nil,
        cterm = nil,
        highlight = "ScrollBarHandle",
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
            highlight = "ScrollBarSearch",
        },
        Error = {
            text = { "⠒", "⣒" },
            priority = 1,
            color = nil,
            cterm = nil,
            highlight = "ScrollBarError",
        },
        Warn = {
            text = { "⠒", "⣒" },
            priority = 2,
            color = nil,
            cterm = nil,
            highlight = "ScrollBarWarn",
        },
        Info = {
            text = { "⠒", "⣒" },
            priority = 3,
            color = nil,
            cterm = nil,
            highlight = "ScrollBarInfo",
        },
        Hint = {
            text = { "⠒", "⣒" },
            priority = 4,
            color = nil,
            cterm = nil,
            highlight = "ScrollBarHint",
        },
        Misc = {
            text = { "⠒", "⣒" },
            priority = 5,
            color = nil,
            cterm = nil,
            highlight = "ScrollBarMisc",
        },
    },
    excluded_buftypes = {
        "nofile",
        "prompt",
        "terminal",
        "quickfix",
    },
    excluded_filetypes = {
        "alpha",
        "NvimTree",
        "packer",
        "qf",
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
