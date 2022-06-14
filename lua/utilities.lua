-- Launch external program
function _G.launch_ext_prog(prog, args)
    vim.api.nvim_command("!" .. prog .. " " .. args)
    vim.cmd([[redraw!]])
end

-- Custom foldtext
-- function _G.custom_fold_text()
--     local matches = {
--         ["^"] = "%^",
--         ["$"] = "%$",
--         ["("] = "%(",
--         [")"] = "%)",
--         ["%"] = "%%",
--         ["."] = "%.",
--         ["["] = "%[",
--         ["]"] = "%]",
--         ["*"] = "%*",
--         ["+"] = "%+",
--         ["-"] = "%-",
--         ["?"] = "%?",
--     }
--     local line = vim.fn.getline(vim.v.foldstart)
--     local comment = vim.bo.commentstring:gsub("%s*%%s", ""):gsub(".", matches)
--     -- Remove markers
--     line = line:gsub("%{%{%{", "")
--     -- Remove commentstring
--     line = line:gsub(comment, "")
--     -- Remove "-" in case of divider
--     line = line:gsub("%s-%s", " ")
--     line = line:gsub("-", "")
--     -- Remove spaces and tabs
--     line = line:gsub("%c", " "):gsub("%s+", " ")
--     local line_count = vim.v.foldend - vim.v.foldstart + 1
--
--     -- local fold_title_start = "╺─┤ " .. line .. " ├"
--     -- local fold_title_end = "┤ " .. line_count .. " lines ├─╸"
--     -- local return_count = (#fold_title_start - 8) + (#fold_title_end - 8)
--     local fold_title_start = ">=| " .. line .. " |"
--     local fold_title_end = "| " .. line_count .. " lines |=<"
--     local return_count = #fold_title_start + #fold_title_end
--     local ccol = vim.opt.colorcolumn:get()[1]
--     return_count = (ccol - return_count) < 3 and (ccol - 2) or return_count
--
--     return fold_title_start .. string.rep("=", (ccol - return_count)) .. fold_title_end
-- end
