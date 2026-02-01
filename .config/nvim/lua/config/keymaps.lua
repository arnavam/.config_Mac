--NOTE: [[ Basic Keymaps ]]
--
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

vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select  all" })
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- strike through, bold, and italic shortcuts
vim.keymap.set('v', 'ms', 'c~~<c-r>"~~', { desc = 'Surround with ~~ (strikethrough)' })
vim.keymap.set('v', 'mb', 'c**<c-r>"**', { desc = 'Surround with ** (bold)' })
vim.keymap.set('v', 'mi', 'c_<c-r>"_', { desc = 'Surround with _ (italic)' })
vim.keymap.set('v', 'mt', 'c[<c-r>"]()<left>', { desc = 'Markdown link [text]()' })
vim.keymap.set('v', 'mu', 'c<c-o>F]', { desc = 'Jump to previous ] (URL nav)' })
vim.keymap.set('v', 'm,', 'c`<c-r>"`', { desc = 'Surround with ` (code)' })


vim.keymap.set('n', '<C-P>', function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
end, { desc = 'Toggle spell check' })


vim.keymap.set('n', '<C-j>', '<C-w>w', { desc = 'Next window' })
vim.keymap.set('n', '<C-k>', '<C-w>W', { desc = 'Previous window' })

local ref_list = {}
local ref_idx = 0

vim.keymap.set('n', 'gro', function()
  vim.lsp.buf.references(nil, function(_, result, ctx)
    ref_list = result
    ref_idx = 0
    if #result > 0 then
      ref_idx = 1
      vim.lsp.util.jump_to_location(result[ref_idx], 0)
    end
  end)
end, {desc='Next reference'})

vim.keymap.set('n', 'grO', function()
  if ref_idx > 1 then 
    ref_idx = ref_idx - 1 
    vim.lsp.util.jump_to_location(ref_list[ref_idx], 0)
  end
end, {desc='Prev reference'})
local ref_idx = 0

vim.keymap.set("v", "<leader>re", "<cmd>Refactor extract <cr>")
vim.keymap.set("v", "<leader>rf", "<cmd>Refactor extract_to_file <cr>")

vim.keymap.set("v", "<leader>rv", "<cmd>Refactor extract_var <cr>")

vim.keymap.set({ "n", "x" }, "<leader>ri", "<cmd>Refactor inline_var<cr>")

vim.keymap.set( "n", "<leader>rI", "<cmd>Refactor inline_func<cr>")

vim.keymap.set("n", "<leader>rb", "<cmd>Refactor extract_block<cr>")
vim.keymap.set("n", "<leader>rbf", "<cmd>Refactor extract_block_to_file<cr>")

vim.g.last_leader_cmd = nil

local function wrap_leader_ex_cmds()
  local maps = vim.api.nvim_get_keymap('n')  -- all normal-mode maps
  for _, m in ipairs(maps) do
    if m.lhs:match('^<leader>') and m.rhs and m.rhs:match('^:%w') then
      -- m.rhs is like ":write<CR>" or ":Ex<CR>"
      local cmd = m.rhs:gsub('^:', ''):gsub('<CR>$', '')
      vim.keymap.set('n', m.lhs, function()
        vim.g.last_leader_cmd = cmd
        vim.cmd(cmd)
      end, { desc = m.desc })
    end
  end
end

wrap_leader_ex_cmds()

vim.keymap.set('n', '<leader>.', function()
  if vim.g.last_leader_cmd then
    vim.cmd(vim.g.last_leader_cmd)
  end
end, { desc = 'Repeat last leader cmd' })

vim.keymap.set('n', '<leader>rr', function()
  local old_word = vim.fn.expand('<cword>')  -- Word under cursor
  local new_word = vim.fn.input('Replace ' .. old_word .. ' with? ', old_word)
  if new_word ~= old_word and new_word ~= '' then
    vim.cmd('%s/\\<' .. old_word .. '\\>/' .. new_word .. '/g')
  end
end, { desc = 'Replace word globally' })
