local function setup(code_preview)
    code_preview.setup({
        diff = {
            layout = "inline", -- "tab" | "vsplit" | "inline"
        },
    })
end

return {
    {
        -- A Neovim plugin that shows a live diff preview of AI coding agent's file edits before you accept or reject them.
        "Cannon07/code-preview.nvim",
        event = "VeryLazy",
        config = function()
            local loaded, code_preview = pcall(require, "code-preview")
            if not loaded then
                USER.loading_error_msg("code-preview.nvim")
                return
            end

            setup(code_preview)
        end,
    },
}
