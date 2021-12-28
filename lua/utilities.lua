-- Check if key exists in table
local function table_has_key(table, key)
	for k, _ in pairs(table) do
		if k == key then
			return true
		end
	end
	return false
end

-- Trim newline at eof, trailing whitespace.
function _G.perform_cleanup()
	if vim.bo.modified then
		local view = vim.fn.winsaveview()
		vim.cmd([[
            keeppatterns %s/$\n\+\%$//e " removes trailing lines
            keeppatterns %s/\s\+$//e " removes trailing spaces
            keeppatterns %s/\r//e " removes linux line endings
        ]])
		vim.fn.winrestview(view)
	end
end

-- Save current view settings on a per-window, per-buffer basis.
-- https://stackoverflow.com/questions/4251533/vim-keep-window-position-when-switching-buffers
-- http://vim.wikia.com/wiki/Avoid_scrolling_when_switch_buffers
function _G.auto_save_win_view()
	if not vim.w.saved_buf_view then
		vim.w.saved_buf_view = {}
	end
	vim.w.saved_buf_view[vim.fn.bufnr("%")] = vim.fn.winsaveview()
end

function _G.auto_restore_win_view()
	local buf = vim.fn.bufnr("%")
	if vim.w.saved_buf_view and table_has_key(vim.w.saved_buf_view, buf) then
		local view = vim.fn.winsaveview()
		local atStartOfFile = view.lnum == 1 and view.col == 0
		if atStartOfFile and not vim.o.diff then
			vim.fn.winrestview(vim.w.saved_buf_view[buf])
		end
		vim.api.nvim_win_del_var("saved_buf_view")
	end
end

-- Quickfix toggle
-- https://vim.fandom.com/wiki/Toggle_to_open_or_close_the_quickfix_window
-- function _G.qfix_toggle(forced)
-- 	if vim.g.qfix_win and forced then
-- 		vim.cmd([[cclose]])
-- 		vim.api.nvim_del_var("qfix_win")
-- 	else
-- 		vim.cmd([[copen 10]])
-- 		vim.g.qfix_win = vim.fn.bufnr("$")
-- 	end
-- end
-- vim.cmd([[command! -bang -nargs=? QFix lua qfix_toggle(<bang>0)]])

-- Launch external program
function _G.launch_ext_prog(prog, args)
	vim.api.nvim_command("!" .. prog .. " " .. args)
	vim.cmd([[redraw!]])
end

-- Custom foldtext
-- function _G.custom_fold_text()
-- 	local matches = {
-- 		["^"] = "%^",
-- 		["$"] = "%$",
-- 		["("] = "%(",
-- 		[")"] = "%)",
-- 		["%"] = "%%",
-- 		["."] = "%.",
-- 		["["] = "%[",
-- 		["]"] = "%]",
-- 		["*"] = "%*",
-- 		["+"] = "%+",
-- 		["-"] = "%-",
-- 		["?"] = "%?",
-- 	}
-- 	local line = vim.fn.getline(vim.v.foldstart)
-- 	local comment = vim.bo.commentstring:gsub("%s*%%s", ""):gsub(".", matches)
-- 	-- Remove markers
-- 	line = line:gsub("%{%{%{", "")
-- 	-- Remove commentstring
-- 	line = line:gsub(comment, "")
-- 	-- Remove "-" in case of divider
-- 	line = line:gsub("%s-%s", " ")
-- 	line = line:gsub("-", "")
-- 	-- Remove spaces and tabs
-- 	line = line:gsub("%c", " "):gsub("%s+", " ")
-- 	local line_count = vim.v.foldend - vim.v.foldstart + 1
--
--     -- local fold_title_start = "╺─┤ " .. line .. " ├"
--     -- local fold_title_end = "┤ " .. line_count .. " lines ├─╸"
--     -- local return_count = (#fold_title_start - 8) + (#fold_title_end - 8)
--     local fold_title_start = ">=| " .. line .. " |"
--     local fold_title_end = "| " .. line_count .. " lines |=<"
--     local return_count = (#fold_title_start) + (#fold_title_end)
--     local ccol = vim.opt.colorcolumn:get()[1]
--     return_count = (ccol - return_count) < 3 and (ccol - 2) or return_count
--
--     return fold_title_start .. string.rep("=", (ccol - return_count)) .. fold_title_end
-- end
