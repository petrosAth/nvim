require("auto-session").setup({
    auto_session_suppress_dirs = { "~/*" },
    auto_session_allowed_dirs = {
        "~/Develop/dotfiles/gnome",
        "~/Develop/dotfiles/master",
        "~/.config/nvim",
    },
    pre_save_cmds = {
        "NeoTreeClose",
        "AerialClose",
        "UndotreeHide",
        "TroubleClose",
    },
})
