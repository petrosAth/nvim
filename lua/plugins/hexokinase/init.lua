return {
    {
        -- vim-hexokinase
        -- The fastest (Neo)Vim plugin for asynchronously displaying the colours in the file (#rrggbb, #rgb, rgb(a)?
        -- functions, hsl(a)? functions, web colours, custom patterns)
        "RRethy/vim-hexokinase",
        build = "make hexokinase",
        cmd = {
            "HexokinaseToggle",
            "HexokinaseTurnOn",
        },
        ft = {
            "css",
            "html",
            "javascript",
            "json",
            "scss",
        },
        init = function()
            local g = vim.g

            g.Hexokinase_highlighters = {
                -- "virtual"
                -- "sign_column"
                -- "background"
                "backgroundfull",
                -- "foreground"
                -- "foregroundfull"
            }
            g.Hexokinase_optInPatterns = {
                "full_hex",
                "triple_hex",
                "rgb",
                "rgba",
                "hsl",
                "hsla",
                "colour_names",
            }
            g.Hexokinase_refreshEvents = {
                "BufEnter",
                "BufRead",
                "InsertLeave",
                "TextChanged",
            }
            g.Hexokinase_ftEnabled = {
                "css",
                "html",
                "javascript",
                "json",
                "scss",
            }
        end,
    },
}