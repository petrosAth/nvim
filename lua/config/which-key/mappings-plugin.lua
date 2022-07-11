local wk = require("which-key")
local telescope_custom = "<CMD>lua require('config.telescope.customPickers')."

-- Normal mode mappings
wk.register({
    ["]c"] = { "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", "Next git hunk",       expr = true  }, -- gitsigns
    ["[c"] = { "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", "Previous git hunk",   expr = true  }, -- gitsigns
    ["]d"] = { "<CMD>lua vim.diagnostic.goto_next()<CR>",      "Next diagnostic",     expr = false }, -- lspconfig
    ["[d"] = { "<CMD>lua vim.diagnostic.goto_prev()<CR>",      "Previous diagnostic", expr = false }, -- lspconfig
    g = {
        a = {
            name = "Align",
            T = { [[:'<,'>Tabularize /^[^=]*\zs=<CR>:'<,'>GTabularize /\[\[\(.*\)\]\],\?\|"\([^"]*\)",\?\|--\s.*\zs\|.*{\slink\s=.*\zs\|\S\+/l0l1<CR>:'<,'>Tabularize /},\?$\|},\s--\s<CR>]], "Lua tables", }, -- Tabularize
            t = { ":Tabularize ", "Tabularize", silent = false } -- Tabularize
        },
        c = {
            name = "Line comment",
            A = { "Add comment at the end of line" }, -- comment.nvim
            c = { "Comment out"                    }, -- comment.nvim
            o = { "Add comment on the line below"  }, -- comment.nvim
            O = { "Add comment on the line above"  }, -- comment.nvim
        },
        b = {
            name = "Block comment",
            c = { "Comment out" }, -- comment.nvim
        },
    },
    n = {
        "<CMD>execute('normal! ' . v:count1 . 'nzzzv')<CR><CMD>lua require('hlslens').start()<CR><CMD>if &nu | set rnu | endif<CR>", "Repeat the latest '/' or '?'", }, -- hlslens
    N = {
        "<CMD>execute('normal! ' . v:count1 . 'Nzzzv')<CR><CMD>lua require('hlslens').start()<CR><CMD>if &nu | set rnu | endif<CR>", "Repeat the latest '/' or '?' backward", }, -- hlslens
    ["*"]  = { "*<CMD>lua require('hlslens').start()<CR>",  "Search word under cursor"            }, -- hlslens
    ["#"]  = { "#<CMD>lua require('hlslens').start()<CR>",  "Search word under cursor backward"   }, -- hlslens
    ["g*"] = { "g*<CMD>lua require('hlslens').start()<CR>", "Search string under cursor"          }, -- hlslens
    ["g#"] = { "g#<CMD>lua require('hlslens').start()<CR>", "Search string under cursor backward" }, -- hlslens
    ["<Leader>"] = {
        s = {
            name = "Auto Session",
            d = { "<CMD>DeleteSession<CR>",  "Delete cwd session" }, -- session-lens
            r = { "<CMD>RestoreSession<CR>", "Restore session"    }, -- session-lens
            s = { "<CMD>SaveSession<CR>",    "Save session"       }, -- session-lens
        },
        u = {
            name = "Utilities",
            u = { "<CMD>PackerSync<CR>",     "Packer sync"        }, -- packer
            s = { "<CMD>PackerStatus<CR>",   "Packer status"      }, -- packer
            c = { "<CMD>PackerCompile<CR>",  "Packer compile"     }, -- packer
            d = { "<CMD>Alpha<CR>",          "Show dashboard"     }, -- alpha
            i = { "<CMD>LspInfo<CR>",        "LSP info"           }, -- lsp-config
            I = { "<CMD>LspInstallInfo<CR>", "LSP installer info" }, -- lsp-installer
        },
    },
    ["<Space>"] = {
        ["?"] = { "<CMD>WhichKey<CR>",                 "Show available hotkeys" }, -- which-key
        ["."] = { "<CMD>Telescope resume<CR>",         "Reopen Telescope"       }, -- telescope
        b     = { telescope_custom .. "buffers()<CR>", "Buffer list"            }, -- telescope
        c     = { "<CMD>HexokinaseToggle<CR>",         "Color codes preview"    }, -- hexokinase
        d = {
            name = "Diffview",
            q = { "<CMD>DiffviewClose<CR>",         "Quit"                              }, -- diffview
            e = { "<CMD>DiffviewToggleFiles<CR>",   "Toggle file tree"                  }, -- diffview
            h = { "<CMD>DiffviewFileHistory %<CR>", "Show history log for current file" }, -- diffview
            H = { "<CMD>DiffviewFileHistory<CR>",   "Show history log"                  }, -- diffview
            o = { "<CMD>DiffviewOpen<CR>",          "Open"                              }, -- diffview
            R = { "<CMD>DiffviewRefresh<CR>",       "Refresh stats and entries"         }, -- diffview
        },
        D = {
            name = "Diff mode",
            p = { ":diffpatch ",             "Patch the buffer with the requested file on a new buffer", silent = false, },
            q = { "<CMD>diffoff<CR>",        "Revert and quit",                                                          },
            R = { "<CMD>diffupdate<CR>",     "Updated the differences",                                                  },
            t = { "<CMD>diffthis<CR>",       "Make the current window part of the diff windows",                         },
            v = { ":vertical diffsplit ",    "Open the requested file in a split",                       silent = false, },
            w = { "<CMD>windo diffthis<CR>", "Compare the visible files",                                                },
        },
        e = { "<CMD>NvimTreeToggle<CR>",                                                               "Toggle file tree"          }, -- nvimtree
        E = { "<CMD>NvimTreeClose<CR><CMD>lua require'nvim-tree'.open_replacing_current_buffer()<CR>", "Open file tree in buffer", }, -- nvimtree
        f = { "<CMD>lua require'hop'.hint_char1()<CR>",                                                "Hop to"                    }, -- hop
        f = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>",  "Hop to" }, -- hop
        F = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>", "Hop to" }, -- hop
        g = {
            name = "Git & gitsigns",
            b = {
                name = "Blame",
                l = { "<CMD>Gitsigns toggle_current_line_blame<CR>",            "Toggle line blame" }, -- gitsigns
                b = { "<CMD>lua require('gitsigns').blame_line{full=true}<CR>", "Show blame window" }, -- gitsigns
            },
            d = { "<CMD>Gitsigns toggle_deleted<CR>", "Toggle deleted lines highlighting" }, -- gitsigns
            g = {
                name = "Git actions",
                b = {
                    name = "Buffer actions",
                    a = { "<CMD>Gitsigns stage_buffer<CR>",       "Stage buffer"   }, -- gitsigns
                    r = { "<CMD>Gitsigns reset_buffer<CR>",       "Reset buffer"   }, -- gitsigns
                    u = { "<CMD>Gitsigns reset_buffer_index<CR>", "Unstage buffer" }, -- gitsigns
                },
                h = {
                    name = "Hunk actions",
                    a = { "<CMD>Gitsigns stage_hunk<CR>",      "Stage hunk"      }, -- gitsigns
                    p = { "<CMD>Gitsigns preview_hunk<CR>",    "Preview hunk"    }, -- gitsigns
                    r = { "<CMD>Gitsigns reset_hunk<CR>",      "Reset hunk"      }, -- gitsigns
                    u = { "<CMD>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" }, -- gitsigns
                },
            },
            l = { "<CMD>Gitsigns toggle_linehl<CR>",    "Toggle line diff highlighting"   }, -- gitsigns
            n = { "<CMD>Gitsigns toggle_numhl<CR>",     "Toggle number diff highlighting" }, -- gitsigns
            w = { "<CMD>Gitsigns toggle_word_diff<CR>", "Toggle word diff highlighting"   }, -- gitsigns
        },
        l = {
            name = "LSP",
            f = { "<CMD>lua vim.lsp.buf.format { async = true }<CR>", "Code formatting"                       }, -- lspconfig
            H = { "<CMD>lua vim.diagnostic.open_float()<CR>",         "Line diagnostics"                      }, -- lspconfig
            -- R = { "<CMD>lua vim.lsp.buf.rename()<CR>",                "Rename symbol"                         }, -- lspconfig
            R = { ":IncRename ",                                      "Rename symbol",        silent = false, }, -- lspconfig -- inc-rename
            s = { "<CMD>lua vim.lsp.buf.signature_help()<CR>",        "Signagture help"                       }, -- lspconfig
            a = { "<CMD>lua vim.lsp.buf.code_action()<CR>",           "Code actions"                          }, -- lspconfig -- telescope
            r = { telescope_custom .. "lsp_references()<CR>",         "References"                            }, -- lspconfig -- telescope
            K = { telescope_custom .. "lsp_definitions()<CR>",        "Definitions"                           }, -- lspconfig -- telescope
            h = { "<CMD>lua vim.lsp.buf.hover()<CR>",                 "Hover symbol"                          }, -- lspconfig
            d = { "<CMD>Trouble document_diagnostics<CR>",            "Document diagnostics"                  }, -- lspconfig -- trouble
            D = { "<CMD>Trouble workspace_diagnostics<CR>",           "Workspace diagnostics"                 }, -- lspconfig -- trouble
        },
        o = { "<CMD>AerialToggle<CR>", "Toggle Code outline" }, -- aerial
        q = {
            name = "Trouble",
            q = { "<CMD>TroubleToggle<CR>",    "Toggle"   }, -- trouble
            o = { "<CMD>Trouble<CR>",          "Open"     }, -- trouble
            c = { "<CMD>TroubleClose<CR>",     "Close"    }, -- trouble
            R = { "<CMD>TroubleRefresh<CR>",   "Refresh"  }, -- trouble
            l = { "<CMD>Trouble loclist<CR>",  "Loclist"  }, -- trouble
            f = { "<CMD>Trouble quickfix<CR>", "Quickfix" }, -- trouble
        },
        r = {
            name = "Registers",
            r = { telescope_custom .. "registers('small')<CR>", "Compact window"  }, -- telescope
            R = { telescope_custom .. "registers('large')<CR>", "Extended window" }, -- telescope
        },
        s = {
            name = "Search",
            f = { "<CMD>Telescope find_files<CR>", "File search" }, -- telescope
            g = { "<CMD>Telescope live_grep<CR>",  "ripGREP"     }, -- telescope
            G = {
                name = "Git",
                f = { "<CMD>Telescope git_files<CR>",    "Git files" }, -- telescope
                c = { "<CMD>Telescope git_commits<CR>",  "Commits"   }, -- telescope
                b = { "<CMD>Telescope git_branches<CR>", "Branches"  }, -- telescope
                s = { "<CMD>Telescope git_status<CR>",   "Status"    }, -- telescope
                S = { "<CMD>Telescope git_stash<CR>",    "Stash"     }, -- telescope
            },
            H = { "<CMD>Telescope highlights<CR>",         "Highlight groups"   }, -- telescope
            h = { "<CMD>Telescope help_tags<CR>",          "Vim help"           }, -- telescope
            n = { telescope_custom .. "notify()<CR>",      "Notify history"     }, -- telescope -- notify
            o = { "<CMD>Telescope vim_options<CR>",        "Vim options"        }, -- telescope
            p = { telescope_custom .. "project()<CR>",     "Projects"           }, -- telescope
            r = { telescope_custom .. "find_recent()<CR>", "Find recent"        }, -- telescope
            s = { "<CMD>SearchSession<CR>",                "Search sessions"    }, -- session-lens
            T = { "<CMD>TodoTelescope<CR>",                "Show TODO comments" }, -- todo-comments
            t = {
                name = "Telescope",
                b = { "<CMD>Telescope builtin<CR>",         "Telescope builtin" }, -- telescope
                c = { "<CMD>Telescope command_history<CR>", "Command history"   }, -- telescope
            },
        },
        t = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, hint_offset = -1 })<CR>", "Hop before" }, -- hop
        T = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, hint_offset = 1 })<CR>", "Hop before" }, -- hop
        u = { "<CMD>NvimTreeClose<CR><CMD>UndotreeToggle<CR>", "Toggle undo tree" }, -- undotree
        ["<Space>"] = {
            name = "Launch",
            e = { "<CMD>lua launch_ext_prog('dolphin ', vim.fn.expand('%:p:h'))<CR>", "Open cwd in system file browser"  },
            l = { "<CMD>lua open_url(vim.fn.expand('<cWORD>'))<CR>",                  "Open URL under cursor in browser", silent = true }
        }
    },
})

