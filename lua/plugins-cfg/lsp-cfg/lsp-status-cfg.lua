local lsp_status = require("lsp-status")
local lspkind_symbols = require("plugins-cfg.lsp-cfg.lspkind-cfg").symbols
local ci = require("cosmetics").icon
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
        diagnostics = false,
        indicator_separator = " ",
        component_separator = " ",
        indicator_errors = ci.error[1],
        indicator_warnings = ci.warn[1],
        indicator_info = ci.info[1],
        indicator_hint = ci.hint[1],
        indicator_ok = ci.misc[5],
        spinner_frames = ci.loading,
        status_symbol = "LSP",
        select_symbol = M.select_symbol,
        update_interval = 100
    })

    lsp_status.register_progress()
end

return M
