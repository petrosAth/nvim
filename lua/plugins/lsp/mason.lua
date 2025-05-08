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
        },
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
