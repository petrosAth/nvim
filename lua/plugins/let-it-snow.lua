local function setup(let_it_snow)
    let_it_snow.setup({
        delay = 500,
        max_spawn_attempts = 500,
    })
end

return {
    -- A Neovim plugin written in Lua to bring winter "hygge" into your editor
    "marcussimonsen/let-it-snow.nvim",
    cmd = "LetItSnow",
    config = function()
        local loaded, let_it_snow = pcall(require, "let-it-snow")
        if not loaded then
            USER.loading_error_msg("let-it-snow.nvim")
            return
        end

        setup(let_it_snow)
    end,
}
