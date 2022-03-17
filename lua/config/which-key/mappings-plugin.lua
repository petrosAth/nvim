local wk = require("which-key")
local tele_custom = "<CMD>lua require('config.telescope.customPickers')."
local tele_builtin = "<CMD>lua require('telescope.builtin')."

-- Normal mode mappings
wk.register({
    ["]c"] = { "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", "Next git hunk",       expr = true }, -- gitsigns
    ["[c"] = { "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", "Previous git hunk",   expr = true }, -- gitsigns
    ["]d"] = { "<CMD>lua vim.diagnostic.goto_next()<CR>",      "Next diagnostic"                  }, -- lspconfig
    ["[d"] = { "<CMD>lua vim.diagnostic.goto_prev()<CR>",      "Previous diagnostic"              }, -- lspconfig
    g = {
        ["cc"] = { "Toggle line comment"             }, -- comment
        ["bc"] = { "Toggle block comment"            }, -- comment
        c      = { "Line comment"                    }, -- comment
        b      = { "Block comment"                   }, -- comment
        o      = { "Comment next line then insert"   }, -- comment
        O      = { "Comment prev line then insert"   }, -- comment
        A      = { "Comment end of line then insert" }  -- comment
    },
    n      = { "<CMD>execute('normal! ' . v:count1 . 'nzzzv')<CR><CMD>lua require('hlslens').start()<CR><CMD>set relativenumber<CR>", "Repeat the latest '/' or '?'",          }, -- hlslens
    N      = { "<CMD>execute('normal! ' . v:count1 . 'Nzzzv')<CR><CMD>lua require('hlslens').start()<CR><CMD>set relativenumber<CR>", "Repeat the latest '/' or '?' backward", }, -- hlslens
    ["*"]  = { "*<CMD>lua require('hlslens').start()<CR>",  "Search word under cursor"            }, -- hlslens
    ["#"]  = { "#<CMD>lua require('hlslens').start()<CR>",  "Search word under cursor backward"   }, -- hlslens
    ["g*"] = { "g*<CMD>lua require('hlslens').start()<CR>", "Search string under cursor"          }, -- hlslens
    ["g#"] = { "g#<CMD>lua require('hlslens').start()<CR>", "Search string under cursor backward" }, -- hlslens
    ["<Leader>"] = {
        s      = {
            name = "Auto Session",
            d = { "<CMD>DeleteSession<CR>",  "Delete cwd session"       }, -- session-lens
            r = { "<CMD>RestoreSession<CR>", "Restore session"          }, -- session-lens
            s = { "<CMD>SaveSession<CR>",    "Save session"             }, -- session-lens
        },
        u      = {
            name = "Utilities",
            u = { "<CMD>PackerSync<CR>",     "Packer sync"              }, -- packer
            s = { "<CMD>PackerStatus<CR>",   "Packer status"            }, -- packer
            c = { "<CMD>PackerCompile<CR>",  "Packer compile"           }, -- packer
            d = { "<CMD>Alpha<CR>",          "Show dashboard"           }, -- alpha
            i = { "<CMD>LspInfo<CR>",        "LSP info",                }, -- lsp-config
            I = { "<CMD>LspInstallInfo<CR>", "LSP installer info"       }  -- lsp-installer
        }
    },
    ["<Space>"] = {
        ["?"] = { "<CMD>WhichKey<CR>",             "Show available hotkeys" }, -- which-key
        ["."] = { tele_builtin .. "resume()<CR>",  "Reopen Telescope"       }, -- telescope
        b     = { tele_custom  .. "buffers()<CR>", "Buffer list"            }, -- telescope
        c     = { "<CMD>HexokinaseToggle<CR>",     "Color codes preview"    }, -- hexokinase
        d     = {
            name = "Diffview",
            o = { "<CMD>DiffviewOpen<CR>",        "Open"                      }, -- diffview
            c = { "<CMD>DiffviewClose<CR>",       "Close"                     }, -- diffview
            e = { "<CMD>DiffviewToggleFiles<CR>", "Toggle file tree"          }, -- diffview
            R = { "<CMD>DiffviewRefresh<CR>",     "Refresh stats and entries" }  -- diffview
        },
        e     = { "<CMD>NvimTreeToggle<CR>",                "Toggle file tree" }, -- nvimtree
        E     = { "<CMD>NvimTreeClose<CR><CMD>lua require'nvim-tree'.open_replacing_current_buffer()<CR>", "Open file tree in buffer" }, -- nvimtree
        f     = { "<CMD>lua require'hop'.hint_char1()<CR>", "Hop to"           }, -- hop
        g     = {
            name = "Git",
            f = { tele_builtin .. "git_files()<CR>",    "Git files" }, -- telescope
            c = { tele_builtin .. "git_commits()<CR>",  "Commits"   }, -- telescope
            b = { tele_builtin .. "git_branches()<CR>", "Branches"  }, -- telescope
            B = {
                name = "Buffer actions",
                s = { "<CMD>Gitsigns stage_buffer<CR>",       "Stage buffer"     }, -- gitsigns
                r = { "<CMD>Gitsigns reset_buffer<CR>",       "Reset buffer"     }, -- gitsigns
                u = { "<CMD>Gitsigns reset_buffer_index<CR>", "Git reset buffer" }  -- gitsigns
            },
            H = {
                name = "Hunk actions",
                s = { "<CMD>Gitsigns stage_hunk<CR>",      "Stage hunk"      }, -- gitsigns
                u = { "<CMD>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" }, -- gitsigns
                r = { "<CMD>Gitsigns reset_hunk<CR>",      "Reset hunk"      }, -- gitsigns
                p = { "<CMD>Gitsigns preview_hunk<CR>",    "Preview hunk"    }, -- gitsigns
            },
            l = { "<CMD>lua require('gitsigns').blame_line{full=true}<CR>",       "Show blame"        }, -- gitsigns
            L = { "<CMD>lua require('gitsigns').toggle_current_line_blame()<CR>", "Toggle line blame" }, -- gitsigns
            s = { tele_builtin .. "git_status()<CR>",                             "Status"            }, -- telescope
            S = { tele_builtin .. "git_stash()<CR>",                              "Stash"             }, -- telescope
        },
        l = {
            name = "LSP",
            f = { "<CMD>lua vim.lsp.buf.formatting()<CR>",     "Code formatting"       }, -- lspconfig
            H = { "<CMD>lua vim.diagnostic.open_float()<CR>",  "Line diagnostics"      }, -- lspconfig
            R = { "<CMD>lua vim.lsp.buf.rename()<CR>",         "Rename symbol"         }, -- lspconfig
            s = { "<CMD>lua vim.lsp.buf.signature_help()<CR>", "Signagture help"       }, -- lspconfig
            a = { "<CMD>lua vim.lsp.buf.code_action()<CR>",    "Code actions"          }, -- lspconfig -- telescope
            r = { tele_custom .. "lsp_references()<CR>",       "References"            }, -- lspconfig -- telescope
            K = { tele_custom .. "lsp_definitions()<CR>",      "Definitions"           }, -- lspconfig -- telescope
            h = { "<CMD>lua vim.lsp.buf.hover()<CR>",          "Hover symbol"          }, -- lspconfig
            d = { "<CMD>Trouble document_diagnostics<CR>",     "Document diagnostics"  }, -- lspconfig -- trouble
            D = { "<CMD>Trouble workspace_diagnostics<CR>",    "Workspace diagnostics" }  -- lspconfig -- trouble
        },
        o = { "<CMD>AerialToggle<CR>", "Toggle Code outline" }, -- aerial
        q = {
            name = "Trouble",
            q = { "<CMD>TroubleToggle<CR>",    "Toggle"   }, -- trouble
            o = { "<CMD>Trouble<CR>",          "Open"     }, -- trouble
            c = { "<CMD>TroubleClose<CR>",     "Close"    }, -- trouble
            R = { "<CMD>TroubleRefresh<CR>",   "Refresh"  }, -- trouble
            l = { "<CMD>Trouble loclist<CR>",  "Loclist"  }, -- trouble
            f = { "<CMD>Trouble quickfix<CR>", "Quickfix" }  -- trouble
        },
        r = {
            name = "Registers",
            r = { tele_custom .. "registers('small')<CR>", "Compact window"  }, -- telescope
            R = { tele_custom .. "registers('large')<CR>", "Extended window" }  -- telescope
        },
        s = {
            name = "Search",
            f = { tele_builtin .. "find_files()<CR>",      "File search"        }, -- telescope
            g = { tele_custom  .. "live_grep()<CR>",       "ripGREP"            }, -- telescope
            H = { tele_builtin .. "highlights()<CR>",      "Highlight groups"   }, -- telescope
            h = { tele_builtin .. "help_tags()<CR>",       "Vim help"           }, -- telescope
            n = { tele_custom  .. "notify()<CR>",          "Notify history"     }, -- telescope -- notify
            o = { tele_builtin .. "vim_options()<CR>",     "Vim options"        }, -- telescope
            p = { tele_custom  .. "project()<CR>",         "Projects"           }, -- telescope
            r = { tele_custom  .. "find_recent()<CR>",     "Find recent"        }, -- telescope
            s = { "<CMD>SearchSession<CR>",                "Search sessions"    }, -- session-lens
            T = { "<CMD>TodoTelescope<CR>",                "Show TODO comments" },  -- todo-comments
            t = {
                name = "Telescope",
                b = { tele_builtin .. "builtin()<CR>",         "Telescope builtin"  }, -- telescope
                c = { tele_builtin .. "command_history()<CR>", "Command history"    }  -- telescope
            }
        },
        u = { "<CMD>NvimTreeClose<CR><CMD>UndotreeToggle<CR>", "Toggle undo tree" } -- undotree
    }
})

-- Visual and select mode mappings
wk.register({
    ["<Space>"] = {
        f = { "<CMD>lua require'hop'.hint_char1()<CR>", "Hop to"          }, -- hop
        g = {
            name = "Git",
            s = { ":Gitsigns stage_hunk<CR>", "Stage hunk" }, -- gitsigns
            r = { ":Gitsigns reset_hunk<CR>", "Reset hunk" }, -- gitsigns
        }
    },
}, { mode = "v" })

-- Operator mode mappings
wk.register({
    i = {
        h  = { ":<C-U>Gitsigns select_hunk<CR>", "Select git hunk" }, -- gitsigns
    },
    ["<Space>"] = {
        f = { "<CMD>lua require'hop'.hint_char1({ inclusive_jump = true })<CR>", "Hop to"          }, -- hop
        t = { "<CMD>lua require'hop'.hint_char1()<CR>",                          "Hop till before" }, -- hop
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
        h = { ":<C-U>Gitsigns select_hunk<CR>", "Select git hunk" } -- gitsigns
    }
}, { mode = "x" })
