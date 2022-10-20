-- Custom global variables
_G.PA = { -- Custom table to store my functions, tables, variables etc
    home_path    = vim.fn.expand("$HOME"),
    config_path  = vim.fn.stdpath("config"),
    data_path    = vim.fn.stdpath("data"),
    packer_path  = vim.fn.stdpath("data") .. "/site/pack/packer",
    dev_mode     = false, -- Used from sumneko_lua to populate workspace library accordingly
    omni_mono    = false, -- Make omnisharp change cmd between mono/dotnet
    styling      = {}, -- Table with variables and icons used for neovim styling
    theme        = vim.env.SYSTEM_THEME, -- Get theme name from SYSTEM_THEME environment variable
    mappings     = {}, -- Table for all the key bindings
    local_config = { -- Project's local configuration
        dir = ".nvim", -- Local configuration directory
        file = "init.local.lua", -- Local configuration file
        palettes_dir = "palettes", -- Palettes directory
        spell_dir = "spell", -- Spell directory
    },
}

-- Load Neovim config
require("styling") -- Everything GUI related
require("options") -- Neovim options
require("utilities") -- Utility functions
require("project") -- Project's local configuration helper functions
require("sessions") -- Session managment helper functions
require("autocommands") -- Custom autocommands
require("mappings") -- Keymaps
require("plugins") -- LOaD aLL tEH plUGiNs!!one!1!
