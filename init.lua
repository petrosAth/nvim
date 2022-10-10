-- Custom global variables
_G.PA             = {} -- Custom table to store my functions, tables, variables etc
_G.PA.dev_mode    = false -- Used from sumneko_lua to populate workspace library accordingly
_G.PA.omni_mono   = false -- Make omnisharp change cmd between mono/dotnet
_G.PA.theme       = vim.env.SYSTEM_THEME -- Get theme name from SYSTEM_THEME environment variable
_G.PA.palettes    = {} -- Custom palettes for hexokinase to load
_G.PA.mappings    = {} -- Table for all my keymaps
_G.PA.home_path   = vim.fn.expand("$HOME")
_G.PA.config_path = vim.fn.stdpath("config")
_G.PA.data_path   = vim.fn.stdpath("data")
_G.PA.packer_path = vim.fn.stdpath("data") .. "/site/pack/packer"

-- Load Neovim config
require("options") -- Neovim options
require("utilities") -- Utility functions
require("autocommands") -- Custom autocommands
require("styling") -- Everything GUI related
require("mappings") -- Keymaps
require("plugins") -- LOaD aLL tHE plUGiNs!!one!1!
