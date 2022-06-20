-- Global variables
DEV_MODE    = false                    -- Used from sumneko_lua to populate workspace library accordingly
OMNI_MONO   = false                    -- Make omnisharp change cmd between mono/dotnet
THEME       = vim.env.SYSTEM_THEME     -- Get theme name from SYSTEM_THEME environment variable
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
