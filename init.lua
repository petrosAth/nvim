local themes = {
    "dracula",
    "everforest-dark",
    "everforest-medium",
    "everforest-soft",
    "gruvbox",
    "monokai",
    "nord",
    "onedark-cool",
    "onedark-dark",
    "onedark-darker",
    "onedark-deep",
    "onedark-warm",
    "onedark-warmer",
    "selenized-black",
    "selenized-dark",
    "solarized-osaka",
}

-- Create custom table to store my functions, tables, variables etc
USER = {
    styling = require("styling"), -- Table with variables and icons used for neovim styling
    theme = themes[0] or vim.env.SYSTEM_THEME or "nord", -- Get theme name from SYSTEM_THEME environment variable
    transparent_bg = true,
    mappings = {}, -- Table for all the key bindings
    local_config = { -- Project's local configuration
        dir = ".nvim", -- Local config directory
        palettes_dir = "palettes", -- Palettes local config directory
        palette_file = "palette.lua", -- Palette file name
        palettes = {}, -- Local palettes
        spell_dir = "spell", -- Spell local config directory
        prettier_file = ".prettierrc", -- Prettier config file name
        templates = string.format("%s/templates", vim.fn.stdpath("config")), -- Directory within nvim config containing file templates
    },
    lsp = {
        show_inlay_hints = false,
        enable_semantic_tokens = true,
    },
}

-- Leader keys. Set here (not in plugin/options.lua) because lazy.nvim sources
-- this config's plugin/ files in alphabetical order, so plugin/mappings.lua
-- loads *before* plugin/options.lua. mapleader is captured when each map is
-- defined, so it must be set before mappings.lua runs — i.e. before
-- require("plugin-manager").init() below. Space is the primary <Leader>; the
-- legacy "\" group lives on <LocalLeader>.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set colorscheme
vim.cmd.colorscheme(USER.theme)
vim.cmd('echo " "') -- Fix Neovim flicker in wezterm

-- Load utility functions
require("utilities")

-- Register project-local config (defines USER.load_local_config before 'exrc' runs)
require("local-config").setup()

-- Initialize plugin-manager
require("plugin-manager").init()
