local t = require("styling").variables.transparency
local i = require("styling").icons
local b = require("styling").borders.default

local lsp_signature = {}

lsp_signature.config = ({
    hint_enable = false, -- virtual hint enable
    hint_prefix = i.hint[1] .. " ",
    handler_opts = {
        border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l },
    },

    transpancy = t, -- disabled by default, allow floating win transparent value 1~100
    toggle_key = "<M-s>", -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

    select_signature_key = "<M-S>", -- cycle to next signature, e.g. '<M-n>' function overloading
})

return lsp_signature
