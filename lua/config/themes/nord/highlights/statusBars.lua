local p = require("config.themes.nord.palette")

local M = {
    lualine = {
        inactive = {
            a = { fg = p.nord1, bg = p.nord8 },
            b = { fg = p.nord4, bg = p.nord3 },
            c = { fg = p.nord4, bg = p.nord1 },
        },
        visual = {
            a = { fg = p.nord1, bg = p.nord13 },
            b = { fg = p.nord4, bg = p.nord3  },
            c = { fg = p.nord4, bg = p.nord1  },
        },
        replace = {
            a = { fg = p.nord1, bg = p.nord11 },
            b = { fg = p.nord4, bg = p.nord3  },
            c = { fg = p.nord4, bg = p.nord1  },
        },
        normal = {
            a = { fg = p.nord1, bg = p.nord8 },
            b = { fg = p.nord4, bg = p.nord3 },
            c = { fg = p.nord4, bg = p.nord1 },
        },
        insert = {
            a = { fg = p.nord1, bg = p.nord6 },
            b = { fg = p.nord4, bg = p.nord3 },
            c = { fg = p.nord4, bg = p.nord1 },
        },
        command = {
            a = { fg = p.nord1, bg = p.nord7 },
            b = { fg = p.nord4, bg = p.nord3 },
            c = { fg = p.nord4, bg = p.nord1 },
        },
    },
    heirline = {
        modes = {
            inactive = { fg = p.nord1, bg = p.nord8  },
            visual   = { fg = p.nord1, bg = p.nord13 },
            replace  = { fg = p.nord1, bg = p.nord11 },
            normal   = { fg = p.nord1, bg = p.nord8  },
            insert   = { fg = p.nord1, bg = p.nord6  },
            command  = { fg = p.nord1, bg = p.nord7  },
            terminal = { fg = p.nord1, bg = p.nord12 },
            hydra    = { fg = p.nord1, bg = p.nord15 },
        },
        statusBar = {
            bright = { fg = p.nord4,  bg = p.nord3 },
        },
        winBar = {
            bright = { fg = p.nord4, bg = p.nord2 },
            current = { fg = p.nord6, bg = p.nord3light },
        },
        modified = {
            current  = { fg = p.nord1dark, bg = p.nord13                 },
            inactive = { fg = p.nord1dark, bg = p.nord13, reverse = true },
        },
        readOnly     = { fg = p.nord6,  bg = p.none      },
        windowNumber = { fg = p.nord6,  bg = p.none      }
    },
    tabby = {
        TabLine                       = { fg = p.nord4,     bg = p.nord1      },
        TabLineSel                    = { fg = p.nord4,     bg = p.nord3light },
        TabLineFill                   = { fg = p.nord4dark, bg = p.nord2      },
        TabLineHeader                 = { fg = p.nord1,     bg = p.nord8      },
        TabLineTabSeparator           = { fg = p.nord4,     bg = p.nord3      },
        TabLineTabSeparatorSel        = { fg = p.nord1,     bg = p.nord8      },
        TabLineTabIndicator           = { fg = p.nord4,     bg = p.nord3      },
        TabLineTabIndicatorSel        = { fg = p.nord1,     bg = p.nord8      },
        TabLineIndicatorModified      = { fg = p.nord1,     bg = p.nord2      },
        TabLineIndicatorModifiedSel   = { fg = p.nord1,     bg = p.nord3light },
        TabLineIndicatorIsModified    = { fg = p.nord13,    bg = p.nord2      },
        TabLineIndicatorIsModifiedSel = { fg = p.nord13,    bg = p.nord3light },
    }
}

return M