-- Visual and select mode mappings
wk.register({
}, { mode = "v" })

-- Operator pending mode mappings
wk.register({
    i = {
        h = { ":<C-U>Gitsigns select_hunk<CR>", "Select git hunk" }, -- gitsigns
    },
    ["<Space>"] = {
        f = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>",                   "Hop to"     }, -- hop
        F = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>",                  "Hop to"     }, -- hop
        t = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, hint_offset = -2 })<CR>", "Hop before" }, -- hop
        T = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, hint_offset = 1 })<CR>", "Hop before" }, -- hop
    },
}, { mode = "o" })

-- Visual mode mappings
wk.register({
    g = {
        a = {
            name = "Align",
            T = { [[:Tabularize /^[^=]*\zs=<CR>:'<,'>GTabularize /\[\[\(.*\)\]\],\?\|"\([^"]*\)",\?\|--\s.*\zs\|.*{\slink\s=.*\zs\|\S\+/l0l1<CR>:'<,'>Tabularize /},\?$\|}\?$\|},\s--\s\S\+\|}\s--\s\S\+<CR>]], "Lua tables", }, -- Tabularize
            t = { ":Tabularize ", "Tabularize", silent = false } -- Tabularize
        },
        c = { "Line comment"  }, -- comment.nvim
        b = { "Block comment" }, -- comment.nvim
    },
    ["<Space>"] = {
        f = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>",                   "Hop to"     }, -- hop
        F = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>",                  "Hop to"     }, -- hop
        t = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, hint_offset = -1 })<CR>", "Hop before" }, -- hop
        T = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, hint_offset = 1 })<CR>", "Hop before" }, -- hop
        g = {
            name = "Git",
            s = { ":Gitsigns stage_hunk<CR>",       "Stage hunk"      }, -- gitsigns
            r = { ":Gitsigns reset_hunk<CR>",       "Reset hunk"      }, -- gitsigns
            v = { ":<C-U>Gitsigns select_hunk<CR>", "Select git hunk" }, -- gitsigns
        },
    },
}, { mode = "x" })
