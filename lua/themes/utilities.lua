local M = {}

---@param color string Hex color code
---@return table color RGB color code
local function hexToRgb(color)
    -- Source: folke/tokyonight.nvim
    -- https://github.com/folke/tokyonight.nvim/blob/66bfc2e8f754869c7b651f3f47a2ee56ae557764/lua/tokyonight/util.lua#L9-L13
    color = string.lower(color)
    return { tonumber(color:sub(2, 3), 16), tonumber(color:sub(4, 5), 16), tonumber(color:sub(6, 7), 16) }
end

---Blend two hex colors
---@param foreground string Foreground color
---@param background string Background color
---@param alpha number|string Number between 0 and 1. 0 results in background, 1 results in foreground
---@return string color Blended hex color
function M.blend(foreground, background, alpha)
    -- Source: folke/tokyonight.nvim
    -- https://github.com/folke/tokyonight.nvim/blob/66bfc2e8f754869c7b651f3f47a2ee56ae557764/lua/tokyonight/util.lua#L15-L26
    alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
    local bg = hexToRgb(background)
    local fg = hexToRgb(foreground)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

---Convert a hex color in hsluv and adjust its hue, lightness or saturation by a given amount
---@param color string Hex color
---@param H number Amount to adjust Hue
---@param S number Amount to adjust Saturation
---@param L number Amount to adjust Lightness
---@return string color Hex color with the given propert(y|ies) modified
function M.adjustHSL(color, H, S, L)
    color = color or "#000000"
    H = H or 0
    S = S or 0
    L = L or 0

    local hsluv = require("themes.hsluv")
    local colorHsluv = hsluv.hex_to_hsluv(color)
    local adjustedColor = "#000000"

    for property, amount in pairs({ H, S, L }) do
        colorHsluv[property] = colorHsluv[property] + amount
    end
    adjustedColor = hsluv.hsluv_to_hex(colorHsluv)

    return adjustedColor
end

---Convert a highlight group rgb decimal value to hexadecimal
---@param value number | string A decimal rgb value
---@return string color A hex color code
local function decToHex(value)
    -- Source: rebelot/heirline.nvim
    -- https://github.com/rebelot/heirline.nvim/blob/9179b71d9967057814e5920ecb3c8322073825ea/lua/heirline/highlights.lua#L68-L74
    if type(value) == "number" then
        return string.format("#%06x", value)
    else
        return value
    end
end

---Get highlight properties for a given highlight name
---@param highlightName string A highlight name
---@return table highlight A highlight with its color values converted to hex
function M.getHl(highlightName)
    -- Source: rebelot/heirline.nvim
    -- https://github.com/rebelot/heirline.nvim/blob/9179b71d9967057814e5920ecb3c8322073825ea/lua/heirline/utils.lua#L3-L23
    local hl = vim.api.nvim_get_hl(0, { name = highlightName, link = false })
    hl.fg = decToHex(hl.fg)
    hl.bg = decToHex(hl.bg)
    hl.sp = decToHex(hl.sp)

    return hl
end

return M
