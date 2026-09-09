return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  -- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
  -- so `:ClaudeCode` and friends work on a fresh start. Without it, a keys-only
  -- spec defers loading until a <leader>a* mapping is pressed and the commands
  -- would not exist yet.
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSelectModel",
    "ClaudeCodeAdd",
    "ClaudeCodeSend",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeStatus",
    "ClaudeCodeStart",
    "ClaudeCodeStop",
    "ClaudeCodeOpen",
    "ClaudeCodeClose",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
    "ClaudeCodeCloseAllDiffs",
  },
  keys = {
    { "<leader>a", desc = "ai/claude code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "toggle claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "focus claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "resume claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "continue claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "select claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "send to claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "add file",
      ft = { "nvimtree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
    },
    -- diff management
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "deny diff" },
  },
}
