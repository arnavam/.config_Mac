return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
      format = {
        cmdline = { pattern = "^:", icon = ":", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = " /", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = " ?", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua = { pattern = "^:%s*lua%s+", icon = "🌙", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "❓" },
      },
    },
    messages = {
      enabled = true,
      view = "mini",
      view_error = "notify",
      view_warn = "notify",
    },
		   notify = {
      enabled = true,
    },
    popupmenu = {
      enabled = true,
      backend = "nui",
    },
    views = {
      cmdline_popup = {
        position = {
          row = "10%",
          col = "50%",
        },
        size = {
          width = "50%",
          min_width = 60,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = {
            Normal = "Normal",
            FloatBorder = "FloatBorder",
          },
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = "50%",
          col = "50%",
        },
        size = {
          width = "60%",
          height = "auto",
          max_height = 15,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = {
            Normal = "Normal",
            FloatBorder = "FloatBorder",
            Pmenu = "Pmenu",
          },
        },
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = false,
      command_palette = false,
      long_message_to_split = true,
      inc_rename = false,
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- Uncomment if you want to use notifications
    -- "rcarriga/nvim-notify",
  },
}
