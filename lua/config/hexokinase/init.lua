local g = vim.g
local palette = CONFIG_PATH .. "/lua/config/hexokinase/palettes"

g.Hexokinase_highlighters = {
    -- "virtual"
    -- "sign_column"
    -- "background"
    "backgroundfull",
    -- "foreground"
    -- "foregroundfull"
}
g.Hexokinase_optInPatterns = {
    "full_hex",
    "triple_hex",
    "rgb",
    "rgba",
    "hsl",
    "hsla",
    "colour_names",
}
g.Hexokinase_refreshEvents = {
    "BufRead",
    "BufEnter",
    "TextChanged",
    "InsertLeave",
}
g.Hexokinase_ftEnabled = {
    "css",
    "html",
    "json",
}
-- Custom pallets
g.Hexokinase_palettes = {
    palette .. "/dracula.json",
    palette .. "/nord.json",
}
