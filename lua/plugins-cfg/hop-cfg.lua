require("hop").setup({
    jump_on_sole_occurrence = true
})

-- hop mappings
local map = vim.api.nvim_set_keymap
local ns_opts = { noremap = true, silent = true }

map('n', '<Leader>f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", ns_opts)
map('n', '<Leader>F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", ns_opts)
map('o', '<Leader>f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, inclusive_jump = true, })<cr>", ns_opts)
map('o', '<Leader>F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, inclusive_jump = true })<cr>", ns_opts)
map('v', '<Leader>f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", ns_opts)
map('v', '<Leader>F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", ns_opts)

map('n', '<Leader>t', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", ns_opts)
map('n', '<Leader>T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", ns_opts)
map('o', '<Leader>t', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", ns_opts)
map('o', '<Leader>T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", ns_opts)
map('v', '<Leader>t', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", ns_opts)
map('v', '<Leader>T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", ns_opts)
