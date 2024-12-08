local M = {}

local function setup(lsp_signature, icons, border)
    local config = {
        floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
        hint_enable = false, -- virtual hint enable
        hint_prefix = string.format("%s ", icons.lsp.hint[1]),
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

function M.init(icons, border)
    local loaded, lsp_signature = pcall(require, "lsp_signature")
    if not loaded then
        USER.loading_error_msg("lsp_signature.nvim")
        return
    end

    setup(lsp_signature, icons, border)
end

return M
