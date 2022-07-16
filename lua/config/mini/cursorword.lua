local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local disableHighlightCursorWord = augroup("disableHighlightCursorWord", { clear = true })
autocmd("FileType", {
    group = disableHighlightCursorWord,
    pattern = {
        "aerial",
        "alpha",
        "lsp-installer",
        "minimap",
        "NvimTree",
        "Outline",
        "packer",
        "qf",
        "Trouble",
        "undotree"
    },
    desc = "Disable cursor word highlighting in specific filetypes.",
    callback = function()
         vim.b.minicursorword_disable = true
    end,
})

require("mini.cursorword").setup({
    -- Delay (in ms) between when cursor moved and when highlighting appeared
    delay = 500,
})
