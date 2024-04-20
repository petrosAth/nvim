-- Create custom table to store my functions, tables, variables etc
USER = {
    omni_mono    = false, -- Make omnisharp change cmd between mono/dotnet
    styling      = require("styling"), -- Table with variables and icons used for neovim styling
    theme        = vim.env.SYSTEM_THEME or "nord", -- Get theme name from SYSTEM_THEME environment variable
    mappings     = {}, -- Table for all the key bindings
    local_config = { -- Project's local configuration
        dir           = ".nvim",                 -- Local config directory
        palettes_dir  = "palettes",              -- Palettes local config directory
        palette_file  = "palette.lua",           -- Palette file name
        spell_dir     = "spell",                 -- Spell local config directory
        prettier_file = ".prettierrc",           -- Prettier config file name
        templates     = vim.fn.stdpath("config") .. "/templates", -- Directory within nvim config containing file templates
    },
}

-- Set colorscheme
vim.cmd.colorscheme(USER.theme)
vim.cmd('echo " "') -- Fix Neovim flicker in wezterm

-- Load utility functions
require("utilities")

-- Initialize plugin-manager
require("plugin-manager").init()
