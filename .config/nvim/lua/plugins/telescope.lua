return { -- Fuzzy er (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      build = 'make', -- `build` is used to run some command when the plugin is installed/updated.

      cond = function() -- `cond` is a condition used to determine whether this plugin should be
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    'andrew-george/telescope-themes',
    -- Useful for getting pretty icons, but requires a Nerd Font.
    --
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        -- layout_strategy = "vertical",
        --  layout_config = {
        --    -- height = vim.o.lines, -- maximally available lines
        --    -- width = vim.o.columns, -- maximally available columns
        --    prompt_position = "top",
        --    preview_height = 0.6, -- 60% of available lines
        --  },
        --
        layout_config = {
          horizontal = {
            prompt_position = 'bottom',
            preview_width = 0.6,
          },
        },

        mappings = {
          i = {
            ['<C-CR>'] = 'file_vsplit',
            ['<C-r>'] = require('telescope.actions').send_to_qflist,
          },
        },
      },
      -- pickers = {
      --          help_tags = {
      --              mappings = {
      --                  i = {
      --                      ["<CR>"] = "file_vsplit",
      --                  },
      --              },
      --          },
      --      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'themes')
    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>ft', ':Telescope themes<CR>', { noremap = true, silent = true, desc = 'Theme Switcher' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>s', builtin.find_files, { desc = '[F]iles [f]ind ' })
    --
    vim.keymap.set('n', '<leader>ff', builtin.builtin, { desc = '[f]ind [S]elect Telescope' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[f]ind current [W]ord' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[f]ind by [G]rep' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[f]ind [D]iagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[f]ind [R]esume' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[f]ind Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ]  existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>dd', function()
      local diagnostics = vim.diagnostic.get(0)
      if #diagnostics == 0 then
        vim.notify('No diagnostics in current buffer', vim.log.levels.INFO)
      else
        local messages = {}
        local severity_counts = { error = 0, warn = 0, info = 0, hint = 0 }

        for _, diag in ipairs(diagnostics) do
          local severity = diag.severity
          if severity == vim.diagnostic.severity.ERROR then
            severity_counts.error = severity_counts.error + 1
          elseif severity == vim.diagnostic.severity.WARN then
            severity_counts.warn = severity_counts.warn + 1
          elseif severity == vim.diagnostic.severity.INFO then
            severity_counts.info = severity_counts.info + 1
          elseif severity == vim.diagnostic.severity.HINT then
            severity_counts.hint = severity_counts.hint + 1
          end

          table.insert(messages, string.format('Line %d:%d - %s', diag.lnum + 1, diag.col + 1, diag.message))
        end

        if #messages > 0 then
          print 'Detailed diagnostics:'
          for i, msg in ipairs(messages) do
            print(string.format('%d. %s', i, msg))
          end
        end
      end
    end)

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[f [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>c', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[f]ind [N]eovim files' })
  end,
}
