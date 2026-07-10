local function setup(fzf)
    local i = USER.styling.icons
    local b = USER.styling.borders.default
    local actions = fzf.actions

    -- nvim_open_win border passthrough: { tl, t, tr, r, br, b, bl, l }
    local border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l }

    fzf.setup({
        winopts = function()
            return {
                width = USER.editor_scale("cols", 0.85, 50, 300),
                height = USER.editor_scale("lines", 0.85, 30, 100),
                row = 0.5,
                col = 0.5,
                border = border,
                backdrop = 100,
                preview = {
                    border = border,
                    layout = "flex",
                    -- Switch to a vertical preview on narrow windows, horizontal otherwise.
                    flip_columns = 120,
                    horizontal = "right:60%",
                    vertical = "down:45%",
                    scrollbar = "float",
                    title = true,
                    title_pos = "center",
                    delay = 20,
                },
            }
        end,
        fzf_opts = {
            ["--pointer"] = i.point[1],
            ["--marker"] = i.select[1],
        },
        keymap = {
            builtin = {
                true, -- inherit defaults
                ["<M-p>"] = "toggle-preview",
                ["<C-d>"] = "preview-page-down",
                ["<C-u>"] = "preview-page-up",
            },
            fzf = {
                true, -- inherit defaults
                ["ctrl-c"] = "abort",
                ["tab"] = "toggle+down",
                ["shift-tab"] = "toggle+up",
            },
        },
        actions = {
            files = {
                true, -- inherit defaults (ctrl-s/ctrl-v/ctrl-t splits, alt-q to quickfix, …)
                ["enter"] = actions.file_edit_or_qf,
                ["alt-o"] = actions.file_split,
                ["alt-v"] = actions.file_vsplit,
                ["alt-t"] = actions.file_tabedit,
            },
        },
        files = {
            -- No `prompt` here: the files picker defaults to `cwd_prompt = true`, which overwrites the
            -- prompt with the working directory, so a custom prompt would never render.
            fd_opts = [[--color=never --type f --hidden --follow --strip-cwd-prefix ]]
                .. [[--exclude .git --exclude node_modules]],
        },
        grep = {
            prompt = string.format(" %s  ", i.search[1]),
            rg_opts = [[--column --line-number --no-heading --color=always --smart-case ]]
                .. [[--trim --hidden --max-columns=4096 -g "!.git" -g "!node_modules" -g "!tags"]],
        },
    })
end

return {
    {
        -- Improved fzf.vim written in lua
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        dependencies = {
            -- lua `fork` of vim-web-devicons for neovim
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local loaded, fzf = pcall(require, "fzf-lua")
            if not loaded then
                USER.loading_error_msg("fzf-lua")
                return
            end

            setup(fzf)
        end,
    },
}
