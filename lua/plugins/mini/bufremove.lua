local M = {}

function M.load()
    local loaded, bufremove = pcall(require, "mini.bufremove")
    if not loaded then
        USER.loading_error_msg("mini.bufremove")
        return
    end

    bufremove.setup()
end

return M
