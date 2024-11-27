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

    return string.format([[<CMD>lua %s.%s(%s)<CR>]], plugin, modules, opts)
end

local function telescope_picker(picker)
    local config_path = [[require("plugins.telescope.pickers")]]
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
        ["*"] = { "*<CMD>lua require('hlslens').start()<CR>", desc = "Search word under cursor" }, -- hlslens
        ["#"] = { "#<CMD>lua require('hlslens').start()<CR>", desc = "Search word under cursor backward" }, -- hlslens
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
            ["r"] = { function() require("illuminate").goto_next_reference("wrap") end, desc = "Next Reference" }, -- snacks.nvim
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
            ["r"] = { function() require("illuminate").goto_prev_reference("wrap") end, desc = "Previous Reference" }, -- snacks.nvim
            ["t"] = { function() vim.cmd.tabprevious() end, desc = "Previous tab" }, -- Assigned by Hydra.nvim
        },
        ["<F1>"] = { group = "Toggle" },
        ["<F2>"] = { [[:%s/\<<C-r><C-w>\>/]], desc = "Replace word under cursor", silent = false },
        ["g"] = {
            ["*"] = { "*<CMD>lua require('hlslens').start()<CR>", desc = "Search word under cursor" }, -- hlslens
            ["#"] = { "#<CMD>lua require('hlslens').start()<CR>", desc = "Search word under cursor backward" }, -- hlslens
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
            "<CMD>execute('normal! ' . v:count1 . 'n')<CR><CMD>lua MiniAnimate.execute_after('scroll', 'normal! zvzz'); require('hlslens').start()<CR>",
            desc = "Repeat the latest '/' or '?'",
        }, -- hlslens
        ["N"] = {
            "<CMD>execute('normal! ' . v:count1 . 'N')<CR><CMD>lua MiniAnimate.execute_after('scroll', 'normal! zvzz'); require('hlslens').start()<CR>",
            desc = "Repeat the latest '/' or '?' backwards",
        }, -- hlslens
        ["z"] = {
            ["h"] = { desc = "Scroll the screen to the left" }, -- Assigned using Hydra.nvim
            ["l"] = { desc = "Scroll the screen to the right" }, -- Assigned using Hydra.nvim
        },
        ["<C-s>"] = { function() require("flash").jump() end, desc = "Flash" }, -- flash.nvim
        ["<M-J>"] = { ":m .+1<CR>==", desc = "Move line up" },
        ["<M-K>"] = { ":m .-2<CR>==", desc = "Move line down" },
        ["<M-X>"] = { ":x<CR>", desc = "Save and quit only if there are changes in the file" },
        ["<Esc>"] = {
            [[:noh<CR>:lua require("snacks").notifier.hide()<CR>:lua require("luasnip").unlink_current()<CR><Esc>]],
            desc = "Clear search highlight",
        },
        ["<Leader>"] = {
            ["?"] = { function() require("which-key").show() end, desc = "Buffer Local Keymaps (which-key)" },
            ["b"] = {
                group = "Buffer manipulation",
                ["d"] = { function() vim.cmd.lua("MiniBufremove.delete()") end, desc = "Delete buffer" }, -- mini.bufremove
            },
            ["c"] = {
                group = "Color tools",
                ["n"] = { "<CMD>CccConvert<CR>", desc = "Convert color to the next color format" }, -- ccc.nvim
                ["c"] = { "<CMD>CccHighlighterToggle<CR>", desc = "Color codes preview" }, -- ccc.nvim
                ["p"] = { "<CMD>CccPick<CR>", desc = "Color picker" }, -- ccc.nvim
            },
            ["i"] = { "<CMD>lua vim.show_pos()<CR>", desc = "Show all the items at a given buffer position" },
            ["l"] = {
                group = "LSP alternative",
                ["a"] = { "<CMD>lua vim.lsp.buf.code_action()<CR>", desc = "Code actions" }, -- nvim-lspconfig
                ["d"] = {
                    group = "Definitions",
                    ["t"] = { telescope_picker("lsp_definitions"), desc = "Telescope" }, -- nvim-lspconfig -- telescope.nvim
                },
                ["i"] = {
                    group = "Implementations",
                    ["t"] = { telescope_picker("implementations"), desc = "Telescope" }, -- nvim-lspconfig -- telescope.nvim
                    ["q"] = { "<CMD>Trouble lsp_implementations<CR>", desc = "Trouble" }, -- nvim-lspconfig -- trouble.nvim
                },
                ["q"] = { "<CMD>Trouble lsp toggle focus=false win.position=right<CR>", desc = "Trouble" }, -- nvim-lspconfig -- trouble.nvim
                ["r"] = {
                    group = "References",
                    ["t"] = { telescope_picker("lsp_references"), desc = "Telescope" }, -- nvim-lspconfig -- telescope.nvim
                },
                ["t"] = {
                    group = "Type Definitions",
                    ["t"] = { telescope_picker("lsp_type_definitions"), desc = "Telescope" }, -- nvim-lspconfig -- telescope.nvim
                },
            },
            ["q"] = {
                function()
                    vim.cmd.lua("MiniBufremove.delete()")
                    vim.cmd.quit()
                end,
                desc = "Delete buffer and close window",
            }, -- mini.bufremove
            ["p"] = {
                group = "Project",
                ["."] = { "<CMD>PossessionLoad<CR>", desc = "Load last closed" }, -- possession.nvim
                ["c"] = {
                    group = "Create local config files",
                    ["c"] = { "<CMD>ProjectCreatePalette<CR>", desc = "Create palette" }, -- ccc.nvim
                    ["s"] = { "<CMD>ProjectCreateSession<CR>", desc = "Create session" }, -- possession.nvim
                    ["p"] = { "<CMD>ProjectCreatePrettierConfig<CR>", desc = "Create prettier config" },
                },
                ["C"] = { "<CMD>ProjectCreateConfig<CR>", desc = "Create local config file" }, -- nvim-config-local
                ["D"] = { "<CMD>PossessionDelete<CR>", desc = "Delete currently loaded session" }, -- possession.nvim
                ["L"] = { "<CMD>ProjectLoadSession<CR>", desc = "Load local session" }, -- possession.nvim
                ["S"] = { ":PossessionSave ", desc = "Save session", silent = false }, -- possession.nvim
            },
            ["t"] = {
                group = "Tab",
                ["}"] = { ":+tabmove<CR>", desc = "Move tab right" },
                ["{"] = { ":-tabmove<CR>", desc = "Move tab left" },
                ["a"] = { "<CMD>tabnew<CR>", desc = "Create new tab" },
                ["c"] = { "<CMD>tabclose<CR>", desc = "Close tab" },
                ["R"] = { ":TabRename ", desc = "Rename tab", silent = false }, -- tabby.nvim
            },
            ["u"] = {
                group = "Utilities",
                ["s"] = {
                    group = "Status",
                    ["l"] = { "<CMD>checkhealth lspconfig<CR>", desc = "LSP info" }, -- lsp-config
                    ["m"] = { "<CMD>Mason<CR>", desc = "Mason status" }, -- mason.nvim
                    ["n"] = { "<CMD>NullLsInfo<CR>", desc = "Null-ls info" }, -- null-ls.nvim
                    ["p"] = { "<CMD>Lazy<CR>", desc = "Plugins status" }, -- lazy.nvim
                },
                ["u"] = {
                    group = "Update",
                    ["l"] = { "<CMD>Mason<CR><CMD>MasonToolsUpdate<CR>", desc = "Update LSP packages" }, -- mason-tool-installer.nvim
                    ["P"] = { "<CMD>Lazy update<CR>", desc = "Update plugins" }, -- lazy.nvim
                    ["p"] = { "<CMD>Lazy check<CR>", desc = "Check for plugins updates" }, -- lazy.nvim
                },
            },
        },
        ["<Space>"] = {
            ["?"] = { "<CMD>WhichKey<CR>", desc = "Show available hotkeys" }, -- which-key
            ["."] = { "<CMD>Telescope resume<CR>", desc = "Reopen Telescope" }, -- telescope.nvim
            ["b"] = { "<CMD>Telescope buffers<CR>", desc = "Buffer list" }, -- telescope.nvim
            ["d"] = {
                group = "Diffview",
                ["q"] = { "<CMD>DiffviewClose<CR>", desc = "Quit" }, -- diffview
                ["e"] = { "<CMD>DiffviewToggleFiles<CR>", desc = "Toggle file tree" }, -- diffview
                ["h"] = { "<CMD>DiffviewFileHistory %<CR>", desc = "Show history log for current file" }, -- diffview
                ["H"] = { "<CMD>DiffviewFileHistory<CR>", desc = "Show history log" }, -- diffview
                ["o"] = { "<CMD>DiffviewOpen<CR>", desc = "Open" }, -- diffview
                ["R"] = { "<CMD>DiffviewRefresh<CR>", desc = "Refresh stats and entries" }, -- diffview
            },
            ["D"] = {
                group = "Diff mode",
                ["p"] = {
                    ":diffpatch ",
                    desc = "Patch the buffer with the requested file on a new buffer",
                    silent = false,
                },
                ["q"] = { "<CMD>diffoff<CR>", desc = "Revert and quit" },
                ["R"] = { "<CMD>diffupdate<CR>", desc = "Updated the differences" },
                ["t"] = { "<CMD>diffthis<CR>", desc = "Make the current window part of the diff windows" },
                ["v"] = { ":vertical diffsplit ", desc = "Open the requested file in a split", silent = false },
                ["w"] = { "<CMD>windo diffthis<CR>", desc = "Compare the visible files" },
            },
            ["e"] = {
                group = "File, buffer and git explorer",
                ["b"] = {
                    "<CMD>Neotree buffers left focus reveal toggle<CR>",
                    desc = "Toggle a list of currently open buffers",
                }, -- neo-tree.nvim
                ["B"] = {
                    "<CMD>Neotree buffers current<CR>",
                    desc = "Toggle a list of currently open buffers within the current window",
                }, -- neo-tree.nvim
                ["e"] = { "<CMD>Neotree filesystem left focus reveal toggle<CR>", desc = "Toggle file explorer" }, -- neo-tree.nvim
                ["E"] = {
                    "<CMD>Neotree filesystem current<CR>",
                    desc = "Open file explorer within the current window",
                }, -- neo-tree.nvim
                ["f"] = { "<CMD>Neotree focus<CR>", desc = "Open or focus on file explorer" }, -- neo-tree.nvim
                ["g"] = { "<CMD>Neotree git_status left focus reveal toggle <CR>", desc = "Toggle git status panel" }, -- neo-tree.nvim
                ["o"] = { "<CMD>Neotree document_symbols<CR>", desc = "Toggle document symbols panel" }, -- neo-tree.nvim
            },
            ["g"] = {
                group = "Git",
                ["b"] = {
                    group = "Git blame",
                    ["l"] = { "<CMD>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle line blame" }, -- gitsigns.nvim
                    ["w"] = { "<CMD>lua require('gitsigns').blame_line{full=true}<CR>", desc = "Show blame window" }, -- gitsigns.nvim
                },
                ["c"] = { "<CMD>Telescope git_commits<CR>", desc = "Commits" }, -- telescope.nvim
                ["C"] = { "<CMD>Telescope git_bcommits<CR>", desc = "Buffer commits" }, -- telescope.nvim
                ["g"] = {
                    group = "Git buffer actions",
                    ["a"] = { "<CMD>Gitsigns stage_buffer<CR>", desc = "Stage buffer" }, -- gitsigns.nvim
                    ["r"] = { "<CMD>Gitsigns reset_buffer<CR>", desc = "Reset buffer" }, -- gitsigns.nvim
                    ["u"] = { "<CMD>Gitsigns undo_stage_hunk<CR>", desc = "Undo stage hunk" }, -- gitsigns.nvim
                },
                ["G"] = {
                    group = "Misc",
                    ["b"] = { "<CMD>Telescope git_branches<CR>", desc = "Branches" }, -- telescope.nvim
                    ["S"] = { "<CMD>Telescope git_stash<CR>", desc = "Stash" }, -- telescope.nvim
                },
                ["h"] = {
                    group = "Git hunk actions",
                    ["a"] = { "<CMD>Gitsigns stage_hunk<CR>", desc = "Stage hunk" }, -- gitsigns.nvim
                    ["r"] = { "<CMD>Gitsigns reset_hunk<CR>", desc = "Reset hunk" }, -- gitsigns.nvim
                    ["u"] = { "<CMD>Gitsigns reset_buffer_index<CR>", desc = "Unstage buffer" }, -- gitsigns.nvim
                },
                ["p"] = { "<CMD>Gitsigns preview_hunk_inline<CR>", desc = "Preview hunk" }, -- gitsigns.nvim
                ["s"] = { "<CMD>Telescope git_status<CR>", desc = "Status" }, -- telescope.nvim
                ["v"] = {
                    group = "Diff highlighting",
                    ["l"] = { "<CMD>Gitsigns toggle_linehl<CR>", desc = "Toggle line diff highlighting" }, -- gitsigns.nvim
                    ["n"] = { "<CMD>Gitsigns toggle_numhl<CR>", desc = "Toggle number diff highlighting" }, -- gitsigns.nvim
                    ["w"] = { "<CMD>Gitsigns toggle_word_diff<CR>", desc = "Toggle word diff highlighting" }, -- gitsigns.nvim
                    ["d"] = { "<CMD>Gitsigns toggle_deleted<CR>", desc = "Toggle deleted lines highlighting" }, -- gitsigns.nvim
                },
            },
            ["l"] = {
                group = "LSP",
                ["a"] = { function() require("actions-preview").code_actions() end, desc = "Code actions" }, -- nvim-lspconfig
                ["d"] = { "<CMD>Glance definitions<CR>", desc = "Definitions" }, -- nvim-lspconfig -- glance.nvim
                ["f"] = { function() vim.lsp.buf.format({ async = true }) end, desc = "Format document" }, -- nvim-lspconfig
                ["F"] = { "<CMD>LspToggleAutoFormat<CR>", desc = "Toggle auto formatting" }, -- nvim-lspconfig
                ["h"] = { function() vim.diagnostic.open_float() end, desc = "Line diagnostics" }, -- nvim-lspconfig
                ["i"] = { "<CMD>Glance implementations<CR>", desc = "Implementations" }, -- nvim-lspconfig -- glance.nvim
                ["K"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol" }, -- nvim-lspconfig
                ["q"] = { "<CMD>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Document diagnostics" }, -- nvim-lspconfig -- trouble.nvim
                ["Q"] = { "<CMD>Trouble diagnostics toggle<CR>", desc = "Workspace diagnostics" }, -- nvim-lspconfig -- trouble.nvim
                ["r"] = { "<CMD>Glance references<CR>", desc = "References" }, -- nvim-lspconfig -- glance.nvim
                ["R"] = { ":IncRename ", desc = "Rename symbol", silent = false }, -- nvim-lspconfig -- inc-rename
                ["s"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature help" }, -- nvim-lspconfig
                ["t"] = { "<CMD>Glance type_definitions<CR>", desc = "Type Definitions" }, -- nvim-lspconfig -- glance.nvim
            },
            ["m"] = {
                group = "Minimap",
                ["m"] = { "<CMD>lua require('codewindow').toggle_minimap()<CR>", desc = "Toggle minimap" }, -- codewindow.nvim
                ["o"] = { "<CMD>lua require('codewindow').open_minimap()<CR>", desc = "Open minimap" }, -- codewindow.nvim
                ["c"] = { "<CMD>lua require('codewindow').close_minimap()<CR>", desc = "Close minimap" }, -- codewindow.nvim
                ["f"] = { "<CMD>lua require('codewindow').toggle_focus()<CR>", desc = "Focus/unfocus minimap" }, -- codewindow.nvim
            },
            ["o"] = { "<CMD>Outline<CR>", desc = "Toggle Code outline" }, -- outline.nvim
            ["O"] = { "<CMD>Outline!<CR>", desc = "Toggle Code outline without focusing" }, -- outline.nvim
            ["q"] = {
                group = "Trouble",
                ["c"] = { "<CMD>lua require('trouble').close()<CR>", desc = "Close" }, -- trouble.nvim
                ["f"] = { "<CMD>Trouble qflist toggle<CR>", desc = "Quickfix" }, -- trouble.nvim
                ["l"] = { "<CMD>Trouble loclist toggle<CR>", desc = "Loclist" }, -- trouble.nvim
                ["q"] = { "<CMD>lua require('trouble').focus()<CR>", desc = "Focus" }, -- trouble.nvim
                ["R"] = { "<CMD>lua require('trouble').refresh()<CR>", desc = "Refresh" }, -- trouble.nvim
            },
            ["r"] = { "<CMD>Telescope registers<CR>", desc = "Registers" },
            ["s"] = {
                group = "Search",
                ["b"] = { telescope_picker("file_browser"), desc = "File Browser" }, -- telescope.nvim
                ["d"] = {
                    group = "Search in Directory",
                    ["g"] = { "<CMD>Telescope dir live_grep<CR>", desc = "ripGREP" }, -- telescope.nvim -- dir-telescope.nvim
                    ["f"] = { "<CMD>Telescope dir find_files<CR>", desc = "File search" }, -- telescope.nvim -- dir-telescope.nvim
                },
                ["f"] = { "<CMD>Telescope find_files<CR>", desc = "File search" }, -- telescope.nvim
                ["g"] = { "<CMD>Telescope live_grep<CR>", desc = "ripGREP" }, -- telescope.nvim
                ["H"] = { "<CMD>Telescope highlights<CR>", desc = "Highlight groups" }, -- telescope.nvim
                ["h"] = { "<CMD>Telescope help_tags<CR>", desc = "Vim help" }, -- telescope.nvim
                ["n"] = { function() require("snacks").notifier.show_history() end, desc = "Notify history" }, -- snacks.nvim
                ["o"] = { "<CMD>Telescope vim_options<CR>", desc = "Vim options" }, -- telescope.nvim
                ["s"] = { telescope_picker("possession"), desc = "Search sessions" }, -- telescope.nvim -- possession.nvim
                ["S"] = { telescope_picker("luasnip"), desc = "List available snippets" }, -- telescope-luasnip.nvim
                ["T"] = { "<CMD>TodoTelescope<CR>", desc = "Show TODO comments" }, -- todo-comments
                ["t"] = {
                    group = "Telescope",
                    ["b"] = { "<CMD>Telescope builtin<CR>", desc = "Telescope builtin" }, -- telescope.nvim
                    ["c"] = { "<CMD>Telescope command_history<CR>", desc = "Command history" }, -- telescope.nvim
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

                ["T"] = { function() require("yeet").toggle_post_write() end, desc = "Toggle execution on write" }, -- yeet.nvim
            },
            ["u"] = { "<CMD>Neotree close<CR><CMD>UndotreeToggle<CR>", desc = "Toggle undo tree" }, -- undotree
            ["<Space>"] = {
                group = "Launch",
                ["e"] = { "<CMD>LaunchDir dolphin<CR>", desc = "Open cwd in system file browser" },
                ["l"] = { "<CMD>LaunchURL firefox --new-tab<CR>", desc = "Open URL under cursor in browser" },
                ["t"] = { "<CMD>terminal<CR>i", desc = "Start a terminal session within Neovim" },
                ["g"] = { function() require("snacks").gitbrowse() end, desc = "Git Browse" }, -- snacks.nvim
            },
        },
    },
    -- Visual and select mode mappings
    ["v"] = {
        ["<F2>"] = { [[y:%s/\V<C-r>"/]], desc = "Replace word under cursor", silent = false },
        ["<F3>"] = { "<CMD>set relativenumber!<CR>", desc = "Toggle relative number" },
        ["<M-J>"] = { ":m '>+1<CR>gv-gv", desc = "Move line up" },
        ["<M-K>"] = { ":m '<-2<CR>gv-gv", desc = "Move line up" },
        ["<Space>"] = {
            ["p"] = { '"_dP', desc = "Keep yanked text after paste" },
        },
    },
    -- Select mode mappings
    ["s"] = {
        ["<BS>"] = { [[<BS>i]], desc = "Delete selection" }, -- Helpful when editing snippet placeholders
        ["<C-h>"] = { [[<C-h>i]], desc = "Delete selection" }, -- Helpful when editing snippet placeholders
    },
    -- Visual mode mappings
    ["x"] = {
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
        ["<C-s>"] = { function() require("flash").jump() end, desc = "Flash" }, -- flash.nvim
        ["<Space>"] = {
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
    -- Insert mode mappints
    ["i"] = {
        ["<F1>"] = { "<CMD>setlocal spell!<CR>", desc = "Toggle spelling" },
        ["<F3>"] = { "<CMD>set cursorcolumn!<CR>", desc = "Toggle cursorcolumn" },
        ["<M-p>"] = { [[<C-r><C-o>+]], desc = "Paste and stay in insert mode" },
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
