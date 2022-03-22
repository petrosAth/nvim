-- local function restore_nvim_tree()
--     require("nvim-tree").change_dir(vim.fn.getcwd())
--     require("nvim-tree.lib").refresh_tree()
--     -- vim.cmd([[NvimTreeToggle]])
-- end

require("auto-session").setup({
    auto_session_suppress_dirs = { "~/", "~/.config/", "~/Develop" },
    pre_save_cmds = { "NvimTreeClose", "AerialClose", "UndotreeShow", "UndotreeHide" },
    -- post_restore_cmds = { restore_nvim_tree },
})
