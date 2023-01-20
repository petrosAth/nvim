local M = {}

local function install()
    local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazy_path) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazy_path,
        })
    end
    vim.opt.rtp:prepend(lazy_path)
end

local function setup()
    local icons = USER.styling.icons
    local borders = USER.styling.borders.default

    require("lazy").setup({
        root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
        -- leave nil when passing the spec as the first argument to setup()
        spec = {
            { import = "plugins" },
        },
        dev = {
            -- directory where you store your local plugin projects
            path = "~/projects",
            ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
            patterns = {}, -- For example {"folke"}
        },
        install = {
            -- install missing plugins on startup. This doesn't increase startup time.
            missing = true,
            -- try to load one of these colorschemes when starting an installation during startup
            colorscheme = { USER.theme, "habamax" },
        },
        ui = {
            -- a number <1 is a percentage., >1 is a fixed size
            size = { width = 0.8, height = 0.8 },
            -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
            border = {
                { borders.tl, "FloatBorder" },
                { borders.t, "FloatBorder" },
                { borders.tr, "FloatBorder" },
                { borders.r, "FloatBorder" },
                { borders.br, "FloatBorder" },
                { borders.b, "FloatBorder" },
                { borders.bl, "FloatBorder" },
                { borders.l, "FloatBorder" },
            },
            icons = {
                loaded = icons.done[1],
                not_loaded = icons.pending[1],
                cmd = icons.terminal[1],
                config = icons.config[1],
                event = icons.lazy.event,
                ft = icons.file[1],
                init = icons.config[1],
                keys = icons.key[1],
                plugin = icons.plugin[1],
                runtime = icons.vim[1],
                source = icons.source[1],
                start = icons.lazy.start,
                task = icons.task[1],
                lazy = icons.lazy.lazy,
                list = {
                    icons.arrow.solid.r,
                    icons.arrow.hollow.r,
                    icons.lazy.list.tree,
                    icons.lazy.list.dash,
                },
            },
            -- leave nil, to automatically select a browser depending on your OS.
            -- If you want to use a specific browser, you can define it here
            browser = nil, ---@type string?
            throttle = 20, -- how frequently should the ui process render events
            custom_keys = {
                ["<localleader>l"] = false,
                ["<localleader>t"] = false,
            },
        },
        diff = {
            -- diff command <d> can be one of:
            --  browser: opens the github compare view. Note that this is always mapped to <K> as well,
            --   so you can have a different command for diff <d>
            --  git: will run git diff and open a buffer with filetype git
            --  terminal_git: will open a pseudo terminal with git diff
            --  diffview.nvim: will open Diffview to show the diff
            cmd = "browser",
        },
        checker = {
            -- automatically check for plugin updates
            enabled = true,
            concurrency = nil, ---@type number? set to 1 to check for updates very slowly
            notify = true, -- get a notification when new updates are found
            frequency = 3600, -- check for updates every hour
        },
    })
end

function M.init()
    install()
    setup()
end

return M
