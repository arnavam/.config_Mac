-- For lazy.nvim (in lua/plugins/auto-session.lua)
return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
     { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Search sessions" },
     { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
     { "<leader>wd", "<cmd>AutoSession delete<CR>", desc = "Delete session" },
     { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
  },
  opts = {
    auto_save = true,
    auto_restore = true,
    auto_create = true,
    cwd_change_handling = true,
    log_level = "error",
    session_lens = {
      picker = "telescope", -- or "fzf", "snacks"
      load_on_setup = true,
    },
    -- allowed_dirs = { "~/projects/*", "~/.config/nvim" },
     bypass_session_save_file_types = { "terminal" },
   suppressed_dirs = { "/tmp", "~/.cache" ,"~/.config/nvim","/Users/arnav/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/"}
  },
}

