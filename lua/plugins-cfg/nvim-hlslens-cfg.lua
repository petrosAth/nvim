local ci = require("cosmetics").icon

require('hlslens').setup({
        -- Enable nvim-hlslens automatically
    auto_enable = true,
        -- When `incsearch` option is on and enable_incsearch is true, add lens
        -- for the current matched instance
    enable_incsearch = true,
        -- When the cursor is out of the position range of the matched instance
        -- and calm_down is true, clear all lens,
    calm_down = true,
        -- Only add lens for the nearest matched instance and ignore others,
    -- nearest_only = false,
        -- When to open the floating window for the nearest lens.
            -- 'auto': floating window will be opened if room isn't enough for virtual text;
            -- 'always': always use floating window instead of virtual text;
            -- 'never': never use floating window for the nearest lens,
    -- nearest_float_when = "always",
        -- Winblend of the nearest floating window. `:h winbl` for more details,
    float_shadow_blend = 50,
        -- Priority of virtual text, set it lower to overlay others.
        --     `:h nvim_buf_set_extmark` for more details,
    virt_priority = 100,
        -- Hackable function for customizing the lens. If you like hacking, you
        --     should search `override_lens` and inspect the corresponding source code.
        --     There's no guarantee that this function will not be changed in the future. If it is
        --     changed, it will be listed in the CHANGES file.,
    override_lens = function(render, plist, nearest, idx, r_idx)
        local sfw = vim.v.searchforward == 1
        local indicator, text, chunks
        local abs_r_idx = math.abs(r_idx)
        if abs_r_idx > 1 then
            indicator = string.format('%d%s', abs_r_idx, sfw ~= (r_idx > 1) and ci.arrowu[1] or ci.arrowd[1])
        elseif abs_r_idx == 1 then
            indicator = sfw ~= (r_idx == 1) and ci.arrowu[1] or ci.arrowd[1]
        else
            indicator = ''
        end

        local lnum, col = unpack(plist[idx])
        if nearest then
            local cnt = #plist
            if indicator ~= '' then
                text = string.format('[%s %d/%d]', indicator, idx, cnt)
            else
                text = string.format('[%d/%d]', idx, cnt)
            end
            chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
        else
            text = string.format('[%s %d]', indicator, idx)
            chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
        end
        render.set_virt(0, lnum - 1, col - 1, chunks, nearest)
    end
})

-- minimap mappings
local map = vim.api.nvim_set_keymap
local n_opts = { noremap = true }
local ns_opts = { noremap = true, silent = true }

map("n", "n",  "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR><cmd>set relativenumber!<CR>", ns_opts)
map("n", "N",  "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR><cmd>set relativenumber!<CR>", ns_opts)

map("n", "*",  "*<Cmd>lua require('hlslens').start()<CR>", n_opts)
map("n", "#",  "#<Cmd>lua require('hlslens').start()<CR>", n_opts)
map("n", "g*", "g*<Cmd>lua require('hlslens').start()<CR>", n_opts)
map("n", "g#", "g#<Cmd>lua require('hlslens').start()<CR>", n_opts)

map("x", "*",  "*<Cmd>lua require('hlslens').start()<CR>", n_opts)
map("x", "#",  "#<Cmd>lua require('hlslens').start()<CR>", n_opts)
map("x", "g*", "g*<Cmd>lua require('hlslens').start()<CR>", n_opts)
map("x", "g#", "g#<Cmd>lua require('hlslens').start()<CR>", n_opts)
