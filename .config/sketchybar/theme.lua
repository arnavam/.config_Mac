-- Live theme shared with JankyBorders. borders/color_script.sh writes
-- ~/.cache/theme/colors (key=0xAARRGGBB lines) and triggers theme_changed.
local colors = require("colors")

local theme = {
  file = os.getenv("HOME") .. "/.cache/theme/colors",
  current = {},
}

local defaults = {
  accent = colors.green,
  accent_soft = colors.white,
  bg = colors.bar.bg,
  bg_alt = colors.bg1,
  border = colors.bg2,
}

function theme.load()
  for key, value in pairs(defaults) do theme.current[key] = value end

  local file = io.open(theme.file, "r")
  if not file then return theme.current end
  for line in file:lines() do
    local key, value = line:match("^(%w[%w_]*)=(0x%x+)$")
    if key and theme.current[key] then theme.current[key] = tonumber(value) end
  end
  file:close()
  return theme.current
end

theme.load()
return theme
