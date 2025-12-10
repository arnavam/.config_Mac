return {
  "folke/zen-mode.nvim",
  opts = {

  window = {
    backdrop = 0.5, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 120, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      cursorline = false, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = true, -- disables the command in the last line of the screen
      laststatus = 0, -- turn off the statusline in zen mode
    },
    twilight = { enabled = false}, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = true }, -- disables the tmux statusline
    todo = { enabled = false }, -- if set to "true", todo-comments.nvim highlights will be disabled
    kitty = {
      enabled = false,
      font = "+4", -- font size increment
    },
    alacritty = {
      enabled = false,
      font = "14", -- font size
    },
    wezterm = {
      enabled = false,
      font = "+4", -- (10% increase per step)
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
    vim.fn.system("tmux set status on")
  end,

}  }

