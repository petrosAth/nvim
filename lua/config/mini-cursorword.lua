vim.cmd([[
    augroup MINICURSORWORD
        autocmd!
        autocmd FileType aerial,alpha,lsp-installer,minimap,NvimTree,Outline,packer,qf,Trouble,undotree
                \ let b:minicursorword_disable=v:true
    augroup END
]])

require("mini.cursorword").setup({
    -- Delay (in ms) between when cursor moved and when highlighting appeared
    delay = 100,
})

vim.cmd("hi! link MiniCursorword Visual")
vim.cmd("hi! MiniCursorwordCurrent gui=nocombine guifg=NONE guibg=NONE")
