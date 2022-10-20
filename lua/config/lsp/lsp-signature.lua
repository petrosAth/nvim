local lsp_signature = require("lsp_signature")
local t = PA.styling.variables.transparency
local i = PA.styling.icons
local b = PA.styling.borders.default

lsp_signature.setup({
    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    hint_enable = false, -- virtual hint enable
    hint_prefix = i.lsp.hint[1] .. " ",
    handler_opts = {
        border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l },
    },

    transpancy = t, -- disabled by default, allow floating win transparent value 1~100
    toggle_key = "<M-s>", -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

    select_signature_key = "<M-S>", -- cycle to next signature, e.g. '<M-n>' function overloading
})
