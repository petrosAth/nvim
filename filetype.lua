vim.filetype.add({
    filename = {
        [".gitignore.django"] = "gitignore",
        [".secrets"] = "bash",
        ["tmux.conf"] = "bash",
        [".tmux.conf"] = "bash",
    },
    extension = {
        mdc = "markdown",
    },
    pattern = {
        -- Neovim's builtin tmux patterns (`filetype.lua`) match `tmux*.conf` and
        -- `tmux*.conf.*`; overriding them here (no `^`/`$`: vim.filetype.add anchors
        -- pattern keys automatically) covers variants like `tmux.conf.local` as well
        -- as arbitrarily prefixed names like `bindings.tmux.conf` (the tmux plugin
        -- convention of `<name>.tmux.conf`).
        [".*tmux.*%.conf"] = "bash",
        [".*tmux.*%.conf%..*"] = { "bash", { priority = 1 } },
    },
})
