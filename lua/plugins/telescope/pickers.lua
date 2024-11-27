local telescope = require("telescope")
local builtin = require("telescope.builtin")
local b = USER.styling.borders.default
local bn = USER.styling.borders.none
local M = {}

M.borderchars = {
--  prompt  = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "▐",   "▌"   }
    prompt  = { b.t,   b.r,   b.b,   b.l,   b.tl,  b.tr,  b.br,  b.bl  },
--  results = { "🬂",   "▐",   "🬭",   "▌",   "🬛",   "🬫",   "🬷",   "🬲"   },
    results = { b.t,   b.r,   bn.b,  b.l,   b.tl,  b.tr,  b.r,   b.l   },
--  preview = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   },
    preview = { b.t,   b.r,   bn.b,  b.l,   b.tl,  b.tr,  b.r,   b.l   },
}

function M.possession()
    telescope.extensions.possession.list({
        previewer = false,
        results_title = false,
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
            prompt_position = "top",
            width = { 0.3, max = 80 },
            height = { 0.3, max = 50 },
        },
    })
end

function M.luasnip() telescope.extensions.luasnip.luasnip() end

function M.file_browser()
    telescope.extensions.file_browser.file_browser({
        path = "%:p:h",
    })
end

local lsp_layout = {
    jump_type = "never",
    layout_strategy = "vertical",
    show_line = false,
    fname_width = 100,
    layout_config = {
        prompt_position = "bottom",
    },
    borderchars = M.borderchars,
}

function M.lsp_references() builtin.lsp_references(lsp_layout) end

function M.lsp_definitions() builtin.lsp_definitions(lsp_layout) end

function M.lsp_type_definitions() builtin.lsp_type_definitions(lsp_layout) end

function M.lsp_implementations() builtin.lsp_implementations(lsp_layout) end

return M
