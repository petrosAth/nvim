local M = {}

function M.setup(icons, border)
    local loaded, lsp_signature = pcall(require, "lsp_signature")
    if not loaded then
        vim.notify("lsp_signature.nvim", "ERROR", { title = "Loading failed" })
        return
    end

    local config = {
        floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
        hint_enable = false, -- virtual hint enable
        hint_prefix = icons.lsp.hint[1] .. " ",
        handler_opts = {
            border = border,
        },

        transpancy = USER.styling.variables.transparency, -- disabled by default, allow floating win transparent value 1~100
        toggle_key = "<M-s>", -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

        select_signature_key = "<M-S>", -- cycle to next signature, e.g. '<M-n>' function overloading
    }

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local bufnr = args.buf
            lsp_signature.on_attach(config, bufnr)
        end,
    })
end

return M
