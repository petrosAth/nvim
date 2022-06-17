-- Paths
HOME_PATH = vim.fn.expand("$HOME")
CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
PACKER_PATH = vim.fn.stdpath("data") .. "/site/pack/packer"

-- Global variables
_G.nvim_dev_mode      = false                    -- Used from sumneko_lua to populate workspace library accordingly
_G.lsp_omnisharp_mono = false                   -- Make omnisharp change cmd between mono/dotnet
_G.themeName          = vim.env.MY_GLOBAL_THEME -- Pick environment variable for system theme name

-- General config
require("options")
require("utilities")
require("autocommands")
require("styling")
require("plugins")
