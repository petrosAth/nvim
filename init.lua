-- Paths
HOME_PATH = vim.fn.expand("$HOME")
CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
PACKER_PATH = vim.fn.stdpath("data") .. "/site/pack/packer"

-- General config
require("options")
require("utilities")
require("autocommands")
require("plugins")

-- Global variables
NVIM_GLOBAL = {}
-- Used from sumneko_lua to populate workspace library accordingly
NVIM_GLOBAL.edit_mode = false
