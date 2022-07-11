require("auto-session").setup({
    auto_session_allowed_dirs = {
        "~/Develop/dotfiles/gnome/",
        "~/Develop/dotfiles/master/",
        "~/.config/nvim/",
    },
    pre_save_cmds = {
        "NeoTreeShow",
        "NeoTreeClose",
        "AerialClose",
        "UndotreeShow",
        "UndotreeHide",
        "TroubleClose",
        "SatelliteDisable"
    },
})
