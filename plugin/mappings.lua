-- "Undo chain" break points
local undo_break_points = { ".", ",", "!", "?", "=", "-", "_" }

local default_opts = {
    noremap = true,
    silent = true,
    expr = false,
    nowait = false,
    script = false,
    unique = false,
    desc = "",
}

local function set_undo_break_points(break_points)
    for _, point in pairs(break_points) do
        USER.mappings.i[point] = { string.format("%s<C-g>u", point) }
    end
end

local function replaceTermcodes(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function set_keymap(mappings, mode, prefix)
    -- Source: echasnovski/nvim
    -- https://github.com/echasnovski/nvim/blob/47eb53792a1ff1e1c482c19fbae8ac035e352e2d/lua/ec/mappings-leader.lua#L198-L220
    if type(mappings) ~= "table" then return end

    prefix = prefix or ""

    if type(mappings[1]) == "string" or type(mappings[1]) == "function" then
        local local_opts = {
            noremap = mappings.noremap,
            silent = mappings.silent,
            expr = mappings.expr,
            nowait = mappings.nowait,
            script = mappings.script,
            unique = mappings.unique,
            desc = mappings.desc,
        }
        local opts = vim.tbl_deep_extend("force", default_opts, local_opts)
        vim.keymap.set(mode, prefix, mappings[1], opts)
        return
    end

    for key, t in pairs(mappings) do
        if key ~= "group" then set_keymap(t, mode, string.format("%s%s", prefix, key)) end
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

    return string.format([[<Cmd>lua %s.%s(%s)<CR>]], plugin, modules, opts)
end

local function fzf_picker(picker)
    local config_path = [[require("plugins.fzf-lua.pickers")]]
    return lua_cmd(config_path, picker)
end

local go_to_change = function(direction)
    return function()
        if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
        else
            require("gitsigns").nav_hunk(direction)
        end
    end
end

USER.mappings = {
    -- Normal mode mappings
    ["n"] = {
        ["*"] = { "*<Cmd>lua require('hlslens').start()<CR>", desc = "Search word under cursor" }, -- hlslens
        ["#"] = { "#<Cmd>lua require('hlslens').start()<CR>", desc = "Search word under cursor backward" }, -- hlslens
        ["]"] = {
            group = "Next",
            ["["] = { desc = "Next class start" }, -- Assigned by nvim-treesitter-textobjects
            ["]"] = { desc = "Next class end" }, -- Assigned by nvim-treesitter-textobjects
            ["A"] = { desc = "Next end of parameter" }, -- Assigned by nvim-treesitter-textobjects
            ["a"] = { desc = "Next parameter" }, -- Assigned by nvim-treesitter-textobjects
            ["b"] = { function() vim.cmd.bn() end, desc = "Next buffer" },
            ["c"] = { go_to_change("next"), desc = "Next git hunk" }, -- gitsigns.nvim
            ["d"] = { desc = "Next diagnostic" }, -- lsp-config
            ["M"] = { desc = "Next end of function" }, -- Assigned by nvim-treesitter-textobjects
            ["m"] = { desc = "Next function" }, -- Assigned by nvim-treesitter-textobjects
            ["r"] = { function() require("snacks").words.jump(vim.v.count1) end, desc = "Next Reference" }, -- snacks.nvim
            ["t"] = { function() vim.cmd.tabnext() end, desc = "Next tab" },
        },
        ["["] = {
            group = "Previous",
            ["["] = { desc = "Previous class start" }, -- Assigned by nvim-treesitter-textobjects
            ["]"] = { desc = "Previous class end" }, -- Assigned by nvim-treesitter-textobjects
            ["A"] = { desc = "Previous end of parameter" }, -- Assigned by nvim-treesitter-textobjects
            ["a"] = { desc = "Previous parameter" }, -- Assigned by nvim-treesitter-textobjects
            ["b"] = { function() vim.cmd.bp() end, desc = "Previous buffer" },
            ["c"] = { go_to_change("prev"), desc = "Previous git hunk" }, -- gitsigns.nvim
            ["d"] = { desc = "Previous diagnostic" }, -- lsp-config
            ["M"] = { desc = "Previous end of function" }, -- Assigned by nvim-treesitter-textobjects
            ["m"] = { desc = "Previous function" }, -- Assigned by nvim-treesitter-textobjects
            ["r"] = { function() require("snacks").words.jump(-vim.v.count1) end, desc = "Previous Reference" }, -- snacks.nvim
            ["t"] = { function() vim.cmd.tabprevious() end, desc = "Previous tab" }, -- Assigned by Hydra.nvim
        },
        ["<F4>"] = { group = "Toggle" }, -- toggle hub leaves assigned in lua/plugins/snacks.lua
        ["<F2>"] = { [[:%s/\<<C-r><C-w>\>/]], desc = "Replace word under cursor", silent = false },
        ["g"] = {
            ["*"] = { "*<Cmd>lua require('hlslens').start()<CR>", desc = "Search word under cursor" }, -- hlslens
            ["#"] = { "#<Cmd>lua require('hlslens').start()<CR>", desc = "Search word under cursor backward" }, -- hlslens
            ["A"] = { desc = "Align with preview" }, -- mini.align
            ["a"] = { desc = "Align" }, -- mini.align
            ["c"] = {
                group = "Line comment",
                ["A"] = { desc = "Add comment at the end of line" }, -- comment.nvim
                ["c"] = { desc = "Comment out" }, -- comment.nvim
                ["o"] = { desc = "Add comment on the line below" }, -- comment.nvim
                ["O"] = { desc = "Add comment on the line above" }, -- comment.nvim
            },
            ["b"] = {
                group = "Block comment",
                ["c"] = { desc = "Comment out" }, -- comment.nvim
            },
        },
        ["j"] = { "v:count == 0 ? 'gj' : 'j'", desc = "Move using displayed lines", expr = true },
        ["k"] = { "v:count == 0 ? 'gk' : 'k'", desc = "Move using displayed lines", expr = true },
        ["n"] = {
            "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
            desc = "Repeat the latest '/' or '?'",
        }, -- hlslens
        ["N"] = {
            "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
            desc = "Repeat the latest '/' or '?' backwards",
        }, -- hlslens
        ["z"] = {
            ["h"] = { desc = "Scroll the screen to the left" }, -- Assigned using Hydra.nvim
            ["l"] = { desc = "Scroll the screen to the right" }, -- Assigned using Hydra.nvim
            ["M"] = { function() require("ufo").closeAllFolds() end, desc = "Close all folds" }, -- nvim-ufo
            ["R"] = { function() require("ufo").openAllFolds() end, desc = "Open all folds" }, -- nvim-ufo
            ["m"] = { function() require("ufo").closeFoldsWith() end, desc = "Close folds with" }, -- nvim-ufo
            ["p"] = { function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" }, -- nvim-ufo
            ["r"] = { function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds except kinds" }, -- nvim-ufo
        },
        ["<C-s>"] = { function() require("flash").jump() end, desc = "Flash" }, -- flash.nvim
        ["<C-w>"] = {
            ["<Space>"] = {
                function() require("which-key").show({ keys = "<c-w>", loop = true }) end,
                desc = "Window Hydra Mode (which-key)",
            },
        }, -- which-key.nvim
        ["<M-J>"] = { ":m .+1<CR>==", desc = "Move line down" },
        ["<M-K>"] = { ":m .-2<CR>==", desc = "Move line up" },
        ["<M-X>"] = { "<Cmd>x<CR>", desc = "Save and quit only if there are changes in the file" },
        ["<Esc>"] = {
            [[:noh<CR>:lua require("snacks").notifier.hide()<CR>:lua require("luasnip").unlink_current()<CR><Esc>]],
            desc = "Clear search highlight",
        },
        -- Primary leader namespace (<Leader> = <Space>): act on code / project.
        ["<Leader>"] = {
            ["?"] = { function() require("which-key").show() end, desc = "Buffer Local Keymaps (which-key)" },
            ["."] = { "<Cmd>FzfLua resume<CR>", desc = "Reopen last picker" }, -- fzf-lua
            ["b"] = { "<Cmd>FzfLua buffers<CR>", desc = "Buffer list" }, -- fzf-lua
            ["d"] = {
                group = "CodeDiff",
                ["o"] = { "<Cmd>CodeDiff<CR>", desc = "Open status / diff" }, -- codediff.nvim
                ["h"] = { "<Cmd>CodeDiff history %<CR>", desc = "File history" }, -- codediff.nvim
                ["H"] = { "<Cmd>CodeDiff history<CR>", desc = "Repo history" }, -- codediff.nvim
            },
            ["D"] = {
                group = "Diff mode",
                ["p"] = {
                    ":diffpatch ",
                    desc = "Patch the buffer with the requested file on a new buffer",
                    silent = false,
                },
                ["q"] = { "<Cmd>diffoff<CR>", desc = "Revert and quit" },
                ["R"] = { "<Cmd>diffupdate<CR>", desc = "Updated the differences" },
                ["t"] = { "<Cmd>diffthis<CR>", desc = "Make the current window part of the diff windows" },
                ["v"] = { ":vertical diffsplit ", desc = "Open the requested file in a split", silent = false },
                ["w"] = { "<Cmd>windo diffthis<CR>", desc = "Compare the visible files" },
            },
            ["e"] = {
                group = "File, buffer and git explorer",
                ["b"] = {
                    "<Cmd>Neotree buffers left focus reveal toggle<CR>",
                    desc = "Toggle a list of currently open buffers",
                }, -- neo-tree.nvim
                ["B"] = {
                    "<Cmd>Neotree buffers current<CR>",
                    desc = "Toggle a list of currently open buffers within the current window",
                }, -- neo-tree.nvim
                ["e"] = { "<Cmd>Neotree filesystem left focus reveal toggle<CR>", desc = "Toggle file explorer" }, -- neo-tree.nvim
                ["E"] = {
                    "<Cmd>Neotree filesystem current<CR>",
                    desc = "Open file explorer within the current window",
                }, -- neo-tree.nvim
                ["f"] = { "<Cmd>Neotree focus<CR>", desc = "Open or focus on file explorer" }, -- neo-tree.nvim
                ["g"] = { "<Cmd>Neotree git_status left focus reveal toggle <CR>", desc = "Toggle git status panel" }, -- neo-tree.nvim
                ["o"] = { "<Cmd>Neotree document_symbols<CR>", desc = "Toggle document symbols panel" }, -- neo-tree.nvim
            },
            ["g"] = {
                group = "Git",
                ["b"] = {
                    group = "Git blame",
                    ["b"] = {
                        function() require("gitsigns").toggle_current_line_blame() end,
                        desc = "Toggle line blame",
                    }, -- gitsigns.nvim
                    ["w"] = {
                        function() require("gitsigns").blame_line({ full = true }) end,
                        desc = "Show blame window",
                    }, -- gitsigns.nvim
                },
                ["c"] = { "<Cmd>FzfLua git_commits<CR>", desc = "Commits" }, -- fzf-lua
                ["C"] = { "<Cmd>FzfLua git_bcommits<CR>", desc = "Buffer commits" }, -- fzf-lua
                ["g"] = {
                    group = "Git buffer actions",
                    ["<Space>"] = { function() require("gitsigns").stage_buffer() end, desc = "Stage buffer" }, -- gitsigns.nvim
                    ["r"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset buffer" }, -- gitsigns.nvim
                    ["R"] = {
                        function() require("gitsigns").reset_buffer_index() end,
                        desc = "`git reset` on current buffer",
                    }, -- gitsigns.nvim
                },
                ["G"] = {
                    group = "Misc",
                    ["b"] = { "<Cmd>FzfLua git_branches<CR>", desc = "Branches" }, -- fzf-lua
                    ["S"] = { "<Cmd>FzfLua git_stash<CR>", desc = "Stash" }, -- fzf-lua
                },
                ["h"] = {
                    group = "Git hunk actions",
                    ["<Space>"] = { function() require("gitsigns").stage_hunk() end, desc = "Stage hunk" }, -- gitsigns.nvim
                    ["r"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset hunk" }, -- gitsigns.nvim
                    ["u"] = { function() require("gitsigns").undo_stage_hunk() end, desc = "Undo stage hunk" }, -- gitsigns.nvim
                },
                ["p"] = { function() require("gitsigns").preview_hunk_inline() end, desc = "Preview hunk" }, -- gitsigns.nvim
                ["s"] = { "<Cmd>FzfLua git_status<CR>", desc = "Status" }, -- fzf-lua
                ["v"] = {
                    group = "Diff highlighting",
                    ["d"] = {
                        function() require("gitsigns").toggle_deleted() end,
                        desc = "Toggle deleted highlighting",
                    }, -- gitsigns.nvim
                    ["H"] = {
                        function() require("gitsigns").preview_hunk_inline() end,
                        desc = "Preview current hunk in a floating window",
                    }, -- gitsigns.nvim
                    ["h"] = {
                        function() require("gitsigns").preview_hunk_inline() end,
                        desc = "Preview current hunk inline",
                    }, -- gitsigns.nvim
                    ["l"] = {
                        function() require("gitsigns").toggle_linehl() end,
                        desc = "Toggle line diff highlighting",
                    }, -- gitsigns.nvim
                    ["n"] = {
                        function() require("gitsigns").toggle_numhl() end,
                        desc = "Toggle number diff highlighting",
                    }, -- gitsigns.nvim
                    ["w"] = {
                        function() require("gitsigns").toggle_word_diff() end,
                        desc = "Toggle word diff highlighting",
                    }, -- gitsigns.nvim
                },
            },
            ["l"] = {
                group = "LSP",
                ["a"] = { function() require("tiny-code-action").code_action() end, desc = "Code actions" }, -- nvim-lspconfig -- tiny-code-action.nvim
                ["d"] = { "<Cmd>Glance definitions<CR>", desc = "Definitions" }, -- nvim-lspconfig -- glance.nvim
                ["f"] = { function() vim.lsp.buf.format({ async = true }) end, desc = "Format document" }, -- nvim-lspconfig
                ["F"] = { "<Cmd>LspToggleAutoFormat<CR>", desc = "Toggle auto formatting" }, -- nvim-lspconfig
                ["i"] = { "<Cmd>Glance implementations<CR>", desc = "Implementations" }, -- nvim-lspconfig -- glance.nvim
                ["q"] = { "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Document diagnostics" }, -- nvim-lspconfig -- trouble.nvim
                ["Q"] = { "<Cmd>Trouble diagnostics toggle<CR>", desc = "Workspace diagnostics" }, -- nvim-lspconfig -- trouble.nvim
                ["r"] = { "<Cmd>Glance references<CR>", desc = "References" }, -- nvim-lspconfig -- glance.nvim
                ["R"] = { ":IncRename ", desc = "Rename symbol", silent = false }, -- nvim-lspconfig -- inc-rename
                ["t"] = { "<Cmd>Glance type_definitions<CR>", desc = "Type Definitions" }, -- nvim-lspconfig -- glance.nvim
                ["T"] = {
                    group = "fzf-lua / Trouble",
                    ["a"] = { "<Cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code actions (builtin)" }, -- nvim-lspconfig
                    ["d"] = { fzf_picker("lsp_definitions"), desc = "Definitions (fzf-lua)" }, -- fzf-lua
                    ["i"] = { fzf_picker("lsp_implementations"), desc = "Implementations (fzf-lua)" }, -- fzf-lua
                    ["I"] = { "<Cmd>Trouble lsp_implementations<CR>", desc = "Implementations (Trouble)" }, -- trouble.nvim
                    ["q"] = {
                        "<Cmd>Trouble lsp toggle focus=false win.position=right<CR>",
                        desc = "LSP results (Trouble)",
                    }, -- trouble.nvim
                    ["r"] = { fzf_picker("lsp_references"), desc = "References (fzf-lua)" }, -- fzf-lua
                    ["t"] = { fzf_picker("lsp_type_definitions"), desc = "Type Definitions (fzf-lua)" }, -- fzf-lua
                },
            },
            ["m"] = {
                group = "Minimap",
                ["m"] = { "<Cmd>lua require('codewindow').toggle_minimap()<CR>", desc = "Toggle minimap" }, -- codewindow.nvim
                ["o"] = { "<Cmd>lua require('codewindow').open_minimap()<CR>", desc = "Open minimap" }, -- codewindow.nvim
                ["c"] = { "<Cmd>lua require('codewindow').close_minimap()<CR>", desc = "Close minimap" }, -- codewindow.nvim
                ["f"] = { "<Cmd>lua require('codewindow').toggle_focus()<CR>", desc = "Focus/unfocus minimap" }, -- codewindow.nvim
            },
            ["o"] = { "<Cmd>Outline<CR>", desc = "Toggle Code outline" }, -- outline.nvim
            ["O"] = { "<Cmd>Outline!<CR>", desc = "Toggle Code outline without focusing" }, -- outline.nvim
            ["q"] = {
                group = "Trouble",
                ["c"] = { "<Cmd>lua require('trouble').close()<CR>", desc = "Close" }, -- trouble.nvim
                ["f"] = { "<Cmd>Trouble qflist toggle<CR>", desc = "Quickfix" }, -- trouble.nvim
                ["l"] = { "<Cmd>Trouble loclist toggle<CR>", desc = "Loclist" }, -- trouble.nvim
                ["q"] = { "<Cmd>lua require('trouble').focus()<CR>", desc = "Focus" }, -- trouble.nvim
                ["R"] = { "<Cmd>lua require('trouble').refresh()<CR>", desc = "Refresh" }, -- trouble.nvim
            },
            ["r"] = { "<Cmd>FzfLua registers<CR>", desc = "Registers" }, -- fzf-lua
            ["s"] = {
                group = "Search",
                ["d"] = {
                    group = "Search in Directory",
                    ["g"] = { fzf_picker("dir_grep"), desc = "ripGREP" }, -- fzf-lua
                    ["f"] = { fzf_picker("dir_files"), desc = "File search" }, -- fzf-lua
                },
                ["f"] = { "<Cmd>FzfLua files<CR>", desc = "File search" }, -- fzf-lua
                ["g"] = { "<Cmd>FzfLua live_grep<CR>", desc = "ripGREP" }, -- fzf-lua
                ["H"] = { "<Cmd>FzfLua highlights<CR>", desc = "Highlight groups" }, -- fzf-lua
                ["h"] = { "<Cmd>FzfLua help_tags<CR>", desc = "Vim help" }, -- fzf-lua
                ["n"] = { function() require("snacks").notifier.show_history() end, desc = "Notify history" }, -- snacks.nvim
                ["s"] = { fzf_picker("sessions"), desc = "Search sessions" }, -- fzf-lua -- possession.nvim
                ["S"] = { fzf_picker("snippets"), desc = "List available snippets" }, -- fzf-lua -- LuaSnip
                ["T"] = { "<Cmd>TodoFzfLua<CR>", desc = "Show TODO comments" }, -- todo-comments
                ["t"] = {
                    group = "fzf-lua",
                    ["b"] = { "<Cmd>FzfLua builtin<CR>", desc = "fzf-lua builtin" }, -- fzf-lua
                    ["c"] = { "<Cmd>FzfLua command_history<CR>", desc = "Command history" }, -- fzf-lua
                },
            },
            ["t"] = {
                group = "Send to terminal",
                ["e"] = {
                    function()
                        require("yeet").execute(nil, { clear_before_yeet = false, interrupt_before_yeet = true })
                    end,
                    desc = "Execute command",
                }, -- yeet.nvim
                ["E"] = { function() require("yeet").toggle_post_write() end, desc = "Toggle execution on write" }, -- yeet.nvim
                ["l"] = { function() require("yeet").list_cmd() end, desc = "List previous commands" }, -- yeet.nvim
            },
            ["u"] = { "<Cmd>Neotree close<CR><Cmd>UndotreeToggle<CR>", desc = "Toggle undo tree" }, -- undotree
            ["<Leader>"] = {
                group = "Launch",
                ["e"] = { "<Cmd>LaunchDir dolphin<CR>", desc = "Open cwd in system file browser" },
                ["l"] = { "<Cmd>LaunchURL firefox --new-tab<CR>", desc = "Open URL under cursor in browser" },
                ["t"] = { "<Cmd>terminal<CR>i", desc = "Start a terminal session within Neovim" },
                ["g"] = { function() require("snacks").gitbrowse() end, desc = "Git Browse" }, -- snacks.nvim
            },
        },
        -- Secondary leader namespace (<LocalLeader> = "\"): manage the workspace.
        ["<LocalLeader>"] = {
            ["b"] = {
                group = "Buffer manipulation",
                ["d"] = { function() vim.cmd.lua("MiniBufremove.delete()") end, desc = "Delete buffer" }, -- mini.bufremove
            },
            ["c"] = {
                group = "Color tools",
                ["n"] = { "<Cmd>CccConvert<CR>", desc = "Convert color to the next color format" }, -- ccc.nvim
                ["c"] = { "<Cmd>CccHighlighterToggle<CR>", desc = "Color codes preview" }, -- ccc.nvim
                ["p"] = { "<Cmd>CccPick<CR>", desc = "Color picker" }, -- ccc.nvim
            },
            ["i"] = { "<Cmd>lua vim.show_pos()<CR>", desc = "Show all the items at a given buffer position" },
            ["q"] = {
                function()
                    vim.cmd.lua("MiniBufremove.delete()")
                    vim.cmd.quit()
                end,
                desc = "Delete buffer and close window",
            }, -- mini.bufremove
            ["p"] = {
                group = "Project",
                ["."] = { "<Cmd>PossessionLoad<CR>", desc = "Load last closed" }, -- possession.nvim
                ["c"] = {
                    group = "Create local config files",
                    ["c"] = { "<Cmd>ProjectCreatePalette<CR>", desc = "Create palette" }, -- ccc.nvim
                    ["s"] = { "<Cmd>ProjectCreateSession<CR>", desc = "Create session" }, -- possession.nvim
                    ["p"] = { "<Cmd>ProjectCreatePrettierConfig<CR>", desc = "Create prettier config file" },
                    ["e"] = { "<Cmd>ProjectCreateEditorConfig<CR>", desc = "Create EditorConfig file" },
                    ["g"] = {
                        group = "Create or update .gitignore file",
                        ["g"] = { "<Cmd>ProjectCreateGitignore<CR>", desc = "Create or update the .gitignore file" },
                        ["d"] = {
                            "<Cmd>ProjectAppendGitignoreDjango<CR>",
                            desc = "Create or update the .gitignore file with Django-specific rules.",
                        },
                    },
                },
                ["C"] = { "<Cmd>ProjectCreateConfig<CR>", desc = "Create local config file" }, -- nvim-config-local
                ["D"] = { "<Cmd>PossessionDelete<CR>", desc = "Delete currently loaded session" }, -- possession.nvim
                ["L"] = { "<Cmd>ProjectLoadSession<CR>", desc = "Load local session" }, -- possession.nvim
                ["S"] = { ":PossessionSave ", desc = "Save session", silent = false }, -- possession.nvim
            },
            ["t"] = {
                group = "Tab",
                ["}"] = { "<Cmd>tabmove +1<CR>", desc = "Move tab right" },
                ["{"] = { "<Cmd>tabmove -1<CR>", desc = "Move tab left" },
                ["a"] = { "<Cmd>tabnew<CR>", desc = "Create new tab" },
                ["c"] = { "<Cmd>tabclose<CR>", desc = "Close tab" },
                ["R"] = { ":TabRename ", desc = "Rename tab", silent = false }, -- tabby.nvim
            },
            ["u"] = {
                group = "Utilities",
                ["s"] = {
                    group = "Status",
                    ["l"] = { "<Cmd>checkhealth vim.lsp<CR>", desc = "LSP info" }, -- lsp-config
                    ["m"] = { "<Cmd>Mason<CR>", desc = "Mason status" }, -- mason.nvim
                    ["n"] = { "<Cmd>NullLsInfo<CR>", desc = "Null-ls info" }, -- null-ls.nvim
                    ["p"] = { "<Cmd>Lazy<CR>", desc = "Plugins status" }, -- lazy.nvim
                },
                ["u"] = {
                    group = "Update",
                    ["l"] = { "<Cmd>Mason<CR><Cmd>MasonToolsUpdate<CR>", desc = "Update LSP packages" }, -- mason-tool-installer.nvim
                    ["P"] = { "<Cmd>Lazy update<CR>", desc = "Update plugins" }, -- lazy.nvim
                    ["p"] = { "<Cmd>Lazy check<CR>", desc = "Check for plugins updates" }, -- lazy.nvim
                },
            },
        },
    },
    -- Select mode mappings
    ["s"] = {
        ["<BS>"] = { [[<BS>i]], desc = "Delete selection" }, -- Helpful when editing snippet placeholders
        ["<C-h>"] = { [[<C-h>i]], desc = "Delete selection" }, -- Helpful when editing snippet placeholders
    },
    -- Visual mode mappings (Visual-only; Select-mode lives in the "s" table above)
    ["x"] = {
        ["<F2>"] = { [[y:%s/\V<C-r>"/]], desc = "Replace word under cursor", silent = false },
        ["<F4>"] = { group = "Toggle" }, -- toggle hub leaves assigned in lua/plugins/snacks.lua
        ["<M-J>"] = { ":m '>+1<CR>gv-gv", desc = "Move line down" },
        ["<M-K>"] = { ":m '<-2<CR>gv-gv", desc = "Move line up" },
        ["<C-s>"] = { function() require("flash").jump() end, desc = "Flash" }, -- flash.nvim
        ["g"] = {
            ["A"] = { desc = "Align with preview" }, -- mini.align
            ["a"] = { desc = "Align" }, -- mini.align
            ["c"] = { desc = "Line comment" }, -- comment.nvim
            ["b"] = { desc = "Block comment" }, -- comment.nvim
        },
        ["i"] = {
            ["g"] = {
                group = "Git & gitsigns",
                ["h"] = { ":<C-U>Gitsigns select_hunk<CR>", desc = "Git hunk" }, -- gitsigns
            },
        },
        ["<Leader>"] = {
            ["p"] = { '"_dP', desc = "Keep yanked text after paste" },
            ["l"] = {
                group = "LSP",
                ["a"] = { function() require("tiny-code-action").code_action() end, desc = "Code actions" }, -- nvim-lspconfig -- tiny-code-action.nvim
                ["f"] = { function() vim.lsp.buf.format({ async = true }) end, desc = "Format document" }, -- nvim-lspconfig
            },
            ["gh"] = {
                group = "Git & gitsigns",
                ["a"] = { ":Gitsigns stage_hunk<CR>", desc = "Stage hunk" }, -- gitsigns
                ["r"] = { ":Gitsigns reset_hunk<CR>", desc = "Reset hunk" }, -- gitsigns
                ["v"] = { ":<C-U>Gitsigns select_hunk<CR>", desc = "Select git hunk" }, -- gitsigns
            },
        },
    },
    -- Operator-pending mode mappings
    ["o"] = {
        ["i"] = {
            ["g"] = {
                group = "Git & gitsigns",
                ["h"] = { ":<C-U>Gitsigns select_hunk<CR>", desc = "Git hunk" }, -- gitsigns
            },
        },
        ["<C-s>"] = { function() require("flash").jump() end, desc = "Flash" }, -- flash.nvim
    },
    -- Insert mode mappings
    ["i"] = {
        ["<F4>"] = { group = "Toggle" }, -- toggle hub leaves assigned in lua/plugins/snacks.lua
        ["<M-p>"] = { [[<C-r><C-o>+]], desc = "Paste and stay in insert mode" },
        ["<C-s>"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature help" }, -- nvim-lspconfig
    },
    -- Command-line mode mappings
    ["c"] = {
        ["<M-H>"] = { "<Left>", desc = "Cursor left", silent = false },
        ["<M-L>"] = { "<Right>", desc = "Cursor right", silent = false },
        ["<M-h>"] = { "<S-Left>", desc = "Cursor one word left", silent = false },
        ["<M-l>"] = { "<S-Right>", desc = "Cursor one word right", silent = false },
        ["<F12>"] = { function() require("flash").toggle() end, desc = "Toggle flash search", silent = false }, -- flash.nvim
    },
    -- Terminal mode mappings
    ["t"] = {
        ["<Esc>"] = {
            ["<Esc>"] = { "<Esc>", desc = "Escape Neovim insert mode" },
            ["<Leader>"] = { replaceTermcodes([[<C-\><C-N>]]), desc = "Escape terminal insert mode" },
        },
        ["<C-w>"] = {
            ["h"] = { replaceTermcodes([[<C-\><C-N><C-w>h]]), desc = "Go to the left window" },
            ["j"] = { replaceTermcodes([[<C-\><C-N><C-w>j]]), desc = "Go to the down window" },
            ["k"] = { replaceTermcodes([[<C-\><C-N><C-w>k]]), desc = "Go to the up window" },
            ["l"] = { replaceTermcodes([[<C-\><C-N><C-w>l]]), desc = "Go to the right window" },
        },
    },
}

set_undo_break_points(undo_break_points)
set_mappings(USER.mappings)
