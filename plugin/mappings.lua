-- "Undo chain" break points
local undo_break_points = { ".", ",", "!", "?", "=", "-", "_" }

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
        USER.mappings.i[point] = { point .. "<C-g>u" }
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
            silent = mappings.silent,
            expr = mappings.expr,
            nowait = mappings.nowait,
            script = mappings.script,
            unique = mappings.unique,
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

local function lua_cmd(plugin, modules, opts)
    modules = modules or ""
    opts = opts or ""

    return string.format([[<CMD>lua %s.%s(%s)<CR>]], plugin, modules, opts)
end

local function telescope_picker(picker)
    local config_path = [[require("plugins.telescope.pickers")]]
    return lua_cmd(config_path, picker)
end

local function hop_key(direction, offset, char_num)
    offset = offset and ( ", hint_offset = " .. offset ) or ""
    char_num = char_num or 1

    local plugin = [[require('hop')]]
    local modules = "hint_char" .. char_num
    local opts = [[{ direction = require("hop.hint").HintDirection.]] .. direction .. "_CURSOR" .. offset .. " }"
    return lua_cmd(plugin, modules, opts)
end

USER.mappings = {
    -- Normal mode mappings
    ["n"] = {
        ["*"] = { "*<CMD>lua require('hlslens').start()<CR>", "Search word under cursor"          }, -- hlslens
        ["#"] = { "#<CMD>lua require('hlslens').start()<CR>", "Search word under cursor backward" }, -- hlslens
        ["]"] = {
            ["["] = { nil,                                            "Next class start"                }, -- Assigned by nvim-treesitter-textobjects
            ["]"] = { nil,                                            "Next class end"                  }, -- Assigned by nvim-treesitter-textobjects
            ["a"] = { nil,                                            "Next parameter"                  }, -- Assigned by nvim-treesitter-textobjects
            ["b"] = { "<CMD>bn<CR>",                                  "Next buffer"                     },
            ["c"] = { "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'", "Next git hunk",      expr = true }, -- gitsigns.nvim
            ["d"] = { "<CMD>lua vim.diagnostic.goto_next()<CR>",      "Next lsp diagnostic"             }, -- nvim-lspconfig
            ["t"] = { "<CMD>tabnext<CR>",                             "Next tab"                        },
        },
        ["["] = {
            ["["] = { nil,                                            "Previous class start"                }, -- Assigned by nvim-treesitter-textobjects
            ["]"] = { nil,                                            "Previous class end"                  }, -- Assigned by nvim-treesitter-textobjects
            ["a"] = { nil,                                            "Previous parameter"                  }, -- Assigned by nvim-treesitter-textobjects
            ["b"] = { "<CMD>bp<CR>",                                  "Previous buffer"                     },
            ["c"] = { "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>'", "Previous git hunk",      expr = true }, -- gitsigns.nvim
            ["d"] = { "<CMD>lua vim.diagnostic.goto_prev()<CR>",      "Previous lsp diagnostic"             }, -- nvim-lspconfig
            ["t"] = { "<CMD>tabprevious<CR>",                         "Previous tab"                        }, -- Assigned by Hydra.nvim
        },
        ["<F1>"]  = { "<CMD>setlocal spell!<CR>",   "Toggle spelling"                           },
        ["<F2>"]  = { [[:%s/\<<C-r><C-w>\>/]],      "Replace word under cursor", silent = false },
        ["<F3>"]  = { "<CMD>set cursorcolumn!<CR>", "Toggle cursorcolumn"                       },
        ["<F11>"] = { "<CMD>set wrap!<CR>",         "Toggle wrap"                               },
        ["g"] = {
            ["*"] = { "*<CMD>lua require('hlslens').start()<CR>", "Search word under cursor"          }, -- hlslens
            ["#"] = { "#<CMD>lua require('hlslens').start()<CR>", "Search word under cursor backward" }, -- hlslens
            ["a"] = {
                name = "Align",
                ["T"] = {
                    [[:'<,'>Tabularize /^[^=]*\zs=<CR>:'<,'>GTabularize /\[\[\(.*\)\]\],\?\|"\([^"]*\)",\?\|--\s.*\zs\|.*{\slink\s=.*\zs\|\S\+/l0l1<CR>:'<,'>Tabularize /},\?$\|},\s--\s<CR>]],
                    "Lua tables"
                }, -- Tabularize
                ["t"] = { ":Tabularize ", "Tabularize", silent = false }, -- Tabularize
            },
            ["c"] = {
                name = "Line comment",
                ["A"] = { nil, "Add comment at the end of line" }, -- comment.nvim
                ["c"] = { nil, "Comment out"                    }, -- comment.nvim
                ["o"] = { nil, "Add comment on the line below"  }, -- comment.nvim
                ["O"] = { nil, "Add comment on the line above"  }, -- comment.nvim
            },
            ["b"] = {
                name = "Block comment",
                ["c"] = { nil, "Comment out" }, -- comment.nvim
            },
        },
        ["j"]     = { "v:count == 0 ? 'gj' : 'j'", "Move using displayed lines", expr = true },
        ["k"]     = { "v:count == 0 ? 'gk' : 'k'", "Move using displayed lines", expr = true },
        ["n"]     = { "<CMD>execute('normal! ' . v:count1 . 'nzzzv')<CR><CMD>lua require('hlslens').start()<CR><CMD>if &nu | set rnu | endif<CR>", "Repeat the latest '/' or '?'"           }, -- hlslens
        ["N"]     = { "<CMD>execute('normal! ' . v:count1 . 'Nzzzv')<CR><CMD>lua require('hlslens').start()<CR><CMD>if &nu | set rnu | endif<CR>", "Repeat the latest '/' or '?' backwards" }, -- hlslens
        ["z"] = {
            ["h"] = { nil, "Scroll the screen to the left"  }, -- Assigned using Hydra.nvim
            ["l"] = { nil, "Scroll the screen to the right" }, -- Assigned using Hydra.nvim
        },
        ["<M-J>"] = { ":m .+1<CR>==",                                        "Move line up"            },
        ["<M-K>"] = { ":m .-2<CR>==",                                        "Move line down"          },
        ["<Esc>"] = { [[:noh<CR>:lua require("notify").dismiss()<CR><CR>:lua require("luasnip").unlink_current()<CR><Esc>]], "Clear search highlight", },
        ["<Leader>"] = {
            ["b"] = {
                name = "Buffer",
                ["d"] = { "<CMD>Bdelete<CR>", "Delete buffer" }, -- bufdelete.nvim
            },
            ["i"] = { "<CMD>lua vim.show_pos()<CR>", "Show all the items at a given buffer position" },
            ["l"] = {
                name = "LSP alternative",
                ["d"] = {
                    name = "Definitions",
                    ["t"] = { telescope_picker("lsp_definitions"), "Telescope" }, -- nvim-lspconfig -- telescope.nvim
                    ["q"] = { "<CMD>Trouble lsp_definitions<CR>",  "Trouble"   }, -- nvim-lspconfig -- trouble.nvim
                },
                ["i"] = {
                    name = "Implementations",
                    ["t"] = { telescope_picker("implementations"),    "Telescope" }, -- nvim-lspconfig -- telescope.nvim
                    ["q"] = { "<CMD>Trouble lsp_implementations<CR>", "Trouble"   }, -- nvim-lspconfig -- trouble.nvim
                },
                ["r"] = {
                    name = "References",
                    ["t"] = { telescope_picker("lsp_references"), "Telescope" }, -- nvim-lspconfig -- telescope.nvim
                    ["q"] = { "<CMD>Trouble lsp_references<CR>",  "Trouble"   }, -- nvim-lspconfig -- trouble.nvim
                },
                ["t"] = {
                    name = "Type Definitions",
                    ["t"] = { telescope_picker("lsp_type_definitions"), "Telescope" }, -- nvim-lspconfig -- telescope.nvim
                    ["q"] = { "<CMD>Trouble lsp_type_definitions<CR>",  "Trouble"   }, -- nvim-lspconfig -- trouble.nvim
                },
            },
            ["q"] = { "<CMD>Bdelete<CR><CMD>quit<CR>",     "Delete buffer and close window" }, -- bufdelete.nvim
            ["Q"] = { "<CMD>Bdelete<CR><CMD>tabclose<CR>", "Delete buffer and close tab"    }, -- bufdelete.nvim
            ["p"] = {
                name = "Project",
                ["."] = { "<CMD>PossessionLoad<CR>", "Load last closed" }, -- possession.nvim
                ["c"] = {
                    name = "Create local config files",
                    ["c"] = { "<CMD>ProjectCreatePalette<CR>",        "Create palette"         }, -- hexokinase
                    ["s"] = { "<CMD>ProjectCreateSession<CR>",        "Create session"         }, -- possession.nvim
                    ["p"] = { "<CMD>ProjectCreatePrettierConfig<CR>", "Create prettier config" },
                },
                ["C"] = { "<CMD>ProjectCreateConfig<CR>", "Create local config file"              }, -- nvim-config-local
                ["D"] = { "<CMD>PossessionDelete<CR>",    "Delete currently loaded session"       }, -- possession.nvim
                ["L"] = { "<CMD>ProjectLoadSession<CR>",  "Load local session"                    }, -- possession.nvim
                ["S"] = { ":PossessionSave ",             "Save session",          silent = false }, -- possession.nvim
            },
            ["t"] = {
                name = "Tab",
                ["}"] = { ":+tabmove<CR>",     "Move tab right"                },
                ["{"] = { ":-tabmove<CR>",     "Move tab left"                 },
                ["a"] = { "<CMD>tabnew<CR>",   "Create new tab"                },
                ["c"] = { "<CMD>tabclose<CR>", "Close tab"                     },
                ["R"] = { ":TabRename ",       "Rename tab",    silent = false }, -- tabby.nvim
            },
            ["u"] = {
                name = "Utilities",
                ["s"] = {
                    name = "Status",
                    ["l"] = { "<CMD>LspInfo<CR>",    "LSP info"       }, -- lsp-config
                    ["m"] = { "<CMD>Mason<CR>",      "Mason status"   }, -- mason.nvim
                    ["n"] = { "<CMD>NullLsInfo<CR>", "Null-ls info"   }, -- null-ls.nvim
                    ["p"] = { "<CMD>Lazy<CR>",       "Plugins status" }, -- lazy.nvim
                },
                ["u"] = {
                    name = "Update",
                    ["l"] = { "<CMD>Mason<CR><CMD>MasonToolsUpdate<CR>", "Update LSP packages"       }, -- mason-tool-installer.nvim
                    ["P"] = { "<CMD>Lazy update<CR>",                    "Update plugins"            }, -- lazy.nvim
                    ["p"] = { "<CMD>Lazy check<CR>",                     "Check for plugins updates" }, -- lazy.nvim
                },
            },
        },
        ["<Space>"] = {
            ["?"] = { "<CMD>WhichKey<CR>",          "Show available hotkeys" }, -- which-key
            ["."] = { "<CMD>Telescope resume<CR>",  "Reopen Telescope"       }, -- telescope.nvim
            ["b"] = { "<CMD>Telescope buffers<CR>", "Buffer list"            }, -- telescope.nvim
            ["c"] = { "<CMD>HexokinaseToggle<CR>",  "Color codes preview"    }, -- hexokinase
            ["d"] = {
                name = "Diffview",
                ["q"] = { "<CMD>DiffviewClose<CR>",         "Quit"                              }, -- diffview
                ["e"] = { "<CMD>DiffviewToggleFiles<CR>",   "Toggle file tree"                  }, -- diffview
                ["h"] = { "<CMD>DiffviewFileHistory %<CR>", "Show history log for current file" }, -- diffview
                ["H"] = { "<CMD>DiffviewFileHistory<CR>",   "Show history log"                  }, -- diffview
                ["o"] = { "<CMD>DiffviewOpen<CR>",          "Open"                              }, -- diffview
                ["R"] = { "<CMD>DiffviewRefresh<CR>",       "Refresh stats and entries"         }, -- diffview
            },
            ["D"] = {
                name = "Diff mode",
                ["p"] = { ":diffpatch ",             "Patch the buffer with the requested file on a new buffer", silent = false, },
                ["q"] = { "<CMD>diffoff<CR>",        "Revert and quit"                                                           },
                ["R"] = { "<CMD>diffupdate<CR>",     "Updated the differences"                                                   },
                ["t"] = { "<CMD>diffthis<CR>",       "Make the current window part of the diff windows"                          },
                ["v"] = { ":vertical diffsplit ",    "Open the requested file in a split",                       silent = false, },
                ["w"] = { "<CMD>windo diffthis<CR>", "Compare the visible files"                                                 },
            },
            ["e"] = {
                name = "File, buffer and git explorer",
                ["b"] = { "<CMD>Neotree buffers left focus reveal toggle<CR>",     "Toggle a list of currently open buffers"                           }, -- neo-tree.nvim
                ["B"] = { "<CMD>Neotree buffers current<CR>",                      "Toggle a list of currently open buffers within the current window" }, -- neo-tree.nvim
                ["e"] = { "<CMD>Neotree filesystem left focus reveal toggle<CR>",  "Toggle file explorer"                                              }, -- neo-tree.nvim
                ["f"] = { "<CMD>NeoTreeFocus<CR>",                                 "Open or focus on file explorer"                                    }, -- neo-tree.nvim
                ["E"] = { "<CMD>Neotree filesystem current<CR>",                   "Open file explorer within the current window"                      }, -- neo-tree.nvim
                ["g"] = { "<CMD>Neotree git_status left focus reveal toggle <CR>", "Toggle git status in a floating window"                            }, -- neo-tree.nvim
            },
            ["f"] = { hop_key("AFTER"),  "Hop to" }, -- hop.nvim
            ["F"] = { hop_key("BEFORE"), "Hop to" }, -- hop.nvim
            ["g"] = {
                name = "Git",
                ["b"] = {
                    name = "Git blame",
                    ["l"] = { "<CMD>Gitsigns toggle_current_line_blame<CR>",            "Toggle line blame" }, -- gitsigns.nvim
                    ["w"] = { "<CMD>lua require('gitsigns').blame_line{full=true}<CR>", "Show blame window" }, -- gitsigns.nvim
                },
                ["c"] = { "<CMD>Telescope git_commits<CR>",  "Commits"        }, -- telescope.nvim
                ["C"] = { "<CMD>Telescope git_bcommits<CR>", "Buffer commits" }, -- telescope.nvim
                ["g"] = {
                    name = "Git actions",
                    ["a"] = { "<CMD>Gitsigns stage_buffer<CR>",       "Stage buffer"    }, -- gitsigns.nvim
                    ["r"] = { "<CMD>Gitsigns reset_buffer<CR>",       "Reset buffer"    }, -- gitsigns.nvim
                    ["u"] = { "<CMD>Gitsigns undo_stage_hunk<CR>",    "Undo stage hunk" }, -- gitsigns.nvim
                },
                ["G"] = {
                    name = "Misc",
                    ["b"] = { "<CMD>Telescope git_branches<CR>", "Branches"  }, -- telescope.nvim
                    ["S"] = { "<CMD>Telescope git_stash<CR>",    "Stash"     }, -- telescope.nvim
                },
                ["h"] = {
                    name = "Git actions",
                    ["a"] = { "<CMD>Gitsigns stage_hunk<CR>",         "Stage hunk"      }, -- gitsigns.nvim
                    ["r"] = { "<CMD>Gitsigns reset_hunk<CR>",         "Reset hunk"      }, -- gitsigns.nvim
                    ["u"] = { "<CMD>Gitsigns reset_buffer_index<CR>", "Unstage buffer"  }, -- gitsigns.nvim
                },
                ["p"] = { "<CMD>Gitsigns preview_hunk_inline<CR>", "Preview hunk" }, -- gitsigns.nvim
                ["s"] = { "<CMD>Telescope git_status<CR>",         "Status"       }, -- telescope.nvim
                ["v"] = {
                    name = "Diff highlighting",
                    ["l"] = { "<CMD>Gitsigns toggle_linehl<CR>",    "Toggle line diff highlighting"     }, -- gitsigns.nvim
                    ["n"] = { "<CMD>Gitsigns toggle_numhl<CR>",     "Toggle number diff highlighting"   }, -- gitsigns.nvim
                    ["w"] = { "<CMD>Gitsigns toggle_word_diff<CR>", "Toggle word diff highlighting"     }, -- gitsigns.nvim
                    ["d"] = { "<CMD>Gitsigns toggle_deleted<CR>",   "Toggle deleted lines highlighting" }, -- gitsigns.nvim
                },
            },
            ["l"] = {
                name = "LSP",
                ["a"] = { "<CMD>lua vim.lsp.buf.code_action()<CR>",            "Code actions"                          }, -- nvim-lspconfig
                ["d"] = { "<CMD>Glance definitions<CR>",                       "Definitions"                           }, -- nvim-lspconfig -- glance.nvim
                ["f"] = { "<CMD>lua vim.lsp.buf.format({ async = true })<CR>", "Format document"                       }, -- nvim-lspconfig
                ["F"] = { "<CMD>LspToggleAutoFormat<CR>",                      "Toggle auto formatting"                }, -- nvim-lspconfig
                ["h"] = { "<CMD>lua vim.diagnostic.open_float()<CR>",          "Line diagnostics"                      }, -- nvim-lspconfig
                ["i"] = { "<CMD>Glance implementations<CR>",                   "Implementations"                       }, -- nvim-lspconfig -- glance.nvim
                ["K"] = { "<CMD>lua vim.lsp.buf.hover()<CR>",                  "Hover symbol"                          }, -- nvim-lspconfig
                ["q"] = { "<CMD>Trouble document_diagnostics<CR>",             "Document diagnostics"                  }, -- nvim-lspconfig -- trouble.nvim
                ["Q"] = { "<CMD>Trouble workspace_diagnostics<CR>",            "Workspace diagnostics"                 }, -- nvim-lspconfig -- trouble.nvim
                ["r"] = { "<CMD>Glance references<CR>",                        "References"                            }, -- nvim-lspconfig -- glance.nvim
                ["R"] = { ":IncRename ",                                       "Rename symbol",         silent = false }, -- nvim-lspconfig -- inc-rename
                ["s"] = { "<CMD>lua vim.lsp.buf.signature_help()<CR>",         "Signature help"                        }, -- nvim-lspconfig
                ["t"] = { "<CMD>Glance type_definitions<CR>",                  "Type Definitions"                      }, -- nvim-lspconfig -- glance.nvim
            },
            ["m"] = {
                name = "Minimap",
                ["m"] = { "<CMD>lua require('codewindow').toggle_minimap()<CR>", "Toggle minimap"        }, -- codewindow.nvim
                ["o"] = { "<CMD>lua require('codewindow').open_minimap()<CR>",   "Open minimap"          }, -- codewindow.nvim
                ["c"] = { "<CMD>lua require('codewindow').close_minimap()<CR>",  "Close minimap"         }, -- codewindow.nvim
                ["f"] = { "<CMD>lua require('codewindow').toggle_focus()<CR>",   "Focus/unfocus minimap" }, -- codewindow.nvim
            },
            ["o"] = { "<CMD>AerialToggle<CR>",  "Toggle Code outline"                  }, -- aerial.nvim
            ["O"] = { "<CMD>AerialToggle!<CR>", "Toggle Code outline without focusing" }, -- aerial.nvim
            ["q"] = {
                name = "Trouble",
                ["c"] = { "<CMD>TroubleClose<CR>",                  "Close"    }, -- trouble.nvim
                ["f"] = { "<CMD>Trouble quickfix<CR>",              "Quickfix" }, -- trouble.nvim
                ["l"] = { "<CMD>Trouble loclist<CR>",               "Loclist"  }, -- trouble.nvim
                ["o"] = { "<CMD>Trouble<CR>",                       "Open"     }, -- trouble.nvim
                ["q"] = { "<CMD>TroubleToggle<CR>",                 "Toggle"   }, -- trouble.nvim
                ["R"] = { "<CMD>TroubleRefresh<CR>",                "Refresh"  }, -- trouble.nvim
            },
            ["r"] = { "<CMD>Telescope registers<CR>", "Registers" },
            ["s"] = {
                name = "Search",
                ["b"] = { telescope_picker("file_browser"), "File Browser" }, -- telescope.nvim
                ["d"] = {
                    name = "Search in Directory",
                    ["g"] = { "<CMD>Telescope dir live_grep<CR>",  "ripGREP"     }, -- telescope.nvim -- dir-telescope.nvim
                    ["f"] = { "<CMD>Telescope dir find_files<CR>", "File search" }, -- telescope.nvim -- dir-telescope.nvim
                },
                ["f"] = { "<CMD>Telescope find_files<CR>",  "File search"             }, -- telescope.nvim
                ["g"] = { "<CMD>Telescope live_grep<CR>",   "ripGREP"                 }, -- telescope.nvim
                ["H"] = { "<CMD>Telescope highlights<CR>",  "Highlight groups"        }, -- telescope.nvim
                ["h"] = { "<CMD>Telescope help_tags<CR>",   "Vim help"                }, -- telescope.nvim
                ["n"] = { telescope_picker("notify"),       "Notify history"          }, -- telescope.nvimnvim -- notify
                ["o"] = { "<CMD>Telescope vim_options<CR>", "Vim options"             }, -- telescope.nvim
                ["R"] = { telescope_picker("frecency"),     "Frecency"                }, -- telescope.nvim
                ["r"] = { telescope_picker("oldFiles"),     "Recent files"            }, -- telescope.nvim
                ["s"] = { telescope_picker("possession"),   "Search sessions"         }, -- telescope.nvim -- possession.nvim
                ["S"] = { telescope_picker("luasnip"),      "List available snippets" }, -- telescope-luasnip.nvim
                ["T"] = { "<CMD>TodoTelescope<CR>",         "Show TODO comments"      }, -- todo-comments
                ["t"] = {
                    name = "Telescope",
                    ["b"] = { "<CMD>Telescope builtin<CR>",         "Telescope builtin" }, -- telescope.nvim
                    ["c"] = { "<CMD>Telescope command_history<CR>", "Command history"   }, -- telescope.nvim
                },
            },
            ["t"] = { hop_key("AFTER", -1),                           "Hop before"       }, -- hop.nvim
            ["T"] = { hop_key("BEFORE", 1),                           "Hop before"       }, -- hop.nvim
            ["u"] = { "<CMD>NeoTreeClose<CR><CMD>UndotreeToggle<CR>", "Toggle undo tree" }, -- undotree
            ["<Space>"] = {
                name = "Launch",
                ["e"] = { "<CMD>LaunchDir dolphin<CR>",           "Open cwd in system file browser"        },
                ["l"] = { "<CMD>LaunchURL firefox --new-tab<CR>", "Open URL under cursor in browser"       },
                ["t"] = { "<CMD>terminal<CR>i",                   "Start a terminal session within Neovim" },
            },
        },
    },
    -- Visual and select mode mappings
    ["v"] = {
        ["<F2>"]  = { [[y:%s/\V<C-r>"/]],             "Replace word under cursor", silent = false },
        ["<F3>"]  = { "<CMD>set relativenumber!<CR>", "Toggle relative number"                    },
        ["<M-J>"] = { ":m '>+1<CR>gv-gv",             "Move line up"                              },
        ["<M-K>"] = { ":m '<-2<CR>gv-gv",             "Move line up"                              },
        ["<Space>"] = {
            ["p"] = { '"_dP', "Keep yanked text after paste" },
        },
    },
    -- Select mode mappings
    ["s"] = {
        ["<BS>"]  = { [[<BS>i]],  "Delete selection" }, -- Helpful when editing snippet placeholders
        ["<C-h>"] = { [[<C-h>i]], "Delete selection" }, -- Helpful when editing snippet placeholders
    },
    -- Visual mode mappings
    ["x"] = {
        ["g"] = {
            ["a"] = {
                name = "Align",
                ["T"] = {
                    [[:Tabularize /^[^=]*\zs=<CR>:'<,'>GTabularize /\[\[\(.*\)\]\],\?\|"\([^"]*\)",\?\|--\s.*\zs\|.*{\slink\s=.*\zs\|\S\+/l0l1<CR>:'<,'>Tabularize /},\?$\|}\?$\|},\s--\s\S\+\|}\s--\s\S\+<CR>]],
                    "Lua tables",
                }, -- Tabularize
                ["t"] = { ":Tabularize ", "Tabularize", silent = false }, -- Tabularize
            },
            ["c"] = { nil, "Line comment"  }, -- comment.nvim
            ["b"] = { nil, "Block comment" }, -- comment.nvim
        },
        ["i"] = {
            ["g"] = {
                name = "Git & gitsigns",
                ["h"] = { ":<C-U>Gitsigns select_hunk<CR>", "Git hunk" }, -- gitsigns
            },
        },
        ["<Space>"] = {
            ["f"] = { hop_key("AFTER"),     "Hop to"     }, -- hop.nvim
            ["F"] = { hop_key("BEFORE"),    "Hop to"     }, -- hop.nvim
            ["t"] = { hop_key("AFTER", -1), "Hop before" }, -- hop.nvim
            ["T"] = { hop_key("BEFORE", 1), "Hop before" }, -- hop.nvim
            ["gh"] = {
                name = "Git & gitsigns",
                ["a"] = { ":Gitsigns stage_hunk<CR>",       "Stage hunk"      }, -- gitsigns
                ["r"] = { ":Gitsigns reset_hunk<CR>",       "Reset hunk"      }, -- gitsigns
                ["v"] = { ":<C-U>Gitsigns select_hunk<CR>", "Select git hunk" }, -- gitsigns
            },
        },
    },
    -- Operator-pending mode mappings
    ["o"] = {
        ["i"] = {
            ["g"] = {
                name = "Git & gitsigns",
                ["h"] = { ":<C-U>Gitsigns select_hunk<CR>", "Git hunk" }, -- gitsigns
            },
        },
        ["<Space>"] = {
            ["f"] = { hop_key("AFTER"),     "Hop to"     }, -- hop.nvim
            ["F"] = { hop_key("BEFORE"),    "Hop to"     }, -- hop.nvim
            ["t"] = { hop_key("AFTER", -1), "Hop before" }, -- hop.nvim
            ["T"] = { hop_key("BEFORE", 1), "Hop before" }, -- hop.nvim
        },
    },
    -- Insert mode mappints
    ["i"] = {
        ["<F1>"]  = { "<CMD>setlocal spell!<CR>",               "Toggle spelling"                               },
        ["<F3>"]  = { "<CMD>set cursorcolumn!<CR>",             "Toggle cursorcolumn"                           },
        ["<C-j>"] = { "<CR>",                                   "Carriage return",              noremap = false }, -- Helpful with autopair plugins
        ["<M-p>"] = { [[<C-r><C-o>+]],                          "Paste and stay in insert mode"                 },
    },
    -- Command-line mode mappings
    ["c"] = {
        ["<M-H>"] = { "<Left>",    "Cursor left",           silent = false },
        ["<M-L>"] = { "<Right>",   "Cursor right",          silent = false },
        ["<M-h>"] = { "<S-Left>",  "Cursor one word left",  silent = false },
        ["<M-l>"] = { "<S-Right>", "Cursor one word right", silent = false },
    },
    -- Terminal mode mappings
    ["t"] = {
        ["<Esc>"] = {
            ["<Esc>"]    = { "<Esc>",                          "Escape Neovim insert mode"   },
            ["<Leader>"] = { replaceTermcodes([[<C-\><C-N>]]), "Escape terminal insert mode" },
        },
        ["<C-w>"] = {
            ["h"] = { replaceTermcodes([[<C-\><C-N><C-w>h]]), "Go to the left window"  },
            ["j"] = { replaceTermcodes([[<C-\><C-N><C-w>j]]), "Go to the down window"  },
            ["k"] = { replaceTermcodes([[<C-\><C-N><C-w>k]]), "Go to the up window"    },
            ["l"] = { replaceTermcodes([[<C-\><C-N><C-w>l]]), "Go to the right window" },
        },
    },
}

set_undo_break_points(undo_break_points)
set_mappings(USER.mappings)
