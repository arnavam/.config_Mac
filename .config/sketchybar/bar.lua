local colors = require("colors")

sbar.bar({
  height = 42,
  -- Transparent bar, every pill carries its own background
  color = colors.transparent,
  border_width = 0,
  shadow = false,
  position = "top",
  sticky = true,
  padding_left = 6,
  padding_right = 6,
  y_offset = 4,
  margin = 8,
  notch_width = 0,
})
