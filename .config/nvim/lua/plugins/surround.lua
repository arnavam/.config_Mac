return {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup{
        -- Configuration here, or leave empty to use defaults
         keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "vs",
        normal_cur = "vss",
        normal_line = "vS",
        normal_cur_line = "vSS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
        change_line = "cS",
    },

      }
    end
}
