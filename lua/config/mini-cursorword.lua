vim.cmd([[au FileType aerial   let b:minicursorword_disable=v:true]])
vim.cmd([[au FileType alpha    let b:minicursorword_disable=v:true]])
vim.cmd([[au FileType NvimTree let b:minicursorword_disable=v:true]])

require("mini.cursorword").setup({
    -- Delay (in ms) between when cursor moved and when highlighting appeared
    delay = 100,
})

vim.cmd("hi! link MiniCursorword Visual")
vim.cmd("hi! MiniCursorwordCurrent gui=nocombine guifg=NONE guibg=NONE")
