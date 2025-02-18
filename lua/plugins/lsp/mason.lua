local M = {}

local function setup(mason, icons, border)
    mason.setup({
        ui = {
            border = border,
            backdrop = USER.styling.variables.backdrop,
            width = 0.7,
            height = 0.825,
            icons = {
                package_installed = string.format("%s ", icons.done[1]),
                package_pending = string.format("%s ", icons.pending[1]),
                package_uninstalled = string.format("%s ", icons.pending[1]),
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
        install_root_dir = string.format("%s/mason", vim.fn.stdpath("data")),
    })
end

function M.setup(icons, border)
    local loaded, mason = pcall(require, "mason")
    if not loaded then
        USER.loading_error_msg("mason.nvim")
        return
    end

    setup(mason, icons, border)
end

return M
