local i = USER.styling.icons

vim.fn.sign_define("LightBulbSign", {
    text = i.lsp.action[1],
    texthl = "DiagnosticWarn",
})

require("nvim-lightbulb").setup({
    -- LSP client names to ignore
    -- Example: {"sumneko_lua", "null-ls"}
    ignore = {},
    sign = {
        enabled = true,
        -- Priority of the gutter sign
        priority = 10,
    },
    autocmd = {
        enabled = true,
        -- see :help autocmd-pattern
        pattern = { "*" },
        -- see :help autocmd-events
        events = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
    },
})
