-- Custom global variables
_G.user             = {} -- Custom table to store my functions, tables, variables etc
_G.user.dev_mode    = false -- Used from sumneko_lua to populate workspace library accordingly
_G.user.omni_mono   = false -- Make omnisharp change cmd between mono/dotnet
_G.user.theme       = vim.env.SYSTEM_THEME -- Get theme name from SYSTEM_THEME environment variable
_G.user.palettes    = {} -- Custom palettes for hexokinase to load
_G.user.home_path   = vim.fn.expand("$HOME")
_G.user.config_path = vim.fn.stdpath("config")
_G.user.data_path   = vim.fn.stdpath("data")
_G.user.packer_path = vim.fn.stdpath("data") .. "/site/pack/packer"

-- Load Neovim config
require("options") -- Neovim options
require("utilities") -- Custom utility functions
require("autocommands") -- Custom autocommands
require("styling") -- Everything GUI related
require("plugins") -- LOaD aLL tHE plUGiNs!!one!1!
