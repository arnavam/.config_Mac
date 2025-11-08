-- NOTE:[[ Setting options ]]

local o = vim.o
-- See `:help vim.o`
--  For more options, you can see `:help option-list`

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a' -- turn  mouse on 'all modes'
-- Don't show the mode, since it's already in the status line
vim.o.showmode = false
vim.schedule(function() -- run after `UiEnter` because it can increase startup-time
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true -- preserves indent when wrapping the line
vim.o.wrap = true
vim.o.showbreak = '󰅮'
-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.updatetime = 250 --Decrease update time
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time
-- vim.o.cursorline =  true
-- opt. termguicolors = true
-- opt. background = "dark" -
-- opt. signcolumn = "yes" 
-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

vim.o.cursorline = true -- Show line your cursor is on

vim.o.scrolloff = 10-- Minimal no of lines to keep above & below cursor

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
--NOTE: user defined

-- vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
--   pattern = '*',
--   callback = function()
--     vim.wo.relativenumber = false
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
--   pattern = '*',
--   callback = function()
--     vim.wo.relativenumber = true
--   end,
-- })


vim.o.visualbell = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
-- vim.o.softtabstop = 2
-- vim.o.expandtab = true
--
vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal,localoptions"
vim.o.laststatus = 1
-- Set cmdheight to 1 on entering command line,
-- Set back to 0 shortly after leaving to reduce flicker and errors
--
-- vim.api.nvim_create_autocmd("CmdlineEnter", {
--   callback = function()
--     vim.cmd("setlocal cmdheight=1")
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
--   callback = function()
--     -- Delay needed to allow cmdline to disappear cleanly before resetting height
--     vim.defer_fn(function()
--       vim.cmd("setlocal cmdheight=0")
--     end, 100)
--   end,
-- })

vim.opt.wrap = true
vim.opt.linebreak = true



vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.cmd("normal! G")
  end,
})


vim.opt_local.conceallevel = 2


