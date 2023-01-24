return {
    {
        -- nvim-insx
        -- Flexible insert-mode key mapping manager
        "hrsh7th/nvim-insx",
        event = { "InsertEnter" },
        config = function()
            local loaded, insx = pcall(require, "insx.preset.standard")
            if not loaded then
                USER.loading_error_msg("nvim-insx")
                return
            end

            insx.setup()
        end,
    },
}
