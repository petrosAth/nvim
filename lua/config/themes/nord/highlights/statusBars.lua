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
        bright       = { fg = p.nord4, bg = p.nord3      },
        current      = { fg = p.nord6, bg = p.nord3light },
        modified = {
            current  = { fg = p.nord1dark, bg = p.nord13                 },
            inactive = { fg = p.nord1dark, bg = p.nord13, reverse = true },
        },
        readOnly     = { fg = p.nord6,  bg = p.none      },
        windowNumber = { fg = p.nord6,  bg = p.none      }
    },
}

return M
