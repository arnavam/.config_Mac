return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')
    ts.setup()

    -- Install required parsers
    ts.install({
      'python',
      'latex',
      'markdown',
      'markdown_inline',
      'javascript',
      'typescript',
      'tsx',
      'lua',
      'vim',
      'vimdoc',
      'bash',
      'c',
    })

    -- Automatically enable Tree-sitter highlighting for filetypes
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}

