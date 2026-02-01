return { -- Autocompletion
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  -- build = 'cargo build --release',
  dependencies = {
    -- Snippet Engine
    --
    'onsails/lspkind.nvim',
    'folke/lazydev.nvim',
    'mfussenegger/nvim-dap',

    'rcarriga/cmp-dap',
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      opts = {},
    },
    {
      'saghen/blink.compat',
      -- optional = true, -- make optional so it's only enabled if any extras need it
      -- 
      opts = {},
      version = not vim.g.lazyvim_blink_main and '*',
    },
  },
  -- @module 'blink.:cmp'
  -- @type blink.cmp.Config

  opts = {

    keymap = {
      preset = 'super-tab', -- 'default', 'super-tab', 'enter', 'none'
    },

    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
    },
    completion = {

      accept = { auto_brackets = { enabled = true } },

      -- list = {
      --     selection = function(ctx)
      --         return ctx.mode == "cmdline" and "auto_insert" or "preselect"
      --     end,
      -- },

      menu = {
        auto_show = true,
        border = 'rounded',
        auto_show_delay_ms = 500,

        cmdline_position = function()
          if vim.g.ui_cmdline_pos ~= nil then
            local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
            return { pos[1] - 1, pos[2] }
          end
          local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
          return { vim.o.lines - height, 0 }
        end,
        draw = {
          columns = {
            { 'label', 'label_description', gap = 1 },
            { 'kind_icon', 'kind', gap = 1 },
          },
        },
      },
      documentation = { auto_show = false, auto_show_delay_ms = 1000, treesitter_highlighting = true, window = { border = 'rounded' } },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        -- dap = {
        --   name = 'dap',
        --   module = 'blink.compat.source',
        --   enabled = function()
        --     return require('cmp_dap').is_dap_buffer()
        --   end,
        -- },
      },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = { implementation = 'lua' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true, window = { border = 'rounded' } },
  },
}
