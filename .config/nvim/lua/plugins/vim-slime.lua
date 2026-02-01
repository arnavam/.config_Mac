return {
    "jpalardy/vim-slime",
    keys = {
      -- Send selected text or current paragraph
      { "<leader>es", "<Plug>SlimeRegionSend", mode = { "n", "v" }, desc = "Slime Send" },
      -- Send current line
      { "<leader>el", "<cmd>SlimeSendCurrentLine<cr>", desc = "Slime Send Line" },
      -- Force Slime configuration prompt
      { "<leader>eC", "<cmd>SlimeConfig<cr>", desc = "Slime Config" },
    },
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_bracketed_paste = 4
      vim.g.slime_cell_delimiter = "# %%"
      vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = "{last}",
      }
    end,
}
