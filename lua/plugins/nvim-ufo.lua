local function fold_virt_text_handler(virtText, lnum, endLnum, width, truncate)
    local fillchars = USER.styling.icons.fillchars.global
    local newVirtText = {}
    local suffix = (" %s %d lines"):format(fillchars.foldclose, endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0

    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end

    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end

local function setup(ufo)
    local b = USER.styling.borders.default

    ufo.setup({
        open_fold_hl_timeout = 150,
        provider_selector = function(bufnr, _filetype, buftype)
            if buftype ~= "" then return "" end
            local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
            local has_folds = ok and parser and vim.treesitter.query.get(parser:lang(), "folds") ~= nil
            return has_folds and { "lsp", "treesitter" } or { "lsp", "indent" }
        end,
        fold_virt_text_handler = fold_virt_text_handler,
        preview = {
            win_config = {
                border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l },
                winhighlight = "Normal:Folded",
                winblend = 0,
            },
            mappings = {
                scrollU = "<C-u>",
                scrollD = "<C-d>",
                jumpTop = "[",
                jumpBot = "]",
            },
        },
    })
end

return {
    {
        -- Not UFO in the sky, but an ultra fold in Neovim.
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = "BufReadPost",
        config = function()
            local loaded, ufo = pcall(require, "ufo")
            if not loaded then
                USER.loading_error_msg("nvim-ufo")
                return
            end

            setup(ufo)
        end,
    },
}
