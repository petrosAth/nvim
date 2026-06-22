local M = {}

local function setup(tiny_code_action, icons, borders)
    local b = borders
    local bn = USER.styling.borders.none

    tiny_code_action.setup({
        backend = "vim",

        -- options related to telescope.nvim
        picker = {
            "telescope",
            opts = {
                sorting_strategy = "ascending",
                layout_strategy = "vertical",
                prompt_prefix = string.format(" %s  ", icons.lsp.action[1]),
                layout_config = {
                    mirror = false,
                    prompt_position = "top",
                    width = { 0.8, max = 120 },
                    height = { 0.8, max = 40 },
                    preview_cutoff = 20,
                    preview_height = function(_, _, max_lines) return max_lines - 15 end,
                },
                borderchars = {
                    --  prompt  = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   }
                    prompt = { b.t, b.r, b.b, b.l, b.tl, b.tr, b.br, b.bl },
                    --  results = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   },
                    results = { bn.t, b.r, b.b, b.l, b.l, b.r, b.br, b.bl },
                    --  preview = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   },
                    preview = { b.t, b.r, bn.b, b.l, b.tl, b.tr, b.r, b.l },
                },
            },
        },
    })
end

function M.init(icons, borders)
    local loaded, tiny_code_action = pcall(require, "tiny-code-action")
    if not loaded then
        USER.loading_error_msg("tiny-code-action.nvim")
        return
    end

    setup(tiny_code_action, icons, borders)
end

return M
