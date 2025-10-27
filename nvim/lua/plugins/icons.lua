-- In your lua/plugins/icons.lua file
return {
  -- Install and configure nvim-web-devicons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      -- Your overrides for specific filetypes can go here
    override = {
      -- PyTorch file extensions
      pt = {
        icon = "󰚀",  -- Neural network icon
        color = "#ee4c2c",  -- PyTorch orange-red
        name = "PyTorch"
      },
      pth = {
        icon = "󰚀",
        color = "#ee4c2c",
        name = "PyTorchModel"
      },
      ckpt = {
        icon = "󰑭",  -- Checkpoint icon
        color = "#ff6b35",
        name = "Checkpoint"
      },
      safetensors = {
        icon = "󰛩",  -- Safe/secure icon
        color = "#00a8ff",
        name = "SafeTensors"
      },
    },
    default = true
  }
  },

  -- Then, setup nvim-nonicons to build upon it
  -- {
  --   "yamatsum/nvim-nonicons",
  --   dependencies = { "nvim-tree/nvim-web-devicons" }, -- Ensure this dependency is declared
  --   config = function()
  --     require("nvim-nonicons").setup({})
  --     -- You may also need to extend the icons to other plugins
  --     -- For example, for neo-tree:
  --     -- local nonicons_extention = require("nvim-nonicons.extentions.nvim-tree")
  --     -- Then pass `nonicons_extention.glyphs` to your neo-tree setup
  --   end,
  -- }
}
