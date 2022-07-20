local wk = require("which-key")
local map = vim.api.nvim_set_keymap
local n_opts = { noremap = true }

-- "Undo chain" break points
local break_points = { ".", ",", "!", "?", "=", "-", "_" }
for _, v in pairs(break_points) do
    map("i", tostring(v), v .. "<C-g>u", n_opts)
end

local function replaceTermcodes(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Normal mode mappings
wk.register({
    ["]"]    = {
        b = { nil, "Next buffer" }, -- Assigned using Hydra.nvim
        t = { nil, "Next tab"    }  -- Assigned using Hydra.nvim
    },
    ["["]    = {
        b = { nil, "Previous buffer" }, -- Assigned using Hydra.nvim
        t = { nil, "Previous tab"    }  -- Assigned using Hydra.nvim
    },
    ["<F1>"]  = { "<CMD>setlocal spell!<CR>",     "Toggle spelling",                            },
    ["<F2>"]  = { [[:%s/\<<C-r><C-w>\>/]],        "Replace word under cursor",  silent = false, },
    ["<F3>"]  = { "<CMD>set relativenumber!<CR>", "Toggle relative number",                     },
    ["<F11>"] = { "<CMD>set wrap!<CR>",           "Toggle wrap",                                },
    ["<M-J>"] = { ":m .+1<CR>==",                 "Move line up",                               },
    ["<M-K>"] = { ":m .-2<CR>==",                 "Move line down",                             },
    j         = { "v:count == 0 ? 'gj' : 'j'",    "Move using displayed lines", expr   = true,  },
    k         = { "v:count == 0 ? 'gk' : 'k'",    "Move using displayed lines", expr   = true,  },
    ["<Esc>"] = { ":noh<CR><Esc>",                "Clear search highlight",                     },
    ["<Leader>"] = {
        q = { "<CMD>Bdelete<CR><CMD>tabclose<CR>", "Delete buffer and close tab" },
        b = {
            name = "Buffer",
            d = { "<CMD>Bdelete<CR>", "Delete buffer" },
        },
        t = {
            name = "Tab",
            ["}"] = { ":+tabmove<CR>",     "Move tab right" },
            ["{"] = { ":-tabmove<CR>",     "Move tab left"  },
            a     = { "<CMD>tabnew<CR>",   "Create new tab" },
            c     = { "<CMD>tabclose<CR>", "Close tab"      },
        },
    },
})

-- Insert mode mappings
wk.register({
    ["<F1>"] = { "<CMD>setlocal spell!<CR>",     "Toggle spelling"        },
    ["<F3>"] = { "<CMD>set relativenumber!<CR>", "Toggle relative number" },
}, { mode = "i" })

-- Visual and select mode mappings
wk.register({
    ["<F2>"]  = { [[y:%s/\V<C-r>"/]],             "Replace word under cursor", silent = false },
    ["<F3>"]  = { "<CMD>set relativenumber!<CR>", "Toggle relative number"                    },
    ["<M-J>"] = { ":m '>+1<CR>gv-gv",             "Move line up"                              },
    ["<M-K>"] = { ":m '<-2<CR>gv-gv",             "Move line up"                              },
    ["<Space>"] = {
        p = { '"_dP', "Keep yanked text after paste" },
    },
}, { mode = "v" })

-- Operator mode mappings
wk.register({}, { mode = "o" })

-- Visual mode mappings
wk.register({}, { mode = "x" })

-- Terminal mode mappings
wk.register({
    ["<Esc>"] = {
        ["<Esc>"]    = { "<Esc>",                          "Escape Neovim insert mode"   },
        ["<Leader>"] = { replaceTermcodes([[<C-\><C-N>]]), "Escape terminal insert mode" },
    },
    ["<C-w>"] = {
        h = { replaceTermcodes([[<C-\><C-N><C-w>h]]), "Go to the left window"  },
        j = { replaceTermcodes([[<C-\><C-N><C-w>j]]), "Go to the down window"  },
        k = { replaceTermcodes([[<C-\><C-N><C-w>k]]), "Go to the up window"    },
        l = { replaceTermcodes([[<C-\><C-N><C-w>l]]), "Go to the right window" },
    },
}, { mode = "t" })

-- Command mode mappings
wk.register({
    ["<C-y>"] = { "<CR>",      "Enter"                 },
    ["<M-H>"] = { "<Left>",    "Cursor left"           },
    ["<M-L>"] = { "<Right>",   "Cursor right"          },
    ["<M-h>"] = { "<S-Left>",  "Cursor one word left"  },
    ["<M-l>"] = { "<S-Right>", "Cursor one word right" },
}, {
    mode = "c",
    silent = false,
})
