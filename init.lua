-- Global variables
_G.user = {}
_G.user.dev_mode    = false                -- Used from sumneko_lua to populate workspace library accordingly
_G.user.omni_mono   = false                -- Make omnisharp change cmd between mono/dotnet
_G.user.theme       = vim.env.SYSTEM_THEME -- Get theme name from SYSTEM_THEME environment variable
_G.user.palettes    = {}

-- Paths
HOME_PATH   = vim.fn.expand("$HOME")
CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH   = vim.fn.stdpath("data")
PACKER_PATH = vim.fn.stdpath("data") .. "/site/pack/packer"

-- General config
require("options")
require("utilities")
require("autocommands")
require("styling")
require("plugins")
