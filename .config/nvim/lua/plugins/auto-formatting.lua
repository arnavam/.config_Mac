return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    -- Setup mason-null-ls for automatic installation
    require('mason-null-ls').setup {
      ensure_installed = {
        -- 'checkmake',
        -- 'prettier',
        -- 'shfmt',
        'ruff',
      },
      automatic_installation = true,
    }

    -- Configure null-ls sources
    null_ls.setup {
      sources = {
        diagnostics.checkmake,
        formatting.prettier.with {
          filetypes = {
            -- 'jsonc', 'css', 'html', 'json', 'yaml', 'markdown'
          },
        },
        formatting.shfmt.with { args = { '-i', '4' } },
        formatting.terraform_fmt,
        require('none-ls.formatting.ruff').with {
          extra_args = { '--extend-select', 'I' },
        },
        require 'none-ls.formatting.ruff_format',
      },
    }

    -- Format keymaps for whole buffer and visual selection
    vim.keymap.set('n', '<leader>p', function()
      vim.lsp.buf.format { async = true }
    end, { desc = 'Format buffer' })

    -- Format selected text in visual mode
    vim.keymap.set('v', '<leader>p', function()
      vim.lsp.buf.format {
        async = true,
        range = {
          start = vim.api.nvim_buf_get_mark(0, '<'),
          ['end'] = vim.api.nvim_buf_get_mark(0, '>'),
        },
      }
    end, { desc = 'Format selection' })
  end,
}
