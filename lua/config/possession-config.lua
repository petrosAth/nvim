local M = {}

function M.setup()
    local loaded, possession = pcall(require, "possession")
    if not loaded then
        USER.loading_error_msg("possession.nvim")
        return
    end

    require("possession").setup({
        session_dir = USER.data_path .. "/sessions/",
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
                local diff = false
                local wins = vim.api.nvim_list_wins()

                for _, win_nr in ipairs(wins) do
                    if vim.api.nvim_win_get_option(win_nr, "diff") then
                        diff = true
                    end
                end

                if diff then
                    vim.cmd.tabdo("DiffviewClose")
                end

                return {}
            end,
            after_save = function(name, user_data, aborted) end,
            before_load = function(name, user_data)
                return user_data
            end,
            after_load = function(name, user_data) end,
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
                        "Trouble",
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
                force = false, -- or fun(buf): boolean
            },
            nvim_tree = false,
            tabby = true,
            delete_buffers = true,
        },
    })
end

return M
