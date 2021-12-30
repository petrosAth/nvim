local ci = require("cosmetics").icon
local cb = require("cosmetics").border.table

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Initialize packer
packer.init({
    -- max_jobs = 10, -- Limit the number of simultaneous jobs. nil means no limit
    transitive_disable = true, -- Automatically disable dependencies of disabled plugins
    display = {
        non_interactive = false, -- If true, disable display windows for all operations
        open_fn = function() -- An optional function to open a window for packer's display
            return require("packer.util").float { border = { cb.tl, cb.t, cb.tr, cb.r, cb.br, cb.b, cb.bl, cb.l } }
        end,
        working_sym   = ci.pending[1] .. " ", -- The symbol for a plugin being installed/updated
        error_sym     = ci.error[1] .. " ", -- The symbol for a plugin with an error in installation/updating
        done_sym      = ci.done[1] .. " ", -- The symbol for a plugin which has completed installation/updating
        removed_sym   = ci.delete[1] .. " ", -- The symbol for an unused plugin which was removed
        moved_sym     = ci.arrowr[1] .. " ", -- The symbol for a plugin which was moved (e.g. from opt to start)
        header_sym    = cb.t, -- The symbol for the header line in packer's display
        prompt_border = { cb.tl, cb.t, cb.tr, cb.r, cb.br, cb.b, cb.bl, cb.l }, -- Border style of prompt popups.
    },
    -- log = { level = "debug" }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal"
})

return packer
