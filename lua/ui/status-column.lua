-- Source
-- roku_remote - https://www.reddit.com/r/neovim/comments/10fpqbp/comment/j4y8sd3/?utm_source=share&utm_medium=web2x&context=3
local icons = USER.styling.icons

local gitsigns_icons = {
    GitSignsAdd = icons.git.signs.add,
    GitSignsChange = icons.git.signs.change,
    GitSignsChangedelete = icons.git.signs.changedelete,
    GitSignsDelete = icons.git.signs.delete,
    GitSignsTopdelete = icons.git.signs.topdelete,
    GitSignsUntracked = icons.git.signs.untracked,
}

local diag_signs_icons = {
    DiagnosticSignError = icons.lsp.error[1],
    DiagnosticSignWarn = icons.lsp.warn[1],
    DiagnosticSignInfo = icons.lsp.info[1],
    DiagnosticSignHint = icons.lsp.hint[1],
    DiagnosticSignOk = icons.lsp.ok[1],
}

local function get_sign_name(cur_sign)
    if cur_sign == nil then
        return nil
    end

    cur_sign = cur_sign[1]

    if cur_sign == nil then
        return nil
    end

    cur_sign = cur_sign.signs

    if cur_sign == nil then
        return nil
    end

    cur_sign = cur_sign[1]

    if cur_sign == nil then
        return nil
    end

    return cur_sign["name"]
end

local function mk_hl(group, sym)
    return table.concat({ "%#", group, "#", sym, "%*" })
end

local function get_name_from_group(bufnum, lnum, group)
    local cur_sign_tbl = vim.fn.sign_getplaced(bufnum, {
        group = group,
        lnum = lnum,
    })

    return get_sign_name(cur_sign_tbl)
end

function _G.get_statuscol_gitsign(bufnum, lnum)
    local cur_sign_nm = get_name_from_group(bufnum, lnum, "gitsigns_vimfn_signs_")

    if cur_sign_nm ~= nil then
        return mk_hl(cur_sign_nm, gitsigns_icons[cur_sign_nm])
    else
        return " "
    end
end

function _G.get_statuscol_diag(bufnum, lnum)
    local cur_sign_nm = get_name_from_group(bufnum, lnum, "*")

    if cur_sign_nm ~= nil and vim.startswith(cur_sign_nm, "DiagnosticSign") then
        return mk_hl(cur_sign_nm, diag_signs_icons[cur_sign_nm])
        -- return diag_signs_icons[cur_sign_nm]
    else
        return " "
    end
end

function _G.get_statuscol_num()
    local v = vim.v
    local mode = vim.api.nvim_get_mode()["mode"]
    local winid = vim.api.nvim_get_current_win()
    local curwin = tonumber(vim.g.actual_curwin)

    if mode == "i" or winid ~= curwin then
        -- if mode == "i" then
        return v.lnum
    end

    if v.relnum == 0 then
        return v.lnum
    end

    return v.relnum
end

function _G.get_statuscol_fold()
    local v = vim.v
    local fn = vim.fn
    local sign = icons.fillchars.global.foldsep

    if fn.foldlevel(v.lnum) == 0 then
        sign = " "
    else
        if fn.foldlevel(v.lnum) > fn.foldlevel(v.lnum - 1) then
            if fn.foldclosed(v.lnum) == -1 then
                sign = icons.fillchars.global.foldopen
            else
                sign = icons.fillchars.global.foldclose
            end
        end

        if fn.foldlevel(v.lnum) > fn.foldlevel(v.lnum + 1) then
            sign = icons.fillchars.extra.foldmid

            if fn.foldlevel(v.lnum + 1) == 0 then
                sign = icons.fillchars.extra.foldend
            end
        end
    end

    return sign
end

_G.get_statuscol = function()
    local str_table = {}

    local parts = {
        ["diagnostics"] = "%{%v:lua.get_statuscol_diag(bufnr(), v:lnum)%}",
        ["fold"] = "%{v:lua.get_statuscol_fold()}",
        ["gitsigns"] = "%{%v:lua.get_statuscol_gitsign(bufnr(), v:lnum)%}",
        ["num"] = "%{v:lua.get_statuscol_num()}",
        ["sep"] = "%=",
        ["signcol"] = "%s",
        ["space"] = " ",
    }

    local order = {
        "diagnostics",
        "space",
        "sep",
        "num",
        "gitsigns",
        "fold",
    }

    for _, val in ipairs(order) do
        table.insert(str_table, parts[val])
    end

    return table.concat(str_table)
end

return "%!v:lua.get_statuscol()"
