--NOTE: [[ Basic Keymaps ]]

vim.keymap.set('n', 'J', '<C-d>')
vim.keymap.set('n', 'K', '<C-u>', { noremap = true, silent = true })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
--   callback = function()
--     local dir = vim.fn.expand '%:p:h'
--     if vim.fn.isdirectory(dir) == 1 then
--       vim.cmd('cd ' .. dir)
--     end
--   end,
-- })

-- vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})
vim.keymap.set('n', 'g/', ':noh<CR>')
vim.keymap.set("n", "<D-a>", "ggVG", { noremap = true, silent = true })
vim.keymap.set('v', '<D-c>', '"y', { desc = 'Copy to system clipboard' })

local opts = { noremap = true, silent = true, desc = "Delete into d register" }

vim.keymap.set('n', 'd', '"dd', opts)
vim.keymap.set('n', 'd', '"dd', opts) -- delete into "d register
vim.keymap.set('v', 'd', '"dd', opts)

-- Normal mode
vim.keymap.set('n', '<leader>r', '<C-r>', { noremap = true, silent = true })

-- Insert mode (redo is a bit different, usually Ctrl+o u)
vim.keymap.set('i', '<leader>r', '<C-o><C-r>', { noremap = true, silent = true })

-- Visual mode
vim.keymap.set('v', '<leader>r', '<C-r>', { noremap = true, silent = true })
vim.keymap.set('v', 'p', '"_dP', { noremap = true, silent = true })

vim.keymap.set ("n" , "<leader>+", "<C-a>",
	{
desc = "Increment number" })

vim.keymap.set("n",
"< leader>-",
"<C-X>" ,
{
desc = "Decrement number" })


--vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})
