-- "Undo chain" break points
local undo_break_points = { ".", ",", "!", "?", "=", "-", "_" }
local telescope_custom = "<CMD>lua require('config.telescope.customPickers')."

local default_opts = {
    noremap = true,
    silent = true,
    expr = false,
    nowait = false,
    script = false,
    unique = false,
    desc = nil,
}

local function set_undo_break_points(break_points)
    for _, point in pairs(break_points) do
        PA.mappings.i[point] = { point .. "<C-g>u" }
    end
end

local function replaceTermcodes(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function set_keymap(mappings, mode, prefix)
    -- Source: echasnovski/nvim
    -- https://github.com/echasnovski/nvim/blob/47eb53792a1ff1e1c482c19fbae8ac035e352e2d/lua/ec/mappings-leader.lua#L198-L220
    if type(mappings) ~= "table" then
        return
    end

    prefix = prefix or ""

    if type(mappings[1]) == "string" then
        local tree_opts = {
            noremap = mappings.noremap,
            silent  = mappings.silent,
            expr    = mappings.expr,
            nowait  = mappings.nowait,
            script  = mappings.script,
            unique  = mappings.unique,
        }
        local opts = vim.tbl_deep_extend("force", default_opts, tree_opts)
        vim.api.nvim_set_keymap(mode, prefix, mappings[1], opts)
        return
    end

    for key, t in pairs(mappings) do
        if key ~= "name" then
            set_keymap(t, mode, prefix .. key)
        end
    end
end

local function set_mappings(mappings)
    for mode, keymaps in pairs(mappings) do
        set_keymap(keymaps, mode)
    end
end

PA.mappings = {
    -- Normal mode mappings
    n = {
        ["*"] = { "*<CMD>lua require('hlslens').start()<CR>", "Search word under cursor"          }, -- hlslens
        ["#"] = { "#<CMD>lua require('hlslens').start()<CR>", "Search word under cursor backward" }, -- hlslens
        ["]"] = {
            b = { nil, "Next buffer"         }, -- Assigned using Hydra.nvim
            c = { nil, "Next git hunk"       }, -- Assigned using Hydra.nvim
            d = { nil, "Next lsp diagnostic" }, -- Assigned using Hydra.nvim
            t = { nil, "Next tab"            }, -- Assigned using Hydra.nvim
        },
        ["["] = {
            b = { nil, "Previous buffer"         }, -- Assigned using Hydra.nvim
            c = { nil, "Previous git hunk"       }, -- Assigned using Hydra.nvim
            d = { nil, "Previous lsp diagnostic" }, -- Assigned using Hydra.nvim
            t = { nil, "Previous tab"            }, -- Assigned using Hydra.nvim
        },
        ["<F1>"]  = { "<CMD>setlocal spell!<CR>",     "Toggle spelling"                           },
        ["<F2>"]  = { [[:%s/\<<C-r><C-w>\>/]],        "Replace word under cursor", silent = false },
        ["<F3>"]  = { "<CMD>set relativenumber!<CR>", "Toggle relative number"                    },
        ["<F11>"] = { "<CMD>set wrap!<CR>",           "Toggle wrap"                               },
        g         = {
            ["*"] = { "*<CMD>lua require('hlslens').start()<CR>", "Search word under cursor"          }, -- hlslens
            ["#"] = { "#<CMD>lua require('hlslens').start()<CR>", "Search word under cursor backward" }, -- hlslens
            a = {
                name = "Align",
                T = {
                    [[:'<,'>Tabularize /^[^=]*\zs=<CR>:'<,'>GTabularize /\[\[\(.*\)\]\],\?\|"\([^"]*\)",\?\|--\s.*\zs\|.*{\slink\s=.*\zs\|\S\+/l0l1<CR>:'<,'>Tabularize /},\?$\|},\s--\s<CR>]],
                    "Lua tables",
                }, -- Tabularize
                t = { ":Tabularize ", "Tabularize", silent = false }, -- Tabularize
            },
            c = {
                name = "Line comment",
                A = { nil, "Add comment at the end of line" }, -- comment.nvim
                c = { nil, "Comment out"                    }, -- comment.nvim
                o = { nil, "Add comment on the line below"  }, -- comment.nvim
                O = { nil, "Add comment on the line above"  }, -- comment.nvim
            },
            b = {
                name = "Block comment",
                c = { nil, "Comment out" }, -- comment.nvim
            },
        },
        z = {
            h = { nil, "Scroll the screen to the left"  }, -- Assigned using Hydra.nvim
            l = { nil, "Scroll the screen to the right" }, -- Assigned using Hydra.nvim
        },
        ["<M-J>"]    = { ":m .+1<CR>==",              "Move line up"                            },
        ["<M-K>"]    = { ":m .-2<CR>==",              "Move line down"                          },
        j            = { "v:count == 0 ? 'gj' : 'j'", "Move using displayed lines", expr = true },
        k            = { "v:count == 0 ? 'gk' : 'k'", "Move using displayed lines", expr = true },
        n            = { "<CMD>execute('normal! ' . v:count1 . 'nzzzv')<CR><CMD>lua require('hlslens').start()<CR><CMD>if &nu | set rnu | endif<CR>", "Repeat the latest '/' or '?'"           }, -- hlslens
        N            = { "<CMD>execute('normal! ' . v:count1 . 'Nzzzv')<CR><CMD>lua require('hlslens').start()<CR><CMD>if &nu | set rnu | endif<CR>", "Repeat the latest '/' or '?' backwards" }, -- hlslens
        ["<Esc>"]    = { ":noh<CR><Esc>",             "Clear search highlight"                  },
        ["<Leader>"] = {
            b = {
                name = "Buffer",
                d = { "<CMD>Bdelete<CR>", "Delete buffer" },
            },
            q = { "<CMD>Bdelete<CR><CMD>quit<CR>",     "Delete buffer and close window" },
            Q = { "<CMD>Bdelete<CR><CMD>tabclose<CR>", "Delete buffer and close tab"    },
            p = {
                name = "Project",
                ["."] = { "<CMD>PossessionLoad<CR>", "Load last closed" }, -- possession.nvim
                c = {
                    name = "Create local config files",
                    c = { "<CMD>lua PA.create_local_config()<CR>",  "Create config file" },
                    s = { "<CMD>lua PA.save_local_session()<CR>",   "Create session"     }, -- possession.nvim
                    p = { "<CMD>lua PA.create_local_palette()<CR>", "Create palette"     }, -- hexokinase
                },
                D = { "<CMD>PossessionDelete<CR>",            "Delete currently loaded session"                }, -- possession.nvim
                e = {
                    name = "Edit local config files",
                    c = { "<CMD>lua PA.edit_local_config()<CR>", "Edit config file" },
                    g = { "<CMD>lua PA.edit_gitignore()<CR>",    "Edit .gitignore"  }
                },
                f = { "<CMD>LspToggleAutoFormat<CR>",         "Toggle auto formatting"                },
                L = { "<CMD>lua PA.load_local_session()<CR>", "Load last closed"                      },     -- possession.nvim
                S = { ":PossessionSave ",                     "Save session",          silent = false }, -- possession.nvim
            },
            t = {
                name = "Tab",
                ["}"] = { ":+tabmove<CR>",     "Move tab right"                },
                ["{"] = { ":-tabmove<CR>",     "Move tab left"                 },
                a     = { "<CMD>tabnew<CR>",   "Create new tab"                },
                c     = { "<CMD>tabclose<CR>", "Close tab"                     },
                R     = { ":TabRename ",       "Rename tab",    silent = false }, -- tabby.nvim
            },
            u = {
                name = "Utilities",
                c = { "<CMD>PackerCompile<CR>", "Packer compile" }, -- packer
                s = {
                    name = "Status",
                    l = { "<CMD>LspInfo<CR>",      "LSP info"      }, -- lsp-config
                    m = { "<CMD>Mason<CR>",        "Mason status"  }, -- mason.nvim
                    p = { "<CMD>PackerStatus<CR>", "Packer status" }, -- packer
                },
                u = {
                    name = "Update",
                    l = { "<CMD>Mason<CR><CMD>MasonToolsUpdate<CR>", "Update LSP packages"     }, -- mason-tool-installer.nvim
                    P = { "<CMD>PackerSync<CR>",                     "Update plugins"          }, -- packer
                    p = { "<CMD>PackerSync --preview<CR>",           "Preview plugins updates" }, -- packer
                },
            },
        },
        ["<Space>"] = {
            ["?"] = { "<CMD>WhichKey<CR>",          "Show available hotkeys" }, -- which-key
            ["."] = { "<CMD>Telescope resume<CR>",  "Reopen Telescope"       }, -- telescope
            b     = { "<CMD>Telescope buffers<CR>", "Buffer list"            }, -- telescope
            c     = { "<CMD>HexokinaseToggle<CR>",  "Color codes preview"    }, -- hexokinase
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
            e = {
                name = "File buffer and git explorer",
                b = { "<CMD>Neotree buffers left focus reveal toggle<CR>",     "Toggle a list of currently open buffers",                           }, -- neo-tree.nvim
                B = { "<CMD>Neotree buffers current<CR>",                      "Toggle a list of currently open buffers within the current window", }, -- neo-tree.nvim
                e = { "<CMD>Neotree filesystem left focus reveal toggle<CR>",  "Toggle file explorer",                                              }, -- neo-tree.nvim
                f = { "<CMD>NeoTreeFocus<CR>",                                 "Open or focus on file explorer",                                    }, -- neo-tree.nvim
                E = { "<CMD>Neotree filesystem current<CR>",                   "Open file explorer within the current window",                      }, -- neo-tree.nvim
                g = { "<CMD>Neotree git_status left focus reveal toggle <CR>", "Toggle git status in a floating window",                            }, -- neo-tree.nvim
            },
            f = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>",  "Hop to", }, -- hop
            F = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>", "Hop to", }, -- hop
            g = {
                name = "Git & gitsigns",
                B = {
                    name = "Git blame",
                    l = { "<CMD>Gitsigns toggle_current_line_blame<CR>",            "Toggle line blame" }, -- gitsigns
                    w = { "<CMD>lua require('gitsigns').blame_line{full=true}<CR>", "Show blame window" }, -- gitsigns
                },
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
                v = {
                    name = "Diff highlighting",
                    l = { "<CMD>Gitsigns toggle_linehl<CR>",    "Toggle line diff highlighting"     }, -- gitsigns
                    n = { "<CMD>Gitsigns toggle_numhl<CR>",     "Toggle number diff highlighting"   }, -- gitsigns
                    w = { "<CMD>Gitsigns toggle_word_diff<CR>", "Toggle word diff highlighting"     }, -- gitsigns
                    d = { "<CMD>Gitsigns toggle_deleted<CR>",   "Toggle deleted lines highlighting" }, -- gitsigns
                },
            },
            l = {
                name = "LSP",
                f = { "<CMD>lua vim.lsp.buf.format { async = true }<CR>", "Code formatting"                      }, -- lspconfig
                H = { "<CMD>lua vim.diagnostic.open_float()<CR>",         "Line diagnostics"                     }, -- lspconfig
                R = { ":IncRename ",                                      "Rename symbol",        silent = false }, -- lspconfig -- inc-rename
                -- R = { "<CMD>lua vim.lsp.buf.rename()<CR>",                "Rename symbol",        silent = false }, -- lspconfig
                s = { "<CMD>lua vim.lsp.buf.signature_help()<CR>",        "Signagture help"                      }, -- lspconfig
                a = { "<CMD>lua vim.lsp.buf.code_action()<CR>",           "Code actions"                         }, -- lspconfig -- telescope
                r = { telescope_custom .. "lsp_references()<CR>",         "References"                           }, -- lspconfig -- telescope
                K = { telescope_custom .. "lsp_definitions()<CR>",        "Definitions"                          }, -- lspconfig -- telescope
                h = { "<CMD>lua vim.lsp.buf.hover()<CR>",                 "Hover symbol"                         }, -- lspconfig
                d = { "<CMD>Trouble document_diagnostics<CR>",            "Document diagnostics"                 }, -- lspconfig -- trouble
                D = { "<CMD>Trouble workspace_diagnostics<CR>",           "Workspace diagnostics"                }, -- lspconfig -- trouble
            },
            m = {
                name = "Minimap",
                m = { "<CMD>lua require('codewindow').open_minimap()<CR>",  "Toggle minimap"          }, -- codewindow.nvim
                o = { "<CMD>lua require('codewindow').open_minimap()<CR>",  "Open minimap"          }, -- codewindow.nvim
                c = { "<CMD>lua require('codewindow').close_minimap()<CR>", "Close minimap"         }, -- codewindow.nvim
                f = { "<CMD>lua require('codewindow').toggle_focus()<CR>",  "Focus/unfocus minimap" }, -- codewindow.nvim
            },
            o = { "<CMD>SymbolsOutline<CR>", "Toggle Code outline" }, -- symbols-outline.nvim
            q = {
                name = "Trouble",
                q = { "<CMD>TroubleToggle<CR>",    "Toggle"   }, -- trouble
                o = { "<CMD>Trouble<CR>",          "Open"     }, -- trouble
                c = { "<CMD>TroubleClose<CR>",     "Close"    }, -- trouble
                R = { "<CMD>TroubleRefresh<CR>",   "Refresh"  }, -- trouble
                l = { "<CMD>Trouble loclist<CR>",  "Loclist"  }, -- trouble
                f = { "<CMD>Trouble quickfix<CR>", "Quickfix" }, -- trouble
            },
            r = { "<CMD>Telescope registers<CR>", "Registers" },
            s = {
                name = "Search",
                b = { "<CMD>Telescope file_browser<CR>", "File Browser" }, -- telescope
                f = { "<CMD>Telescope find_files<CR>",   "File search"  }, -- telescope
                g = { "<CMD>Telescope live_grep<CR>",    "ripGREP"      }, -- telescope
                G = {
                    name = "Git",
                    f = { "<CMD>Telescope git_files<CR>",    "Git files" }, -- telescope
                    c = { "<CMD>Telescope git_commits<CR>",  "Commits"   }, -- telescope
                    b = { "<CMD>Telescope git_branches<CR>", "Branches"  }, -- telescope
                    s = { "<CMD>Telescope git_status<CR>",   "Status"    }, -- telescope
                    S = { "<CMD>Telescope git_stash<CR>",    "Stash"     }, -- telescope
                },
                H = { "<CMD>Telescope highlights<CR>",        "Highlight groups"        }, -- telescope
                h = { "<CMD>Telescope help_tags<CR>",         "Vim help"                }, -- telescope
                n = { telescope_custom .. "notify()<CR>",     "Notify history"          }, -- telescope -- notify
                o = { "<CMD>Telescope vim_options<CR>",       "Vim options"             }, -- telescope
                R = { telescope_custom .. "frecency()<CR>",   "Frecency"                }, -- telescope
                r = { telescope_custom .. "oldFiles()<CR>",   "Recent files"            }, -- telescope
                s = { telescope_custom .. "possession()<CR>", "Search sessions"         }, -- telescope -- possession.nvim
                S = { telescope_custom .. "luasnip()<CR>",    "List available snippets" }, -- telescope-luasnip.nvim
                T = { "<CMD>TodoTelescope<CR>",               "Show TODO comments"      }, -- todo-comments
                t = {
                    name = "Telescope",
                    b = { "<CMD>Telescope builtin<CR>",         "Telescope builtin" }, -- telescope
                    c = { "<CMD>Telescope command_history<CR>", "Command history"   }, -- telescope
                },
            },
            t = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, hint_offset = -1 })<CR>", "Hop before",      }, -- hop
            T = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, hint_offset = 1 })<CR>", "Hop before",      }, -- hop
            u = { "<CMD>NeoTreeClose<CR><CMD>UndotreeToggle<CR>",                                                                         "Toggle undo tree" }, -- undotree
            ["<Space>"] = {
                name = "Launch",
                e = { "<CMD>LaunchDir dolphin<CR>",           "Open cwd in system file browser",                 },
                l = { "<CMD>LaunchURL firefox --new-tab<CR>", "Open URL under cursor in browser", },
            },
        },
    },
    -- Visual and select mode mappings
    v = {
        ["<F2>"]  = { [[y:%s/\V<C-r>"/]],             "Replace word under cursor", silent = false },
        ["<F3>"]  = { "<CMD>set relativenumber!<CR>", "Toggle relative number"                    },
        ["<M-J>"] = { ":m '>+1<CR>gv-gv",             "Move line up"                              },
        ["<M-K>"] = { ":m '<-2<CR>gv-gv",             "Move line up"                              },
        ["<Space>"] = {
            p = { '"_dP', "Keep yanked text after paste" },
        },
    },
    -- Select mode mappings
    s = {},
    -- Visual mode mappings
    x = {
        g = {
            a = {
                name = "Align",
                T = {
                    [[:Tabularize /^[^=]*\zs=<CR>:'<,'>GTabularize /\[\[\(.*\)\]\],\?\|"\([^"]*\)",\?\|--\s.*\zs\|.*{\slink\s=.*\zs\|\S\+/l0l1<CR>:'<,'>Tabularize /},\?$\|}\?$\|},\s--\s\S\+\|}\s--\s\S\+<CR>]],
                    "Lua tables",
                }, -- Tabularize
                t = { ":Tabularize ", "Tabularize", silent = false }, -- Tabularize
            },
            c = { nil, "Line comment"  }, -- comment.nvim
            b = { nil, "Block comment" }, -- comment.nvim
        },
        ["<Space>"] = {
            f = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>",                   "Hop to",     }, -- hop
            F = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>",                  "Hop to",     }, -- hop
            t = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, hint_offset = -1 })<CR>", "Hop before", }, -- hop
            T = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, hint_offset = 1 })<CR>", "Hop before", }, -- hop
            gh = {
                name = "Git & gitsigns",
                a = { ":Gitsigns stage_hunk<CR>",       "Stage hunk"      }, -- gitsigns
                r = { ":Gitsigns reset_hunk<CR>",       "Reset hunk"      }, -- gitsigns
                v = { ":<C-U>Gitsigns select_hunk<CR>", "Select git hunk" }, -- gitsigns
            },
        },
    },
    -- Operator-pending mode mappings
    o = {
        i = {
            gh = { ":<C-U>Gitsigns select_hunk<CR>", "Select git hunk" }, -- gitsigns
        },
        ["<Space>"] = {
            f = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>",                   "Hop to",     }, -- hop
            F = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>",                  "Hop to",     }, -- hop
            t = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, hint_offset = -1 })<CR>", "Hop before", }, -- hop
            T = { "<CMD>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, hint_offset = 0 })<CR>", "Hop before", }, -- hop
        },
    },
    -- Insert mode mappints
    i = {
        ["<C-j>"] = { "<CR>", "Enter", noremap = false }, -- nvim-autopairs
    },
    -- Command-line mode mappings
    c = {
        ["<C-y>"] = { "<CR>",      "Enter"                                 },
        ["<M-H>"] = { "<Left>",    "Cursor left",           silent = false },
        ["<M-L>"] = { "<Right>",   "Cursor right",          silent = false },
        ["<M-h>"] = { "<S-Left>",  "Cursor one word left",  silent = false },
        ["<M-l>"] = { "<S-Right>", "Cursor one word right", silent = false },
    },
    -- Terminal mode mappings
    t = {
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
    },
}

set_undo_break_points(undo_break_points)
set_mappings(PA.mappings)
