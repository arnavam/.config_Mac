return {
  'benlubas/molten-nvim',
  version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
  build = ':UpdateRemotePlugins',

  init = function()
    -- this is an example, not a default. Please see the readme for more configuration options
    vim.g.molten_output_win_max_height = 12
    vim.g.molten_auto_open_output = true

    vim.g.molten_image_provider = 'snacks.nvim'
    vim.g.molten_python_path = vim.fn.expand '~/.virtualenvs/neovim/bin/python'
    vim.g.molten_wrap_output = true
    -- Output as virtual text. Allows outputs to always be shown, works with images, but can
    -- be buggy with longer images
    vim.g.molten_virt_text_output = true

    -- this will make it so the output shows up below the \`\`\` cell delimiter
    vim.g.molten_virt_lines_off_by_1 = true

vim.keymap.set("n", "<leader>ji", ":MoltenInit<CR>",
    { silent = true, desc = "Initialize the plugin" })
vim.keymap.set("n", "<leader>je", ":MoltenEvaluateOperator<CR>",
    { silent = true, desc = "run operator selection" })
vim.keymap.set("n", "<leader>jl", ":MoltenEvaluateLine<CR>",
    { silent = true, desc = "evaluate line" })
vim.keymap.set("n", "<leader>jr", ":MoltenReevaluateCell<CR>",
    { silent = true, desc = "re-evaluate cell" })
vim.keymap.set("v", "<leader>je", ":<C-u>MoltenEvaluateVisual<CR>gv",
    { silent = true, desc = "evaluate visual selection" })
vim.keymap.set("n", "<leader>jd", ":MoltenDelete<CR>",
    { silent = true, desc = "molten delete cell" })
vim.keymap.set("n", "<leader>jh", ":MoltenHideOutput<CR>",
    { silent = true, desc = "hide output" })
vim.keymap.set("n", "<leader>js", ":noautocmd MoltenEnterOutput<CR>",
    { silent = true, desc = "show/enter output" })
    vim.keymap.set('n', '<leader>jp', function()
      local venv = os.getenv 'VIRTUAL_ENV' or os.getenv 'CONDA_PREFIX'
      if venv ~= nil then
        -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
        venv = string.match(venv, '/.+/(.+)')
        vim.cmd(('MoltenInit %s'):format(venv))
      else
        vim.cmd 'MoltenInit python3'
      end
    end, { desc = 'Initialize Molten for python3', silent = true })
  end,
}
