local telescope = require("telescope")
local builtin = require("telescope.builtin")
local i = require("styling").icons
local b = require("styling").borders.default
local bn = require("styling").borders.none
local window_size = {
    width = {
        tiny = {
            0.3,
            min = 40,
            max = 60,
        },
        small = {
            0.6,
            min = 90,
            max = 110,
        },
        medium = {
            0.6,
            min = 100,
            max = 130,
        }
    },
    height = {
        tiny = {
            0.3,
            min = 20,
            max = 40,
        },
        small = {
            0.5,
            min = 20,
            max = 40,
        },
        medium = {
            0.8,
            min = 40,
            max = 50,
        },
    }
}

local M = {}

M.borderchars = {
--  prompt  = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "▐",   "▌"   }
    prompt  = { b.t,   b.r,   b.b,   b.l,   b.tl,  b.tr,  b.br,  b.bl  },
--  results = { "🬂",   "▐",   "🬭",   "▌",   "🬛",   "🬫",   "🬷",   "🬲"   },
    results = { b.t,   b.r,   bn.b,  b.l,   b.tl,  b.tr,  b.r,   b.l   },
--  preview = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   },
    preview = { b.t,   b.r,   bn.b,  b.l,   b.tl,  b.tr,  b.r,   b.l   },
    }

function M.frecency()
    telescope.extensions.frecency.frecency {
        prompt_title = "Frecency",
    }
end

function M.oldfiles()
    builtin.oldfiles {
        prompt_title = "Recent Files",
    }
end

function M.buffers()
    builtin.buffers {
        previewer = false,
        layout_strategy = "vertical",
        layout_config = {
            width = window_size.width.small,
            height = window_size.height.small,
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
            width = window_size.width.medium,
            height = window_size.height.medium,
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
            width = window_size.width.medium,
            height = window_size.height.medium,
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
            width = window_size.width.medium,
            height = window_size.height.medium,
        },
        borderchars = M.borderchars
    }
end

function M.possession()
    telescope.extensions.possession.list {
        previewer = false,
        layout_strategy = "vertical",
        layout_config = {
            width = window_size.width.tiny,
            height = window_size.height.tiny,
        }
    }
end

return M
