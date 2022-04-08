local cb = require("styling").border.table

require("session-lens").setup({
    theme_conf = {
        borderchars = {
            prompt  = { cb.t, cb.r, cb.b, cb.l, cb.tl, cb.tr, cb.br, cb.bl },
            results = { cb.t, cb.r, cb.b, cb.l, cb.ml, cb.mr, cb.br, cb.bl },
            preview = { cb.t, cb.r, cb.b, cb.l, cb.tl, cb.tr, cb.br, cb.bl },
        },
    },
})
