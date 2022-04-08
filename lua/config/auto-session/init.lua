-- local function restore_nvim_tree()
--     require("nvim-tree").change_dir(vim.fn.getcwd())
--     require("nvim-tree.lib").refresh_tree()
--     -- vim.cmd([[NvimTreeToggle]])
-- end

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
    pre_save_cmds = { "NvimTreeClose", "AerialClose", "UndotreeShow", "UndotreeHide" },
    -- post_restore_cmds = { restore_nvim_tree },
})
