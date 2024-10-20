local M = {}

local function add_desc(which_key, mappings, mode, prefix)
    -- Source: echasnovski/nvim
    -- https://github.com/echasnovski/nvim/blob/47eb53792a1ff1e1c482c19fbae8ac035e352e2d/lua/ec/mappings-leader.lua#L198-L220
    if type(mappings) ~= "table" then
        return
    end

    prefix = prefix or ""

    if mappings["group"] then
        which_key.add({ prefix, mode = mode, group = mappings.group })
        if next(mappings) == "group" then
            return
        end
    end

    if mappings["desc"] then
        which_key.add({ prefix, mode = mode, desc = mappings.desc })
        return
    end

    for key, t in pairs(mappings) do
        add_desc(which_key, t, mode, prefix .. key)
    end
end

function M.add_map_desc(which_key)
    local mappings = vim.deepcopy(USER.mappings)
    for mode, mapping in pairs(mappings) do
        add_desc(which_key, mapping, mode)
    end
end

function M.enable_hydra(which_key)
    which_key.show({
        keys = "<C-W>",
        loop = true,
    })
end

return M
