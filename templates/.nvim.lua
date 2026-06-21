-- stylua: ignore
-- selene: allow(undefined_variable)
---@diagnostic disable-next-line: undefined-global

-- Resolve this file's own directory (works whether sourced by 'exrc' or the fallback loader).
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")
USER.local_config.root = root
vim.opt.runtimepath:append(root .. "/.nvim") -- native: .nvim/lsp, .nvim/ftplugin, .nvim/spell, ...

USER.load_local_config({
    use_session        = false, -- Use local session
    use_spellfile      = false, -- Use local spell file
    use_palettes       = false, -- Use local palettes
    use_prettier       = false, -- Copy .prettierrc from templates folder
    use_editorconfig   = false, -- Copy .editorconfig from templates folder
    use_format_on_save = false, -- Enable LSP format on save
})
