require("auto-session").setup({
    auto_session_allowed_dirs = {
        "~/Develop/cs50g/",
        "~/Develop/styling/",
        "~/Develop/dotfiles/gnome/",
        "~/Develop/dotfiles/master/",
        "~/Develop/cs50g/",
        "~/Develop/cs50g-project7-pokemon/",
        "~/Develop/cs50g-project8-helicopter/",
        "~/.config/nvim/",
    },
    pre_save_cmds = {
        "NvimTreeClose",
        "AerialClose",
        "UndotreeShow",
        "UndotreeHide",
        "TroubleClose",
        "SatelliteDisable"
    },
})
