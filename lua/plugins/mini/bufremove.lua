local M = {}

local function setup(bufremove)
    bufremove.setup()
end

function M.load()
    local loaded, bufremove = pcall(require, "mini.bufremove")
    if not loaded then
        USER.loading_error_msg("mini.bufremove")
        return
    end

    setup(bufremove)
end

return M
