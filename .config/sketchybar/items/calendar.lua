local icons = require("icons")
local settings = require("settings")
local style = require("style")

local clock_font = settings.nerd_font .. ":Regular:17.0"

-- Added right to left: time is the rightmost pill
local time = style.pill_item("calendar", {
  position = "right",
  icon = { string = icons.clock, font = clock_font },
  update_freq = 30,
  updates = true,
})

local date = style.pill_item("date", {
  position = "right",
  icon = { string = icons.calendar, font = clock_font },
  updates = true,
})

local function update()
  time:set({ label = { string = os.date("%H:%M") } })
  date:set({ label = { string = os.date("%a %d %b") } })
end

time:subscribe({ "forced", "routine", "system_woke" }, update)
update()

-- Zen mode: click the time or date to hide everything except spaces and time
local zen = false
local zen_items = {
  "yabai", "front_app", "date", "battery", "volume", "wifi", "bluetooth",
  "separator_right", "cpu.percent", "memory", "disk",
}

local function set_zen(on)
  zen = on
  for _, item in ipairs(zen_items) do
    sbar.set(item, { drawing = not on })
  end

  if on then
    sbar.trigger("hide_stats")
    sbar.trigger("media_hide")
  else
    -- Stats stay collapsed; the media pill returns on the next spotify_change
    sbar.set("separator_right", { drawing = true })
  end
end

sbar.add("event", "zen_toggle")
time:subscribe("mouse.clicked", function() set_zen(not zen) end)
date:subscribe("mouse.clicked", function() set_zen(not zen) end)
time:subscribe("zen_toggle", function() set_zen(not zen) end)

-- Month view, plus today's events when icalBuddy is installed
style.hover_script(date, settings.config_dir .. "/helpers/scripts/calendar_info.sh", 14)
