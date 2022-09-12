local styling = {}

vim.cmd.colorscheme(THEME)

styling.variables = {
    transparency = 0
				}

styling.icons = {
    line         = { ""                                              },
    column       = { ""                                              },
    linesTotal   = { ""                                              },
    close        = { "", "", "", ""                               },
    delete       = { "",                                             },
    pending      = { "",                                             },
    done         = { "", "", ""                                    },
    def          = { "", "", "", "硫"                              },
    modified     = { "", "", ""                                    },
    edit         = { "",                                             },
    prompt       = { "❯", "", "", "", "❯", "›"                     },
    search       = { ""                                              },
    grep         = { ""                                              },
    select       = { "", "", "›"                                    },
    point        = { "", "", "›"                                    },
    location     = { "", "", "", ""                               },
    window       = { ""                                              },
    lock         = { "", "", ""                                    },
    misc         = { "", "", "", "", "", ""                     },
    bug          = { "", "", ""                                    },
    dir          = { ""                                              },
    diropen      = { ""                                              },
    file         = { ""                                              },
    terminal     = { ""                                              },
    buffer       = { ""                                              },
    buffers      = { ""                                              },
    fileExplorer = { ""                                              },
    list         = { ""                                              },
    codeOutline  = { ""                                              },
    minimap      = { ""                                              },
    dashboard    = { ""                                              },
    telescope    = { ""                                              },
    undoTree     = { ""                                              },
    diffview     = { ""                                              },
    history      = { ""                                              },
    lastSession  = { ""                                              },
    sessions     = { ""                                              },
    update       = { ""                                              },
    lspServers   = { ""                                              },
    indentLine   = { "│", "❘", '|', '¦', "│", "❘", "╎", '┆', '┊', '⸽' },
    folderop     = { "", "", ""                                    },
    foldercl     = { "", "", ""                                    },
    arrowu       = { "", "", "", "", "", "⯅", "▲", "△", "", "" },
    arrowur      = { "", ""                                         },
    arrowr       = { "", "", "", "", "", "⯈", "▶", "▷", "", "" },
    arrowbr      = { "", ""                                         },
    arrowb       = { "", "", "", "", "", "⯆", "▼", "▽", "", "" },
    arrowbl      = { "", ""                                         },
    arrowl       = { "", "", "", "", "", "⯇", "◀", "◁", "", "" },
    arrowul      = { "", ""                                         },
    treesiter    = { ""                                              },
    lsp        = {
        lspIcon = { "", "", ""                          },
        error   = { "", "", "", "", "", "", "", "" },
        warn    = { "", "", "", "", "", "", "", "" },
        hint    = { "", "", "", "", "", "", "", "" },
        info    = { "", "", "", "", "", "", "", "" },
        action  = { "", "", "", "", "", "", ""      },
        ok      = { "", "", "", "", ""                }
    },
    git        = {
        repo      = { ""                },
        branch    = { "", ""           },
        commit    = { ""                },
        added     = { ""                },
        changed   = { ""                },
        deleted   = { ""                },
        renamed   = { ""                },
        ignored   = { ""                },
        untracked = { "", "", ""      },
        unstaged  = { "", "", "", "" },
        staged    = { "", "", ""      },
        conflict  = { "", ""           },
    },
    OS = {
        windows = { "" },
        linux   = { "" },
        mac     = { "" },
    },
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
        wbr       = { " " }, -- ' '     window bar
        horiz     = { "█", "█", "─", "━", "🬭", "▁" }, -- '─' or '-'  horizontal separators |:split|
        horizup   = { "█", "█", "┴", "┻", "🬲", " " }, -- '┴' or '-'  upwards facing horizontal separator
        horizdown = { "█", "█", "┬", "┳", "🬲", "🭼" }, -- '┬' or '-'  downwards facing horizontal separator
        vert      = { "█", "█", "│", "┃", "▌", "▏" }, -- '│' or '|'  vertical separators |:vsplit|
        vertleft  = { "█", "█", "┤", "┫", "▌", "▏" }, -- '┤' or '|'  left facing vertical separator
        vertright = { "█", "█", "├", "┣", "🬲", "🭼" }, -- '├' or '|'  right facing vertical separator
        verthoriz = { "█", "█", "┼", "╋", "🬲", "🭼" }, -- '┼' or '+'  overlapping vertical and horizontal
        stl       = { " " }, -- ' ' or '^'  statusline of the current window
        stlnc     = { " " }, -- ' ' or '='  statusline of the non-current windows
        fold      = { " " }, -- '·' or '-'  filling 'foldtext'
        foldopen  = { "┌" }, -- '-'         mark the beginning of a fold
        foldclose = { "─" }, -- '+'         show a closed fold
        foldsep   = { "│" }, -- '│' or '|'  open fold middle marker
        diff      = { "╱" }, -- '-'         deleted lines of the 'diff' option
        msgsep    = { " " }, -- ' '         message separator 'display'
        eob       = { "─" }, -- '~'         empty lines at the end of a buffer
        tab       = { "──" },          -- Two or three characters to be used to show a tab
        lead      = { " " },           -- Character to show for leading spaces
        trail     = { " " },           -- Character to show for trailing spaces.
        eol       = { "" },           -- Character to show at the end of each line
        extends   = { "" },           -- Character to show in the last column, when 'wrap' is off and the line continues beyond the right of the screen
        precedes  = { "" },           -- Character to show in the first visible column of the physical line, when there is text preceding the character visible in the first column
    }
}

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

styling.separators = {
    default       = { "█",  "█",  "▏",  "▕"  },
    block         = { "█",  "█",  "▏",  "▕"  },
    half_block    = { "▐",  "▌",  "▏",  "▕"  },
    arrow         = { "",  "",  "",  ""  },
    round         = { "",  "",  "",  ""  },
    flame         = { " ", " ", " ", " " },
    triangle_top  = { "",  "",  "",  ""  },
    triangle_bot  = { "",  "",  "",  ""  },
    waveform      = { " ", " "             },
    squares_big   = { " ", " "             },
    squares_small = { " ", " "             },
    trapezoid     = { "",  ""              },
}

return styling
