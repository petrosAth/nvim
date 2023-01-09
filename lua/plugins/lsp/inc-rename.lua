local M ={}

function M.setup()
    local loaded, inc_rename = pcall(require, "inc_rename")
    if not loaded then
        USER.loading_error_msg("inc-rename.nvim")
        return
    end

    inc_rename.setup()
end

return M
