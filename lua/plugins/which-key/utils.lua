local M = {}

local function register_descriptions(mappings)
    -- Source: echasnovski/nvim
    -- https://github.com/echasnovski/nvim/blob/70e70bfa9223383f059b474ae4969f79676b3dc0/lua/ec/configs/which-key.lua#L24-L34
    return vim.tbl_map(function(keymap)
        if type(keymap) ~= "table" then
            return keymap
        end

        -- If command's name is present, return it
        if type(keymap[2]) == "string" then
            return keymap[2]
        end

        -- Otherwise further traverse tree
        return register_descriptions(keymap)
    end, mappings)
end

local function register_modes(which_key, mappings)
    for mode, keymaps in pairs(mappings) do
        which_key.register(register_descriptions(keymaps), { mode = mode })
    end
end

function M.register_mappings(which_key, mappings)
    register_modes(which_key, mappings)
end

return M
