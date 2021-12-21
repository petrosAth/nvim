local wk = require("which-key")
local tele_custom = "<cmd>lua require('plugins-cfg.telescope-cfg.customPickers')."
local tele_builtin = "<cmd>lua require('telescope.builtin')."
local hop = "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection."

-- Normal mode mappings
wk.register({
    ["]c"] = { "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'", "Next git hunk",       expr = true }, -- gitsigns
    ["[c"] = { "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>'", "Previous git hunk",   expr = true }, -- gitsigns
    ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>",      "Next diagnostic"                  }, -- lspconfig
    ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>",      "Previous diagnostic"              }, -- lspconfig
    g = {
        ["cc"] = { "Toggle line comment"             }, -- comment
        ["bc"] = { "Toggle block comment"            }, -- comment
        c      = { "Line comment"                    }, -- comment
        b      = { "Block comment"                   }, -- comment
        o      = { "Comment next line then insert"   }, -- comment
        O      = { "Comment prev line then insert"   }, -- comment
        A      = { "Comment end of line then insert" }  -- comment
    },
    n      = { "<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require('hlslens').start()<cr><cmd>set relativenumber!<cr>", "Repeat the latest '/' or '?'"          }, -- hlslens
    N      = { "<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require('hlslens').start()<cr><cmd>set relativenumber!<cr>", "Repeat the latest '/' or '?' backward" }, -- hlslens
    ["*"]  = { "*<cmd>lua require('hlslens').start()<cr>",  "Search word under cursor"            }, -- hlslens
    ["#"]  = { "#<cmd>lua require('hlslens').start()<cr>",  "Search word under cursor backward"   }, -- hlslens
    ["g*"] = { "g*<cmd>lua require('hlslens').start()<cr>", "Search string under cursor"          }, -- hlslens
    ["g#"] = { "g#<cmd>lua require('hlslens').start()<cr>", "Search string under cursor backward" }, -- hlslens
    -- ["<leader>"] = {},
    ["<space>"] = {
        ["?"] = { "<cmd>WhichKey<cr>",             "Show available hotkeys" }, -- which-key
        ["."] = { tele_builtin .. "resume()<cr>",  "Reopen Telescope"       }, -- telescope
        b     = { tele_custom  .. "buffers()<cr>", "Buffer list"            }, -- telescope
        c     = { "<cmd>HexokinaseToggle<cr>",     "Color codes preview"    }, -- hexokinase
        e     = { "<cmd>NvimTreeToggle<cr>",       "Toggle file tree"       },
        f     = { hop .. "AFTER_CURSOR })<cr>",    "Hop right to"           }, -- hop
        F     = { hop .. "BEFORE_CURSOR })<cr>",   "Hop left to"            }, -- hop
        t     = { hop .. "AFTER_CURSOR })<cr>",    "Hop right till before"  }, -- hop
        T     = { hop .. "BEFORE_CURSOR })<cr>",   "Hop left till before"   }, -- hop
        S     = { "<cmd>SymbolsOutline<cr>",       "Toggle Symbols Outline" },
        g = {
            name = "Git",
            f = { tele_builtin .. "git_files()<cr>",    "Git files" }, -- telescope
            c = { tele_builtin .. "git_commits()<cr>",  "Commits"   }, -- telescope
            b = { tele_builtin .. "git_branches()<cr>", "Branches"  }, -- telescope
            s = { tele_builtin .. "git_status()<cr>",   "Status"    }, -- telescope
            a = { tele_builtin .. "git_stash()<cr>",    "Stash"     }, -- telescope
            -- b = { "<cmd>lua require('gitsigns').blame_line{full=true}<cr>", "Blame" }, -- gitsigns
            -- B = {
            --     S = { "<cmd>Gitsigns stage_buffer<cr>",       "Stage buffer"     }, -- gitsigns
            --     R = { "<cmd>Gitsigns reset_buffer<cr>",       "Reset buffer"     }, -- gitsigns
            --     U = { "<cmd>Gitsigns reset_buffer_index<cr>", "Git reset buffer" }  -- gitsigns
            -- },
            h = {
                s = { "<cmd>Gitsigns stage_hunk<cr>",      "Stage hunk"      }, -- gitsigns
                u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo stage hunk" }, -- gitsigns
                r = { "<cmd>Gitsigns reset_hunk<cr>",      "Reset hunk"      }, -- gitsigns
                p = { "<cmd>Gitsigns preview_hunk<cr>",    "Preview hunk"    }, -- gitsigns
            }
        },
        l = {
            name = "LSP",
            H = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", "Line diagnostics"     }, -- lspconfig
            R = { "<cmd>lua vim.lsp.buf.rename()<cr>",                       "Rename symbol"        }, -- lspconfig
            s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>",               "Signagture help"      }, -- lspconfig
            a = { tele_custom .. "lsp_code_actions()<cr>",                   "Code actions"         }, -- lspconfig -- telescope
            r = { tele_custom .. "lsp_references()<cr>",                     "References"           }, -- lspconfig -- telescope
            D = { tele_custom .. "lsp_definitions()<cr>",                    "Definitions"          }, -- lspconfig -- telescope
            h = { "<cmd>lua vim.lsp.buf.hover()<cr>",                        "Hover symbol"         }, -- lspconfig
            d = { "<cmd>Trouble document_diagnostics<cr>",                   "Document diagnostics" }  -- lspconfig -- trouble
        },
        m = {
            name = "Minimap",
            m = { "<cmd>MinimapToggle<cr>",          "Toggle"           },
            q = { "<cmd>MinimapClose<cr>",           "Close"            },
            r = { "<cmd>MinimapRefresh<cr>",         "Refresh"          },
            h = { "<cmd>MinimapUpdateHighlight<cr>", "Update highlight" }
        },
        q = {
            name = "Trouble",
            q = { "<cmd>TroubleToggle<cr>",    "Toggle"   }, -- trouble
            o = { "<cmd>Trouble<cr>",          "Open"     }, -- trouble
            c = { "<cmd>TroubleClose<cr>",     "Close"    }, -- trouble
            R = { "<cmd>TroubleRefresh<cr>",   "Refresh"  }, -- trouble
            l = { "<cmd>Trouble loclist<cr>",  "Loclist"  }, -- trouble
            f = { "<cmd>Trouble quickfix<cr>", "Quickfix" }  -- trouble
        },
        r = {
            name = "Registers",
            r = { tele_custom .. "registers('small')<cr>", "Compact window"  }, -- telescope
            R = { tele_custom .. "registers('large')<cr>", "Extended window" }  -- telescope
        },
        s = {
            name = "Search",
            f = { tele_builtin .. "find_files()<cr>",      "File search"        }, -- telescope
            e = { tele_custom  .. "file_browser()<cr>",    "File browser"       }, -- telescope
            r = { tele_custom  .. "find_recent()<cr>",     "Find recent"        }, -- telescope
            g = { tele_custom  .. "live_grep()<cr>",       "ripGREP"            }, -- telescope
            p = { tele_custom  .. "project()<cr>",         "Projects"           }, -- telescope
            o = { tele_builtin .. "vim_options()<cr>",     "Vim options"        }, -- telescope
            H = { tele_builtin .. "highlights()<cr>",      "Highlight groups"   }, -- telescope
            h = { tele_builtin .. "help_tags()<cr>",       "Vim help"           }, -- telescope
            t = { tele_builtin .. "builtin()<cr>",         "Telescope builtin"  }, -- telescope
            c = { tele_builtin .. "command_history()<cr>", "Command history"    }, -- telescope
            T = { "<cmd>TodoTelescope<cr>",                "Show TODO comments" }  -- todo-comments
        },
        u = {
            name = "Utilities",
            u = { "<cmd>PackerSync<cr>",     "Packer sync"    }, -- packer
            s = { "<cmd>PackerStatus<cr>",   "Packer status"  }, -- packer
            c = { "<cmd>PackerCompile<cr>",  "Packer compile" }, -- packer
            a = { "<cmd>Alpha<cr>",          "Open dashboard" }, -- alpha
            i = { "<cmd>LspInstallInfo<cr>", "LSP installer"  }, -- lsp-installer
        },
    }
})

