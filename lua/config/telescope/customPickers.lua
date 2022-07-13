local telescope = require("telescope")
local builtin = require("telescope.builtin")
local i = require("styling").icons
local b = require("styling").borders.default
local bn = require("styling").borders.none

local M = {}

M.borderchars = {
--  prompt  = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "▐",   "▌"   }
    prompt  = { b.t,   b.r,   b.b,   b.l,   b.tl,  b.tr,  b.br,  b.bl  },
--  results = { "🬂",   "▐",   "🬭",   "▌",   "🬛",   "🬫",   "🬷",   "🬲"   },
    results = { b.t,   b.r,   bn.b,  b.l,   b.tl,  b.tr,  b.r,   b.l   },
--  preview = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   },
    preview = { b.t,   b.r,   bn.b,  b.l,   b.tl,  b.tr,  b.r,   b.l   },
    }

function M.find_recent()
    telescope.extensions.frecency.frecency{
        prompt_title = "Recent Files",
    }
end

function M.project()
    telescope.extensions.project.project{
        display_type = "full",
        results_title = "Results",
        layout_config = {
            width = 0.5,
            height = 0.6
        }
    }
end

function M.buffers()
    builtin.buffers {
        previewer = false,
        layout_strategy = "vertical",
        layout_config = {
            width = 0.6,
            height = 0.8
        }
    }
end

function M.lsp_references()
    builtin.lsp_references({
        jump_type = 'never',
        layout_strategy = "vertical",
        layout_config = {
            preview_height = 0.5,
            prompt_position = "bottom",
            width = 0.4,
            height = 0.8
        },
        borderchars = M.borderchars
    })
end

function M.lsp_definitions()
    builtin.lsp_definitions({
        jump_type = 'never',
        layout_strategy = "vertical",
        layout_config = {
            preview_height = 0.5,
            prompt_position = "bottom",
            width = 0.4,
            height = 0.8
        },
        borderchars = M.borderchars
    })
end

function M.notify()
    telescope.extensions.notify.notify{
        results_title = "Results",
        prompt_title = "Notifications",
        layout_strategy = "vertical",
        layout_config = {
            preview_height = 0.3,
            prompt_position = "bottom",
            width = 0.4,
            height = 0.5
        },
        borderchars = M.borderchars
    }
end

return M
