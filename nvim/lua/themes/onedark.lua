
return {
  "navarasu/onedark.nvim",
  priority = 1000, -- Ensures the theme loads first
  config = function()
    require("onedark").setup {
      style = "dark",
    }
    require("onedark").load()
  end
}
