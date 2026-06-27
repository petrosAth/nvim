local M = {}

local function setup(tiny_code_action, icons, borders)
    local b = borders

    tiny_code_action.setup({
        backend = "vim",

        -- options related to fzf-lua
        picker = {
            "fzf-lua",
            opts = {
                winopts = {
                    title = string.format(" %s Code actions ", icons.lsp.action[1]),
                    title_pos = "center",
                    height = 0.8,
                    width = 0.8,
                    border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l },
                    preview = {
                        layout = "vertical",
                        vertical = "down:60%",
                    },
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
