local i = USER.styling.icons
local b = USER.styling.borders.default

require("mason").setup({
    ui = {
        border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l },
        icons = {
            package_installed = i.done[1],
            package_pending = i.pending[1],
            package_uninstalled = i.delete[1],
        },
        keymaps = {
            -- Keymap to expand a package
            toggle_package_expand = "<CR>",
            -- Keymap to install the package under the current cursor position
            install_package = "i",
            -- Keymap to reinstall/update the package under the current cursor position
            update_package = "u",
            -- Keymap to check for new version for the package under the current cursor position
            check_package_version = "c",
            -- Keymap to update all installed packages
            update_all_packages = "U",
            -- Keymap to check which installed packages are outdated
            check_outdated_packages = "C",
            -- Keymap to uninstall a package
            uninstall_package = "D",
            -- Keymap to cancel a package installation
            cancel_installation = "<C-c>",
            -- Keymap to apply language filter
            apply_language_filter = "<C-f>",
        },
    },
    install_root_dir = vim.fn.stdpath("data") .. "/mason"
})
