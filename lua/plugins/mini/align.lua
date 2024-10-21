local M = {}

function M.load()
    local loaded, align = pcall(require, "mini.align")
    if not loaded then
        USER.loading_error_msg("mini.align")
        return
    end

    align.setup()
end

return M