-- Visual and select mode mappings
wk.register({
    ["<space>"] = {
        f = { hop .. "AFTER_CURSOR })<cr>",  "Hop right to"          }, -- hop
        F = { hop .. "BEFORE_CURSOR })<cr>", "Hop left to"           }, -- hop
        t = { hop .. "AFTER_CURSOR })<cr>",  "Hop right till before" }, -- hop
        T = { hop .. "BEFORE_CURSOR })<cr>", "Hop left till before"  }, -- hop
        g = {
            name = "Git",
            s = { ":Gitsigns stage_hunk<cr>", "Stage hunk" }, -- gitsigns
            r = { ":Gitsigns reset_hunk<cr>", "Reset hunk" }, -- gitsigns
        }
    },
}, { mode = "v" })

-- Operator mode mappings
wk.register({
    i = {
        h  = { ":<C-U>Gitsigns select_hunk<cr>", "Select git hunk" }, -- gitsigns
    },
    ["<space>"] = {
        f = { hop .. "AFTER_CURSOR, inclusive_jump = true })<cr>",  "Hop right to"          }, -- hop
        F = { hop .. "BEFORE_CURSOR, inclusive_jump = true })<cr>", "Hop left to"           }, -- hop
        t = { hop .. "AFTER_CURSOR })<cr>",                         "Hop right till before" }, -- hop
        T = { hop .. "BEFORE_CURSOR })<cr>",                        "Hop left till before"  }  -- hop
    }
}, { mode = "o" })

-- Visual mode mappings
wk.register({
    -- comment
    g = {
        c = { "Line comment"  }, -- comment
        b = { "Block comment" }  -- comment
    },
    i = {
        h = { ":<C-U>Gitsigns select_hunk<cr>", "Select git hunk" } -- gitsigns
    }
}, { mode = "x" })
