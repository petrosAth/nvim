local npairs = require("nvim-autopairs")

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on( "confirm_done", cmp_autopairs.on_confirm_done({  map_char = { tex = "" } }))

npairs.setup{
    disable_filetype = { "TelescopePrompt", },
    fast_wrap = {
        map = "<Leader>e",
        chars = { "{", "[", "(", "<", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 1, -- Offset from pattern match
        end_key = "$",
        keys = "asdghklqwertyuiopzxcvbnmfj'",
        check_comma = true,
        highlight = "Search",
        highlight_grey="Comment"
    },
}

require("plugins-cfg.autopairs-cfg.rules").add_rules()
