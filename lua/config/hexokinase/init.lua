local g = vim.g

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
