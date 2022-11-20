-- alpha-nvim
local ol = vim.opt_local
local i = USER.styling.icons.fillchars

ol.winbar    = nil            -- Disable winbar
ol.fillchars = i.global       -- Re-apply fillchars because Trouble resets them
ol.fillchars:append(i.custom) -- Remove eob character

-- Show neovim nightly changelog on the dashboard if the current version is a prerelease
if vim.version()["prerelease"] then
    vim.cmd("vert help news")
    vim.cmd("79wincmd|")
    vim.cmd("wincmd p")
end
