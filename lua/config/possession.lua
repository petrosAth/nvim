require("possession").setup({
    session_dir = PA.data_path .. "/sessions/",
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
            vim.cmd.DiffviewClose()
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
        nvim_tree = true,
        tabby = true,
        delete_buffers = false,
    },
})
