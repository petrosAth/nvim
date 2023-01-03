local M ={}

function M.setup()
    local loaded, inc_rename = pcall(require, "inc_rename")
    if not loaded then
        vim.notify("inc-rename.nvim", "ERROR", { title = "Loading failed" })
        return
    end

    inc_rename.setup()
end

return M
