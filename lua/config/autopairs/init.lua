local npairs = require("nvim-autopairs")

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on( "confirm_done", cmp_autopairs.on_confirm_done({  map_char = { tex = "" } }))

npairs.setup{
    disable_filetype = { "TelescopePrompt", },
    map_c_h = true
}

require("config.autopairs.rules").add_rules()
