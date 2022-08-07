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
}

return M
