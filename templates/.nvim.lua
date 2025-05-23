-- stylua: ignore
-- selene: allow(undefined_variable)
---@diagnostic disable-next-line: undefined-global
USER.load_local_config({
    use_session        = false, -- Use local session
    use_spellfile      = false, -- Use local spell file
    use_palettes       = false, -- Use local palettes
    use_prettier       = false, -- Copy .prettierrc from templates folder
    use_editorconfig   = false, -- Copy .editorconfig from templates folder
    use_format_on_save = false, -- Enable LSP format on save
})
