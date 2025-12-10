return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local ibl = require("ibl")
    local highlight_groups = { "CursorColumn", "Whitespace" }

    ibl.setup {
      indent = {
        char = "", --"│",
        highlight = highlight_groups,
      },
      whitespace = {
        highlight = highlight_groups,
        remove_blankline_trail = true,
      },
      scope = {
        enabled = true,
      },
      exclude = {
        buftypes = { "terminal", "nofile" },
      },
      debounce = 200,
    }

    vim.keymap.set("n", "<leader>u", "<cmd>IBLToggle<cr>", { desc = "Toggle indent guides" })
  end,
}

