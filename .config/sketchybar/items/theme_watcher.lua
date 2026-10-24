local theme = require("theme")
local style = require("style")

-- Recolor bar and every registered pill when borders/color_script.sh
-- publishes a new theme
local function apply()
  local t = theme.load()
  for _, name in ipairs(style.pills) do
    sbar.set(name, { background = { color = t.bg } })
  end
  for _, name in ipairs({ "cpu.percent", "memory", "disk", "calendar", "date", "media.anchor" }) do
    sbar.set(name, { icon = { color = t.accent } })
  end
  for _, name in ipairs({ "media.progress", "volume.master", "volume.app" }) do
    sbar.set(name, { slider = { highlight_color = t.accent } })
  end
end

local watcher = sbar.add("item", "theme.watcher", { drawing = false, updates = true })
sbar.add("event", "theme_changed")
watcher:subscribe("theme_changed", function(env)
  if env.SENDER == "theme_changed" then apply() end
end)
