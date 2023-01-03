local M = {}

function M.setup(icons)
    local loaded, nvim_lightbulb = pcall(require, "nvim-lightbulb")
    if not loaded then
        vim.notify("nvim-lightbulb", "ERROR", { title = "Loading failed" })
        return
    end

    vim.fn.sign_define("LightBulbSign", {
        text = icons.lsp.action[1],
        texthl = "DiagnosticWarn",
    })

    nvim_lightbulb.setup({
        -- LSP client names to ignore
        -- Example: {"sumneko_lua", "null-ls"}
        ignore = {},
        sign = {
            enabled = true,
            -- Priority of the gutter sign
            priority = 10,
        },
        autocmd = {
            enabled = true,
            pattern = { "*" },
            events = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
        },
    })
end

return M
