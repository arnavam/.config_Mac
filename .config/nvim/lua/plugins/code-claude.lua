return { "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  -- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
  -- so `:claudecode` and friends work on a fresh start. without it, a keys-only
  -- spec defers loading until a <leader>a* mapping is pressed and the commands
  -- would not exist yet.
  cmd = {
    "claudecode",
    "claudecodefocus",
    "claudecodeselectmodel",
    "claudecodeadd",
    "claudecodesend",
    "claudecodetreeadd",
    "claudecodestatus",
    "claudecodestart",
    "claudecodestop",
    "claudecodeopen",
    "claudecodeclose",
    "claudecodediffaccept",
    "claudecodediffdeny",
    "claudecodeclosealldiffs",
  },
  keys = {
    { "<leader>a", nil, desc = "ai/claude code" },
    { "<leader>ac", "<cmd>claudecode<cr>", desc = "toggle claude" },
    { "<leader>af", "<cmd>claudecodefocus<cr>", desc = "focus claude" },
    { "<leader>ar", "<cmd>claudecode --resume<cr>", desc = "resume claude" },
    { "<leader>ac", "<cmd>claudecode --continue<cr>", desc = "continue claude" },
    { "<leader>am", "<cmd>claudecodeselectmodel<cr>", desc = "select claude model" },
    { "<leader>ab", "<cmd>claudecodeadd %<cr>", desc = "add current buffer" },
    { "<leader>as", "<cmd>claudecodesend<cr>", mode = "v", desc = "send to claude" },
    {
      "<leader>as",
      "<cmd>claudecodetreeadd<cr>",
      desc = "add file",
      ft = { "nvimtree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
    },
    -- diff management
    { "<leader>aa", "<cmd>claudecodediffaccept<cr>", desc = "accept diff" },
    { "<leader>ad", "<cmd>claudecodediffdeny<cr>", desc = "deny diff" },
  },
}
