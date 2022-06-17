local lsp_status = require("lsp-status")
local lspkind_symbols = require("config.lsp.lspkind").symbols
local i = require("styling").icons
local M = {}

M.select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
        local value_range = {
            ["start"] = {
                character = 0,
                line = vim.fn.byte2line(symbol.valueRange[1]),
            },
            ["end"] = {
                character = 0,
                line = vim.fn.byte2line(symbol.valueRange[2]),
            },
        }

        return require("lsp-status.util").in_range(cursor_pos, value_range)
    end
end

M.config = function()
    lsp_status.config({
        kind_labels = lspkind_symbols,
        current_function = false,
        show_filename = false,
        diagnostics = true,
        indicator_separator = " ",
        component_separator = " ",
        indicator_errors = i.error[1],
        indicator_warnings = i.warn[1],
        indicator_info = i.info[1],
        indicator_hint = i.hint[1],
        indicator_ok = i.misc[5],
        spinner_frames = i.loading.circle,
        status_symbol = "LSP",
        select_symbol = M.select_symbol,
        update_interval = 100
    })

    lsp_status.register_progress()
end

return M
