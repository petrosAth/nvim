-- Paths
HOME_PATH = vim.fn.expand("$HOME")
CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
PACKER_PATH = ""

if vim.fn.has("unix") == 1 then
    PACKER_PATH = vim.fn.stdpath("data") .. "/site/pack/packer"
elseif vim.fn.has('win32') == 1 then
    PACKER_PATH = vim.fn.stdpath("data") .. "\\site\\pack\\packer"
else
    print("OS not found, PACKER_PATH could not be set!")
end


-- General config
require("options")
require("utilities")
require("autocommands")
require("plugins")
