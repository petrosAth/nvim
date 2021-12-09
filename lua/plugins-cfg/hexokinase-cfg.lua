local M = {}
local g = vim.g

function M.setup()
    g.Hexokinase_highlighters = {
        -- "virtual"
        -- "sign_column"
        -- "background"
        "backgroundfull"
        -- "foreground"
        -- "foregroundfull"
    }
    g.Hexokinase_optInPatterns = {
        "full_hex",
        "triple_hex",
        "rgb",
        "rgba",
        "hsl",
        "hsla",
        "colour_names"
    }
    g.Hexokinase_ftEnabled = {
        "css",
        "html",
    }
-- g.Hexokinase_refreshEvents = { "BufRead", "BufWrite" }
end

-- minimap mappings
function M.config()
    local map = vim.api.nvim_set_keymap
    local ns_opts = { noremap = true, silent = true }

    map("n", "<Leader>c", "<cmd>HexokinaseToggle<CR>", ns_opts)
end

return M
