-- Create custom table to store my functions, tables, variables etc
USER = {
    omni_mono    = false, -- Make omnisharp change cmd between mono/dotnet
    styling      = require("styling"), -- Table with variables and icons used for neovim styling
    theme        = vim.env.SYSTEM_THEME or "nord", -- Get theme name from SYSTEM_THEME environment variable
    mappings     = {}, -- Table for all the key bindings
    local_config = { -- Project's local configuration
        dir          = ".nvim",                -- Local config directory
        file         = "init.local.lua",       -- Local config file
        palettes_dir = "palettes",             -- Palettes local config directory
        palette_file = "palette.json",         -- Pallette file name
        spell_dir    = "spell",                -- Spell local config directory
        vale_dir     = "styles/Vocab/Project", -- Vale local config directory
        vale_file    = ".vale.ini",            -- Vale config file name
        templates    = vim.fn.stdpath("config") .. "/templates", -- Directory within nvim config containing file templates
    },
}

-- Set colorscheme
vim.cmd.colorscheme(USER.theme)

-- Initialize plugin-manager
require("plugin-manager").setup()
