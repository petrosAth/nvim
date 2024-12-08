local M = {}

local function setup(actions_preview, icons, borders)
    local b = borders
    local bn = USER.styling.borders.none

    actions_preview.setup({
        -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
        diff = {
            ctxlen = 4,
        },

        -- options related to telescope.nvim
        telescope = {
            sorting_strategy = "ascending",
            layout_strategy = "vertical",
            -- show_line = false,
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
    })
end

function M.init(icons, borders)
    local loaded, actions_preview = pcall(require, "actions-preview")
    if not loaded then
        USER.loading_error_msg("actions-preview.nvim")
        return
    end

    setup(actions_preview, icons, borders)
end

return M
