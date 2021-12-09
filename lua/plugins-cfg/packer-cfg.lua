local install_path = PACKER_PATH .. "\\start\\packer.nvim"
local present, packer = pcall(require, "packer")
local ci = require("cosmetics").icon
local cb = require("cosmetics").border.table

-- Check if packer is installed, if not install packer
if not present then
    -- Cleaner float highlight
    vim.cmd([[
        highlight Normalfloat guibg=NONE
        highlight Floatborder guibg=NONE
        redraw!
    ]])

	-- Install packer
	print("Installing packer.nvim.")
	vim.fn.delete(CONFIG_PATH .. "\\plugin", "rf")
	vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })

	-- Check for installation sucess
	vim.cmd([[packadd packer.nvim]])
	present, packer = pcall(require, "packer")

	if present then
		print("Installation complete.\nStarting plugin installation.")
	else
		error("Packer installation failed")
	end
end

-- Initialize packer
packer.init({
    display = {
        non_interactive = false, -- If true, disable display windows for all operations
        open_fn = function() -- An optional function to open a window for packer's display
            return require("packer.util").float { border = { cb.tl, cb.t, cb.tr, cb.r, cb.br, cb.b, cb.bl, cb.l } }
        end,
        working_sym = " " .. ci.pending[1] .. "  ", -- The symbol for a plugin being installed/updated
        error_sym =   " " .. ci.error[1] .. "  ", -- The symbol for a plugin with an error in installation/updating
        done_sym =    " " .. ci.done[1] .. "  ", -- The symbol for a plugin which has completed installation/updating
        removed_sym = " " .. ci.delete[1] .. "  ", -- The symbol for an unused plugin which was removed
        moved_sym =   " " .. ci.arrowr[1] .. "  ", -- The symbol for a plugin which was moved (e.g. from opt to start)
        header_sym = cb.t, -- The symbol for the header line in packer's display
        prompt_border = { cb.tl, cb.t, cb.tr, cb.r, cb.br, cb.b, cb.bl, cb.l }, -- Border style of prompt popups.
    },
    -- log = { level = "debug" }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal"
    auto_clean = true, -- During sync(), remove unused plugins
    compile_on_sync = true,
	max_jobs = 10,
})

-- packer mappings
local map = vim.api.nvim_set_keymap
local ns_opts = { noremap = true, silent = true }

map("n", "<Leader>up", "<cmd>PackerSync<CR>", ns_opts)

return packer
