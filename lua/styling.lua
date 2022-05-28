local M = {}

-- Table containing variables
M.variables = {
    transparency = 0
}

-- Table containing icons
M.icon = {
    error    = { "", "", "", "", "", "" },
    warn     = { "", "", "", "", "", "" },
    hint     = { "", "", "", "", "", "" },
    info     = { "", "", "", "", "", "" },
    action   = { "", "", "", "", "", "" },
    close    = { "", "" },
    delete   = { "", "" },
    pending  = { "", "", },
    done     = { "", "", "" },
    def      = { "", "", "", "硫"},
    edit     = { "", "", "" },
    prompt   = { "❯", "", "", "", "❯", "›" },
    select   = { "", "", "›" },
    point    = { "", "", "›" },
    location = { "", "", "", "" },
    misc     = { "", "", "", "", "", "" },
    bug      = { "", "", "" },
    folderop = { "", "", "" },
    foldercl = { "", "", "" },
    arrowu   = { "", "", "", "", "", "", "" },
    arrowur  = {                          "", "" },
    arrowr   = { "", "", "", "", "", "", "" },
    arrowbr  = {                          "", "" },
    arrowb   = { "", "", "", "", "", "", "" },
    arrowbl  = {                          "", "" },
    arrowl   = { "", "", "", "", "", "", "" },
    arrowul  = {                          "", "" },
    loading  = {
        circle = {
            -- "◝", "◞", "◟", "◜"
            "", "", "", "", "", ""
        },
        braille = {
            "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾"
        },
        sphere = {
            "", "", "", "", "", "", "",
            "", "", "", "", "", "", "",
            "", "", "", "", "", "", "",
            "", "", "", "", "", "", "",
        }
    },
    -- Fillchar and listchar icons
    nvim_ui  = {
        stl       = { " " },           -- ' ' or '^' -- statusline of the current window
        stlnc     = { " " },           -- ' ' or '=' -- statusline of the non-current windows
        vert      = { "▏", "▏", "▌", "│", "┃", "▕", "▐", "░", "▒", "▓", "█" }, -- '│' or '|' -- vertical separators |:vsplit|
        fold      = { " " },           -- '·' or '-' -- filling 'foldtext'
        foldopen  = { "", "", "┯" }, -- '-'        -- mark the beginning of a fold
        foldclose = { "", "", "" }, -- '+'        -- show a closed fold
        foldsep   = { "│", "", "│" }, -- '│' or '|' -- open fold middle marker
        diff      = { "╱", "-" },           -- '-'        -- deleted lines of the 'diff' option
        msgsep    = { " " },           -- ' '        -- message separator 'display'
        eob       = { "-" },           -- '~'        -- empty lines at the end of a buffer
        tab       = { "──" },          -- Two or three characters to be used to show a tab
        lead      = { " " },           -- Character to show for leading spaces
        eol       = { "﬋" }            -- Character to show at the end of each line
    }
}

-- Table containing borders
M.border = {
    table    = { tl = "┌",  t = "─", tr = "┐",  r = "│", br = "┘",  b = "─", bl = "└",  l = "│", ml = "├", mr = "┤" },
    outline  = { tl = "🭽",  t = "▔", tr = "🭾",  r = "▕", br = "🭿",  b = "▁", bl = "🭼",  l = "▏", ml = "▏", mr = "▕" },
    single   = { tl = "┌",  t = "─", tr = "┐",  r = "│", br = "┘",  b = "─", bl = "└",  l = "│", ml = "├", mr = "┤" },
    round    = { tl = "╭",  t = "─", tr = "╮",  r = "│", br = "╯",  b = "─", bl = "╰",  l = "│", ml = "├", mr = "┤" },
    double   = { tl = "╔",  t = "═", tr = "╗",  r = "║", br = "╝",  b = "═", bl = "╚",  l = "║", ml = "╟", mr = "╢",      "╠",      "╣", },
    box      = { tl = "▛",  t = "▀", tr = "▜",  r = "▐", br = "▟",  b = "▄", bl = "▙",  l = "▌" }
}

return M
