local g = vim.g
local palette = CONFIG_PATH .. "/lua/config/hexokinase/palettes"

g.Hexokinase_highlighters     = {
    -- "virtual"
    -- "sign_column"
    -- "background"
    "backgroundfull"
    -- "foreground"
    -- "foregroundfull"
}
g.Hexokinase_optInPatterns    = {
    "full_hex",
    "triple_hex",
    "rgb",
    "rgba",
    "hsl",
    "hsla",
    "colour_names"
}
g.Hexokinase_optOutPatterns   = {}
-- g.Hexokinase_ftOptInPatterns  = {}
-- g.Hexokinase_ftOptOutPatterns = {}
g.Hexokinase_virtualText      = "■"
g.Hexokinase_signIcon         = "■"
g.Hexokinase_refreshEvents    = {
    "TextChanged",
    "InsertLeave",
    "BufRead"
}
g.Hexokinase_termDisabled     = 0
g.Hexokinase_ftDisabled       = {}
g.Hexokinase_ftEnabled        = {
    "css",
    "html",
}
g.Hexokinase_alpha_bg         = ""
g.Hexokinase_checkBoundary    = 1

-- Custom pallets
g.Hexokinase_palettes = {
    palette .. "/dracula.json",
    palette .. "/nord.json"
}
