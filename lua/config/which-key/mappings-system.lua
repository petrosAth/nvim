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
    ["]b"]    = { "<CMD>bn<CR>",                  "Next buffer"                             },
    ["[b"]    = { "<CMD>bp<CR>",                  "Previous buffer"                         },
    ["]t"]    = { "<CMD>tabnext<CR>",             "Next tab"                                },
    ["[t"]    = { "<CMD>tabprevious<CR>",         "Previous tab"                            },
    ["<F1>"]  = { "<CMD>setlocal spell!<CR>",     "Toggle spelling"                         },
    ["<F2>"]  = { [[:%s/\<<C-r><C-w>\>/]],        "Replace word under cursor"               },
    ["<F3>"]  = { "<CMD>set relativenumber!<CR>", "Toggle relative number"                  },
    ["<F11>"] = { "<CMD>set wrap!<CR>",           "Toggle wrap"                             },
    ["<M-j>"] = { "v:count == 0 ? ':resize -5<CR>' : ':<C-u>resize -' . v:count1 . '<CR>'",                   "Contract horizontally", expr = true },
    ["<M-k>"] = { "v:count == 0 ? ':resize +5<CR>' : ':<C-u>resize +' . v:count1 . '<CR>'",                   "Expand horizontally",   expr = true },
    ["<M-h>"] = { "v:count == 0 ? ':vertical resize +5<CR>' : ':<C-u>vertical resize +' . v:count1 . '<CR>'", "Expand vertically",     expr = true },
    ["<M-l>"] = { "v:count == 0 ? ':vertical resize -5<CR>' : ':<C-u>vertical resize -' . v:count1 . '<CR>'", "Contract vertically",   expr = true },
    ["<M-n>"] = { ":m .+1<CR>==",                 "Move line up"                            },
    ["<M-p>"] = { ":m .-2<CR>==",                 "Move line down"                          },
    j         = { "v:count == 0 ? 'gj' : 'j'",    "Move using displayed lines", expr = true },
    k         = { "v:count == 0 ? 'gk' : 'k'",    "Move using displayed lines", expr = true },
    ["<Esc>"] = { ":noh<CR><Esc>",                "Clear search highlight",                 },
    ["<Leader>"] = {
        d = {
            name = "Delete buffer/tab",
            b = { "<CMD>Bdelete<CR>",  "Delete buffer" },
            t = { "<CMD>tabclose<CR>", "Delete tab"    }
        },
    },
    ["<Space>"] = {
        ["<Space>"] = {
            t = { "<CMD>lua launch_ext_prog('wt.exe -d', string.format('\"%s\"', vim.fn.expand('%:p:h')))<CR>", "Launch Windows terminal at cwd" },
            e = { "<CMD>lua launch_ext_prog('explorer.exe', vim.fn.expand('%:p:h'))<CR>",                       "Launch Windows explorer at cwd" },
            c = { "<CMD>lua launch_ext_prog('code', '%')<CR>",                                                  "Open current file in VSCode"    }
        }
    }
})

-- Insert mode mappings
wk.register({
    ["<F1>"]  = { "<CMD>setlocal spell!<CR>", "Toggle spelling"            },
    ["<F3>"]  = { "<CMD>set relativenumber!<CR>", "Toggle relative number" },
}, { mode = "i" })

-- Visual and select mode mappings
wk.register({
    ["<F2>"]  = { [[y:%s/\V<C-r>"/]], "Replace word under cursor"          },
    ["<F3>"]  = { "<CMD>set relativenumber!<CR>", "Toggle relative number" },
    ["<M-n>"] = { ":m '>+1<CR>gv-gv", "Move line up"                       },
    ["<M-p>"] = { ":m '<-2<CR>gv-gv", "Move line up"                       },
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
    ["<M-h>"] = { "<Left>",    "Cursor left"           },
    ["<M-l>"] = { "<Right>",   "Cursor right"          },
    ["<M-H>"] = { "<S-Left>",  "Cursor one word left"  },
    ["<M-L>"] = { "<S-Right>", "Cursor one word right" },
}, {
    mode = "c",
    silent = false
})
