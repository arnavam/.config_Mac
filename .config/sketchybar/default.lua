local colors = require("colors")
local settings = require("settings")

sbar.default({
  updates = "when_shown",
  icon = {
    font = settings.font .. ":Regular:16.0",
    color = colors.white,
    padding_left = 4,
    padding_right = 4,
  },
  label = {
    font = settings.font .. ":Light:15.0",
    color = colors.white,
    padding_left = 4,
    padding_right = 4,
  },
  padding_left = 0,
  padding_right = 0,
  background = { height = 30, corner_radius = 9 },
  popup = {
    background = {
      border_width = 1,
      corner_radius = 10,
      border_color = colors.bg2,
      color = colors.popup.bg,
      shadow = { drawing = true },
    },
    blur_radius = 20,
  },
})
