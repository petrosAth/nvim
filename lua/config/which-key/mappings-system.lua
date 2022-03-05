local wk = require("which-key")
local map = vim.api.nvim_set_keymap
local n_opts = { noremap = true }

-- "Undo chain" break points
local break_points = { ".", ",", "!", "?", "=", "-", "_" }
for _, v in pairs(break_points) do
	map("i", tostring(v), v .. "<C-g>u", n_opts)
end

-- Normal mode mappings
wk.register({
    ["]b"]    = { "<cmd>bn<cr>",               "Next buffer"                               },
    ["[b"]    = { "<cmd>bp<cr>",               "Previous buffer"                           },
    ["]t"]    = { "<cmd>tabnext<cr>",          "Next tab"                                  },
    ["[t"]    = { "<cmd>tabprevious<cr>",      "Previous tab"                              },
    ["<F1>"]  = { "<cmd>setlocal spell!<CR>",  "Toggle spelling"                           },
    ["<F2>"]  = { [[:%s/\<<C-r><C-w>\>/]],     "Replace word under cursor"                 },
    ["<F11>"] = { "<cmd>set wrap!<cr>",        "Toggle wrap"                               },
    ["<M-j>"] = { "v:count == 0 ? ':resize -5<CR>' : ':<C-u>resize -' . v:count1 . '<CR>'",                   "Contract horizontally", expr = true },
    ["<M-k>"] = { "v:count == 0 ? ':resize +5<CR>' : ':<C-u>resize +' . v:count1 . '<CR>'",                   "Expand horizontally",   expr = true },
    ["<M-h>"] = { "v:count == 0 ? ':vertical resize +5<CR>' : ':<C-u>vertical resize +' . v:count1 . '<CR>'", "Expand vertically",     expr = true },
    ["<M-l>"] = { "v:count == 0 ? ':vertical resize -5<CR>' : ':<C-u>vertical resize -' . v:count1 . '<CR>'", "Contract vertically",   expr = true },
    ["<M-n>"] = { ":m .+1<CR>==",              "Move line up"                              },
    ["<M-p>"] = { ":m .-2<CR>==",              "Move line down"                            },
    j         = { "v:count == 0 ? 'gj' : 'j'", "Move using displayed lines",   expr = true },
    k         = { "v:count == 0 ? 'gk' : 'k'", "Move using displayed lines",   expr = true },
    ["<Leader>"] = {
        n = { "<cmd>set relativenumber!<CR>", "Toggle relative number" },
        d = {
            name = "Delete buffer/tab",
            b = { "<cmd>Bdelete<cr>",  "Delete buffer" },
            t = { "<cmd>tabclose<cr>", "Delete tab"    }
        },
    },
    ["<Space>"] = {
        ["<Space>"] = {
            t = { "<cmd>lua launch_ext_prog('wt.exe -d', string.format('\"%s\"', vim.fn.expand('%:p:h')))<CR>", "Launch Windows terminal at cwd" },
            e = { "<cmd>lua launch_ext_prog('explorer.exe', vim.fn.expand('%:p:h'))<CR>",                       "Launch Windows explorer at cwd" },
            c = { "<cmd>lua launch_ext_prog('code', '%')<CR>",                                                  "Open current file in VSCode"    }
        }
    }
})

-- Insert mode mappings
wk.register({
    ["<F1>"]  = { "<cmd>setlocal spell!<CR>", "Toggle spelling"  }
}, { mode = "i" })

-- Visual and select mode mappings
wk.register({
    ["<F2>"]  = { [[y:%s/\V<C-r>"/]], "Replace word under cursor"    },
    ["<M-n>"] = { ":m '>+1<CR>gv-gv", "Move line up"                 },
    ["<M-p>"] = { ":m '<-2<CR>gv-gv", "Move line up"                 },
    ["<Space>"] = {
        p     = { '"_dP', "Keep yanked text after paste" }
    }
}, { mode = "v" })

-- Operator mode mappings
wk.register({
}, { mode = "o" })

-- Visual mode mappings
wk.register({
}, { mode = "x" })

-- Terminal mode mappings
-- wk.register({
--     ["<esc>"] = { "<c-\\><c-n>", "Escape insert mode" }
-- }, { mode = "t" })

-- Command mode mappings
wk.register({
    ["<C-j>"] = { "<c-n>",       "Move down"  },
    ["<C-k>"] = { "<c-p>",       "Move up"    },
    ["<C-h>"] = { "<Left>",      "Move left"  },
    ["<C-l>"] = { "<Right>",     "Move right" },
}, {
    mode = "c",
    silent = false
})
