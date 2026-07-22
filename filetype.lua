vim.filetype.add({
    filename = {
        [".gitignore.django"] = "gitignore",
        [".secrets"] = "bash",
        ["theme.conf"] = "sh",
    },
    extension = {
        mdc = "markdown",
    },
    pattern = {
        [".*%.tmux%.conf"] = { "tmux", { priority = 1 } },
        [".*%.tmux%.conf%..*"] = { "tmux", { priority = 1 } },
    },
})
