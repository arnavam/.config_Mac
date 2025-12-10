return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  -- keys = { { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" }, },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    terminal = {
      win = {
        position = "float",
      },
    },
    bufdelete = { enabled = false },
    dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      }
    },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = true },
    picker = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    lazygit = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    image = {
      enabled = true,
      resolve = function(file, src)
        -- Example: if src is relative, resolve it to your custom image folder
        if not string.match(src, "^/") then
          local obsidian_img_dir = "/Users/arnav/Library/Mobile Documents/iCloud~md~obsidian/Documents/ML/Pics/"
          return obsidian_img_dir .. "/" .. src
        end
        return src -- already absolute, use as is
      end,
      latex = { font_size = "small" },
      img_dirs = { "/Users/arnav/Library/Mobile Documents/iCloud~md~obsidian/Documents/ML/Pics/" },
    },
  },
}
