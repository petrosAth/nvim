local styling = {}

-- Set colorscheme
vim.cmd("colorscheme " .. THEME)

-- Table containing variables
styling.variables = {
    transparency = 0
}

-- Table containing icons
styling.icons = {
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
    prompt   = { "❯", "", "", "", "❯", "›", "" },
    select   = { "", "", "›" },
    point    = { "", "", "›" },
    location = { "", "", "", "" },
    misc     = { "", "", "", "", "", "" },
    bug      = { "", "", "" },
    folderop = { "", "", "" },
    foldercl = { "", "", "" },
    arrowu   = { "", "", "", "", "", "⯅", "▲", "△", "", "" },
    arrowur  = {                                         "", "" },
    arrowr   = { "", "", "", "", "", "⯈", "▶", "▷", "", "" },
    arrowbr  = {                                         "", "" },
    arrowb   = { "", "", "", "", "", "⯆", "▼", "▽", "", "" },
    arrowbl  = {                                         "", "" },
    arrowl   = { "", "", "", "", "", "⯇", "◀", "◁", "", "" },
    arrowul  = {                                    "", "" },
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
        stl       = { " " }, -- ' ' or '^' -- statusline of the current window
        stlnc     = { " " }, -- ' ' or '=' -- statusline of the non-current windows
        vert      = { "▏" }, -- '│' or '|' -- vertical separators |:vsplit|
        fold      = { " " }, -- '·' or '-' -- filling 'foldtext'
        foldopen  = { "" }, -- '-'        -- mark the beginning of a fold
        foldclose = { "" }, -- '+'        -- show a closed fold
        foldsep   = { "│" }, -- '│' or '|' -- open fold middle marker
        diff      = { "╱" }, -- '-'        -- deleted lines of the 'diff' option
        msgsep    = { " " }, -- ' '        -- message separator 'display'
        eob       = { "-" }, -- '~'        -- empty lines at the end of a buffer
        tab       = { "──" },          -- Two or three characters to be used to show a tab
        lead      = { " " },           -- Character to show for leading spaces
        eol       = { "" },           -- Character to show at the end of each line
        extends   = { "" },           -- Character to show in the last column, when 'wrap' is off and the line continues beyond the right of the screen
        precedes  = { "" },           -- Character to show in the first visible column of the physical line, when there is text preceding the character visible in the first column
    }
}

-- Table containing borders
styling.borders = {
    default  = { tl = "🭽",  t = "▔", tr = "🭾",  r = "▕", br = "🭿",  b = "▁", bl = "🭼",  l = "▏", ml = "▏", mr = "▕" },
    outline  = { tl = "🭽",  t = "▔", tr = "🭾",  r = "▕", br = "🭿",  b = "▁", bl = "🭼",  l = "▏", ml = "▏", mr = "▕" },
    single   = { tl = "┌",  t = "─", tr = "┐",  r = "│", br = "┘",  b = "─", bl = "└",  l = "│", ml = "├", mr = "┤" },
    round    = { tl = "╭",  t = "─", tr = "╮",  r = "│", br = "╯",  b = "─", bl = "╰",  l = "│", ml = "├", mr = "┤" },
    double   = { tl = "╔",  t = "═", tr = "╗",  r = "║", br = "╝",  b = "═", bl = "╚",  l = "║", ml = "╟", mr = "╢",      "╠",      "╣", },
    box      = { tl = "🬕",  t = "🬂", tr = "🬨",  r = "▐", br = "🬷",  b = "🬭", bl = "🬲",  l = "▌", ml = "🬛", mr = "🬫" },
    fatbox   = { tl = "▛",  t = "▀", tr = "▜",  r = "▐", br = "▟",  b = "▄", bl = "▙",  l = "▌" },
    none     = { tl = " ",  t = " ", tr = " ",  r = " ", br = " ",  b = " ", bl = " ",  l = " ", ml = " ", mr = " " },
}

return styling
