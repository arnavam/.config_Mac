-- lazy.nvim
return {
  "olimorris/codecompanion.nvim",
  tag = 'v17.33.0',
  ignore_warnings = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "github/copilot.vim",
      {
        "saghen/blink.cmp",
        lazy = false,
        version = "*",
        opts = {
          keymap = {
            preset = "enter",
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
          },
          cmdline = { sources = { "cmdline" } },
          sources = {
            default = { "lsp", "path", "buffer", "codecompanion" },
          },
        },
      },
  },
  opts = {
      strategies = {
        --NOTE: Change the adapter as required
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
      },
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = "DEBUG", -- or "TRACE"
    },
  },
}

