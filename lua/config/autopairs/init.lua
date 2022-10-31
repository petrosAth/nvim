local npairs = require("nvim-autopairs")

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

npairs.setup({
    disable_filetype = { "html", "TelescopePrompt" },
    map_cr = true,
    map_c_h = true,
    map_c_w = true,
})

require("config.autopairs.rules").add_rules()
