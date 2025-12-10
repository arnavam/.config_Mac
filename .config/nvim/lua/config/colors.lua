
-- vim.api.nvim_set_hl(0, "MiniStatuslineInsert", { bg = "#d7ebff", fg = "#1a1a1a", bold = true })
-- vim.api.nvim_set_hl(0, "MiniStatuslineVisual", { bg = "#ffd7d7", fg = "#1a1a1a", bold = true })
-- vim.api.nvim_set_hl(0, "MiniStatuslineReplace", { bg = "#ffd7b3", fg = "#1a1a1a", bold = true })
-- vim.api.nvim_set_hl(0, "MiniStatuslineCommand", { bg = "#d7f0d7", fg = "#1a1a1a", bold = true })
-- vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { bg = "#e7e7e7", fg = "#808080" })


-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = "#3b82f6" })
--   end,
-- })
-- -- After requiring and setting up catppuccin
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     -- Override Neo-tree highlights to disable Catppuccin styling

--   end,
-- })
-- vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
--   callback = function()
--     local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
--     if not normal.bg then return end
--     io.write(string.format("\027]11;#%06x\027\\", normal.bg))
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("UILeave", {
--   callback = function() io.write("\027]111\027\\") end,
-- })
-- vim.cmd.colorscheme 'tokyonight-night'
vim.cmd.colorscheme 'monokai-pro'
local colors = require('monokai-pro')
-- vim.cmd.colorscheme("catppuccin")
--
-- vim.cmd.colorscheme("onedark")
-- vim.api.nvim_set_hl(0, "NeoTreeFolderName", { link = "Directory" })
-- vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { link = "DiffAdd" })
-- -- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = colors.bg, fg = colors.fg })
-- -- vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = colors.bg, fg = colors.bg })
-- -- vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = colors.cursorline })
-- -- vim.api.nvim_set_hl(0, "NeoTreeFolderName", { fg = colors.blue })
-- -- vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = colors.yellow, bold = true })
-- -- vim.api.nvim_set_hl(0, "NeoTreeFileNameOpened", { fg = colors.green })
-- -- vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = colors.green })
-- -- vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = colors.yellow })
-- -- vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = colors.red })
-- -- vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = colors.comment_grey })
-- -- Reset and link to OneDark's standard groups
-- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { link = "NormalNC" })
-- vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { link = "EndOfBuffer" })
-- vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { link = "CursorLine" })
-- vim.api.nvim_set_hl(0, "NeoTreeFolderName", { link = "Directory" })
-- vim.api.nvim_set_hl(0, "NeoTreeRootName", { link = "Title" })
-- vim.api.nvim_set_hl(0, "NeoTreeFileNameOpened", { link = "Identifier" })
-- vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { link = "DiffAdd" })
-- vim.api.nvim_set_hl(0, "NeoTreeGitModified", { link = "DiffChange" })
-- vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { link = "DiffDelete" })
-- vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { link = "Comment" })
-- colors._load('pro')
--vim.api.nvim_set_hl(0, "WhichKeyBorder", {  bg = colors.bg, fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", {  bg = colors.bg, fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", {  bg = colors.bg, fg = "#FFFFFF" })
-- vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = "#FFFFFF", fg = "#000000", bold = true})

vim.api.nvim_set_hl(0, "FloatBorder", {  bg = colors.bg, fg = "#FFFFFF" })

vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#FFFFFF" })  -- Dark gray divider, transparent bg
-- Or match your background: { fg = "#1A1B26", bg = "NONE" }
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "neo-tree",
--   callback = function()
--       -- or any theme you want for neo-tree
--   end,
-- })
--
vim.api.nvim_set_hl(0, 'AlphaHeader', { bg = '#ffd7d7' })
vim.api.nvim_set_hl(0, 'AlphaButtons', { bg = '#ffd7d7' })
vim.api.nvim_set_hl(0, 'AlphaFooter', { bg = '#ffd7d7' })

vim.api.nvim_set_hl(0, "SnacksDashboardFile", { fg = "#000000",  bold = true })
vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#000000",  bold = true })
vim.api.nvim_set_hl(0, "SnacksDashboardTitle", { fg = "#000000",  bold = true })
vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = "#000000",  bold = true })
vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#000000",  bold = true })
vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#000000",  bold = true })
