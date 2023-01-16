local function setup(leap)
    local loaded, which_key = pcall(require, "which-key")
    if not loaded then
        USER.loading_error_msg("which-key.nvim")
        return
    end

    -- Make new table from string
    local t = {}
    local str = "fjdkslaruvmgheiwoxqpbnzFJDKSLARUVMGHEIWOXQPBNZ"
    for i = 1, #str do
        t[i] = str:sub(i, i)
    end
    leap.opts.highlight_unlabeled_phase_one_targets = true
    leap.opts.case_sensitive = true
    leap.opts.labels = t

    local function leap_in_win()
        leap.leap({ target_windows = { vim.fn.win_getid() } })
    end

    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("LeapSetup", { clear = true }),
        pattern = "*",
        callback = function(opts)
            if vim.g.vscode or vim.bo.buftype == "" or vim.bo.buftype == "help" then
                which_key.register({
                    ["<cr>"] = { leap_in_win, "Leap to letter pair within window" },
                    mode = "n",
                    buffer = opts.buf,
                })
                which_key.register({
                    ["<cr>"] = { leap_in_win, "Leap to letter pair within window" },
                    mode = "o",
                    buffer = opts.buf,
                })
                which_key.register({
                    ["<cr>"] = { leap_in_win, "Leap to letter pair within window", mode = "x", buffer = opts.buf },
                })
            end
        end,
    })
end

return {
    -- leap.nvim
    -- Leap is a general-purpose motion plugin for Neovim, with the ultimate goal of establishing a new standard
    -- interface for moving around in the visible area in Vim-like modal editors.
    "ggandor/leap.nvim",
    requires = "folke/which-key.nvim",
    config = function()
        local loaded, leap = pcall(require, "leap")
        if not loaded then
            USER.loading_error_msg("leap.nvim")
            return
        end

        setup(leap)
    end,
}
