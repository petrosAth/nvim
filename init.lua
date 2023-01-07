USER = { -- Custom table to store my functions, tables, variables etc
    home_path    = vim.fn.expand("$HOME"),
    config_path  = vim.fn.stdpath("config"),
    data_path    = vim.fn.stdpath("data"),
    packer_path  = vim.fn.stdpath("data") .. "/site/pack/packer",
    omni_mono    = false, -- Make omnisharp change cmd between mono/dotnet
    styling      = {}, -- Table with variables and icons used for neovim styling
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
        templates    = vim.fn.stdpath("config") .. "/lua/project/templates", -- Directory within nvim config containing file templates
    },
}

require("styling")
require("plugins")
