local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local apple = sbar.add("item", "apple.logo", {
  icon = {
    string = icons.apple,
    font = settings.font .. ":Regular:18.0",
    color = colors.green,
    padding_left = 14,
    padding_right = 10,
  },
  label = { drawing = false },
  click_script = "sketchybar --set $NAME popup.drawing=toggle",
})

local function popup_entry(name, icon, label, command)
  sbar.add("item", name, {
    position = "popup." .. apple.name,
    icon = icon,
    label = label,
    click_script = command .. "; sketchybar --set apple.logo popup.drawing=off",
  })
end

popup_entry("apple.prefs", icons.preferences, "Preferences", "open -a 'System Settings'")
popup_entry("apple.activity", icons.activity, "Activity", "open -a 'Activity Monitor'")
popup_entry("apple.lock", icons.lock, "Lock Screen", "pmset displaysleepnow")
