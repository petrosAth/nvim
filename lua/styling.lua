local M = {}

M = {
    variables = {
        transparency = 0,
    },
    icons = {
        alphaCursor  = { "░"                          },
        line         = { ""                          },
        column       = { ""                          },
        linesTotal   = { ""                          },
        close        = { "󰅖", "󰅗", "󰅖", ""           },
        delete       = { "", "󰅘"                     },
        pending      = { "", "󰄱"                     },
        done         = { "", "󰄵", "󰄲"                },
        edit         = { ""                          },
        prompt       = { "❯", "", "", "", "❯", "›" },
        search       = { ""                          },
        grep         = { "󰈞"                          },
        select       = { "›", "", "›"                },
        point        = { "", "", "›"                },
        location     = { "", "󰆋", "󰆌", ""           },
        window       = { ""                          },
        lock         = { ""                          },
        bug          = { ""                          },
        task         = { ""                          },
        hack         = { ""                          },
        performance  = { "󰓅"                          },
        note         = { ""                          },
        root_dir     = { ""                          },
        dir          = { ""                          },
        diropen      = { ""                          },
        file         = { ""                          },
        terminal     = { ""                          },
        buffer       = { ""                          },
        buffers      = { ""                          },
        info         = { ""                          },
        fileExplorer = { ""                          },
        list         = { ""                          },
        help         = { ""                          },
        plugin       = { ""                          },
        source       = { ""                          },
        config       = { ""                          },
        codeOutline  = { ""                          },
        minimap      = { ""                          },
        dashboard    = { ""                          },
        telescope    = { ""                          },
        undoTree     = { ""                          },
        diffview     = { ""                          },
        preview      = { ""                          },
        hover        = { ""                          },
        history      = { ""                          },
        lastSession  = { ""                          },
        sessions     = { ""                          },
        windows      = { ""                          },
        update       = { ""                          },
        save         = { ""                          },
        load         = { ""                          },
        key          = { ""                          },
        vim          = { ""                          },
        treesiter    = { ""                          },
        spelling     = { "󰓆"                          },
        palette      = { "󰸌"                          },
        slider       = { "", ""                     },
        arrow = {
            point = {
                u  = { "", "󰁝" },
                ur = { "", "󰁜" },
                r  = { "", "󰁔" },
                br = { "", "󰁃" },
                b  = { "", "󰁅" },
                bl = { "", "󰁂" },
                l  = { "", "󰁍" },
                ul = { "", "󰁛" },
            },
            solid = {
                u  = "",
                r  = "",
                b  = "",
                l  = "",
            },
            hollow = {
                u  = "",
                r  = "",
                b  = "",
                l  = "",
            }
        },
        lazy = {
            lazy  = "󰒲",
            event = "",
            start = "",
            list = {
                tree = "",
                dash = "",
            }
        },
        indentLine = {
            char         = { "╎", "╷" },
            context_char = { "▏", "╷" },
        },
        lsp = {
            icon        = { "", "", ""                          },
            null_ls     = { ""                                    },
            loaded      = { ""                                    },
            diagnostics = { "", "󰝥", "●", "", "▌", ""           },
            error       = { "", "", "", "󰇷", "󰆇", "󰅚", "", "" },
            warn        = { "", "", "", "󰇴", "󰅾", "", "", "" },
            hint        = { "󱩎", "", "", "󰇳", "󰆆", "", "", "" },
            info        = { "", "", "", "󰇵", "󰆅", "", "", "" },
            action      = { "", "", "", "󰝥", "󰆃", "", "󰉁"      },
            ok          = { "", "", "", "", ""                },
            callIn      = { ""                                    },
            callOut     = { ""                                    },
            kinds = {
                Text          = "",
                Method        = "",
                Function      = "",
                Constructor   = "",
                Field         = "",
                Variable      = "",
                Class         = "",
                Interface     = "",
                Module        = "",
                Property      = "",
                Unit          = "",
                Value         = "",
                Enum          = "",
                Keyword       = "",
                Snippet       = "",
                Color         = "",
                File          = "",
                Reference     = "",
                Folder        = "",
                EnumMember    = "",
                Constant      = "",
                Struct        = "",
                Event         = "",
                Operator      = "",
                TypeParameter = "",
                Number        = "",
                Boolean       = "",
                Namespace     = "",
                Package       = "",
                String        = "",
                Array         = "",
                Object        = "",
                Key           = "",
                Null          = "",
            },
        },
        git = {
            repo      = { "󰊢" },
            branch    = { "" },
            commit    = { "" },
            added     = { "" },
            changed   = { "" },
            deleted   = { "" },
            renamed   = { "" },
            ignored   = { "" },
            untracked = { "󱙝" },
            unstaged  = { "" },
            staged    = { "" },
            conflict  = { "" },
            signs = {
                add          = "┃",
                change       = "┃",
                delete       = "",
                topdelete    = "",
                changedelete = "┃",
                untracked    = "╻",
                satellite = {
                    add    = "┃",
                    change = "┃",
                    delete = "",
                }
            },
        },
        OS = {
            windows = { "󰍲" },
            linux   = { "" },
            mac     = { "" },
        },
        loading = {
            circle = {
                "◝", "◞", "◟", "◜",
            },
            braille = {
                "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾",
            },
            sphere = {
                "", "", "", "", "", "", "",
                "", "", "", "", "", "", "",
                "", "", "", "", "", "", "",
                "", "", "", "", "", "", "",
            },
        },
        -- Fillchar and listchar icons
        fillchars = {
            global = {
                stl       = " ", -- statusline of the current window
                stlnc     = " ", -- statusline of the non-current windows
                wbr       = " ", -- window bar
                horiz     = "━", -- "█", "─", "━", "🬭", "🬭", "▁" horizontal separators |:split|
                horizup   = "┻", -- "█", "┴", "┻", "🬲", "🬷", " " upwards facing horizontal separator
                horizdown = "┳", -- "█", "┬", "┳", "🬲", "🬷", "🭼" downwards facing horizontal separator
                vert      = "┃", -- "█", "│", "┃", "▌", "▐", "▏" vertical separators |:vsplit|
                vertleft  = "┫", -- "█", "┤", "┫", "▌", "🬷", "▏" left facing vertical separator
                vertright = "┣", -- "█", "├", "┣", "🬲", "🬷", "🭼" right facing vertical separator
                verthoriz = "╋", -- "█", "┼", "╋", "🬲", "🬷", "🭼" overlapping vertical and horizontal
                fold      = " ", -- filling 'foldtext'
                foldopen  = "", -- mark the beginning of a fold
                foldclose = "󰅂", -- show a closed fold
                foldsep   = "∙", -- open fold middle marker
                diff      = "╱", -- deleted lines of the 'diff' option
                eob       = "─", -- empty lines at the end of a buffer
            },
            custom = {
                eob     = " ",
            },
            extra = {
                foldmid = "⁃",
                foldend = "󰅂", -- • ⁃ 󰍟 󰨃
            },
        },
        listchars = {
            global = {
                eol            = "↴",  -- Character to show at the end of each line.
                tab            = "──", -- Two or three characters to be used to show a tab.
                space          = " ",  -- Character to show for a space.
                multispace     = " ",  -- One or more characters to use cyclically to show for multiple consecutive spaces
                lead           = " ",  -- Character to show for leading spaces.
                leadmultispace = " ",  -- One or more characters to use cyclically to show for multiple consecutive leading spaces.
                trail          = "-",  -- Character to show for trailing spaces.
                extends        = "",  -- Character to show in the last column, when 'wrap' is off and the line continues beyond the right of the screen.
                precedes       = "",  -- Character to show in the first visible column of the physical line, when there is text preceding the character visible in the first column
                conceal        = " ",  -- Character to show in place of concealed text.
                nbsp           = "␣",  -- Character to show for a non-breakable space character.
            },
            custom = {
                eol   = " ",
                tab   = "  ",
                trail = " ",
                nbsp  = " ",
            },
        },
    },
    borders = {
        default   = { tl = "🭽", t = "▔", tr = "🭾", r = "▕", br = "🭿", b = "▁", bl = "🭼", l = "▏", ml = "▏", mr = "▕", },
        outline   = { tl = "🭽", t = "▔", tr = "🭾", r = "▕", br = "🭿", b = "▁", bl = "🭼", l = "▏", ml = "▏", mr = "▕", },
        single    = { tl = "┌", t = "─", tr = "┐", r = "│", br = "┘", b = "─", bl = "└", l = "│", ml = "├", mr = "┤", },
        singlefat = { tl = "┏", t = "━", tr = "┓", r = "┃", br = "┛", b = "━", bl = "┗", l = "┃", ml = "┣", mr = "┫", },
        round     = { tl = "╭", t = "─", tr = "╮", r = "│", br = "╯", b = "─", bl = "╰", l = "│", ml = "├", mr = "┤", },
        double    = { tl = "╔", t = "═", tr = "╗", r = "║", br = "╝", b = "═", bl = "╚", l = "║", ml = "╟", mr = "╢", }, --  "╠", "╣",
        box       = { tl = "🬕", t = "🬂", tr = "🬨", r = "▐", br = "🬷", b = "🬭", bl = "🬲", l = "▌", ml = "🬛", mr = "🬫", },
        boxfat    = { tl = "▛", t = "▀", tr = "▜", r = "▐", br = "▟", b = "▄", bl = "▙", l = "▌"                      },
        none      = { tl = " ", t = " ", tr = " ", r = " ", br = " ", b = " ", bl = " ", l = " ", ml = " ", mr = " "  },
    },
    separators = {
        default       = { "█",  "█",  " ",  " "  },
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
}

return M
