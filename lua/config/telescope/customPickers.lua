local telescope = require("telescope")
local builtin = require("telescope.builtin")
local i = PA.styling.icons
local b = PA.styling.borders.default
local bn = PA.styling.borders.none
local M = {}

M.window_size = {
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
        },
        large = 0.9
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
        large = 0.9
    }
}
local ws = M.window_size

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
        prompt_title = "Frecent Files",
    }
end

function M.oldFiles()
    builtin.oldfiles {
        prompt_title = "Recent Files",
    }
end

function M.lsp_references()
    builtin.lsp_references({
        jump_type = 'never',
        layout_strategy = "vertical",
        layout_config = {
            prompt_position = "bottom",
        },
        borderchars = M.borderchars
    })
end

function M.lsp_definitions()
    builtin.lsp_definitions({
        jump_type = 'never',
        layout_strategy = "vertical",
        layout_config = {
            prompt_position = "bottom",
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
            prompt_position = "bottom",
        },
        borderchars = M.borderchars
    }
end

function M.possession()
    telescope.extensions.possession.list {
        previewer = false,
        layout_strategy = "vertical",
        layout_config = {
            width = ws.width.tiny,
            height = ws.height.tiny,
        }
    }
end

function M.luasnip()
    telescope.extensions.luasnip.luasnip {
        layout_config = {
            preview_width = 0.3,
            width = ws.width.large,
            height = ws.height.large,
        }
    }
end

function M.file_browser()
    telescope.extensions.file_browser.file_browser {
        path = "%:p:h"
    }
end

return M
