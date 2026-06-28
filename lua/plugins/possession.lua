local function wipe_codediff_buffers()
    -- codediff's virtual (codediff://) and panel buffers cannot be reconstructed from a
    -- session and reload as a broken half-diff. codediff does NOT use Neovim's native
    -- `&diff`, so detect by buffer name / filetype instead of the diff window option.
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) then
            local bname = vim.api.nvim_buf_get_name(buf)
            local ft = vim.bo[buf].filetype
            if
                bname:match("^codediff://")
                or bname:match("^CodeDiff ")
                or ft == "codediff-explorer"
                or ft == "codediff-history"
            then
                pcall(vim.api.nvim_buf_delete, buf, { force = true })
            end
        end
    end
end

local function wipe_fzf_terminal_buffers()
    -- fzf-lua runs `fzf` in an *unlisted* `term://…:/bin/sh` buffer and only hides (not wipes)
    -- it on close, leaving it to linger. Real `:terminal` buffers are listed and are left alone.
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" and not vim.bo[buf].buflisted then
            pcall(vim.api.nvim_buf_delete, buf, { force = true })
        end
    end
end

local function setup(possession)
    possession.setup({
        session_dir = string.format("%s/sessions/", vim.fn.stdpath("data")),
        silent = false,
        load_silent = true,
        debug = false,
        prompt_no_cr = true,
        autosave = {
            current = true, -- or fun(name): boolean
            tmp = true, -- or fun(): boolean
            tmp_name = "Last closed",
            on_load = true,
            on_quit = true,
        },
        commands = {
            save = "PossessionSave",
            load = "PossessionLoad",
            close = "PossessionClose",
            delete = "PossessionDelete",
            show = "PossessionShow",
            list = "PossessionList",
            migrate = "PossessionMigrate",
        },
        hooks = {
            before_save = function(name)
                wipe_codediff_buffers()
                wipe_fzf_terminal_buffers()

                return {}
            end,
            after_save = function(name, user_data, aborted) end,
            before_load = function(name, user_data) return user_data end,
            after_load = function(name, user_data)
                wipe_codediff_buffers()
                vim.cmd.nohlsearch()
            end,
        },
        plugins = {
            close_windows = {
                hooks = { "before_save", "before_load" },
                preserve_layout = false, -- or fun(win): boolean
                match = {
                    floating = true,
                    buftype = {},
                    filetype = {
                        "aerial",
                        "Codewindow",
                        "neo-tree",
                        "Outline",
                        "qf",
                        "trouble",
                        "undotree",
                    },
                    custom = false, -- or fun(win): boolean
                },
            },
            delete_hidden_buffers = {
                hooks = {
                    "before_load",
                    vim.o.sessionoptions:match("buffer") and "before_save",
                },
                -- fzf-lua leaves hidden term:// buffers; force=false emits E89 on terminal bufs.
                -- Force only terminals so the unsaved-changes guard still protects file buffers.
                force = function(buf) return vim.bo[buf].buftype == "terminal" end,
            },
            nvim_tree = false,
            tabby = true,
            delete_buffers = true,
        },
    })
end

return {
    {
        -- Flexible session management for Neovim.
        "jedrzejboczar/possession.nvim",
        config = function()
            local loaded, possession = pcall(require, "possession")
            if not loaded then
                USER.loading_error_msg("possession.nvim")
                return
            end

            setup(possession)
        end,
    },
}
