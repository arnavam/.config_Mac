local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local style = require("style")

local providers = settings.config_dir .. "/helpers/event_providers"
local icon_font = settings.nerd_font .. ":Regular:17.0"

-- C event provider pushes cpu_update events, no shell polling.
-- network_load is started by items/wifi.lua.
sbar.add("event", "cpu_update")
sbar.exec("pkill -x cpu_load; " .. providers .. "/cpu_load/bin/cpu_load cpu_update 2.0 &")

-- Added right to left: cpu, ram, disk, then the collapse chevron
local cpu = style.pill_item("cpu.percent", {
  position = "right",
  icon = { string = icons.cpu, font = icon_font },
  label = { string = "--%", width = 38, align = "right" },
  updates = true,
})

local memory = style.pill_item("memory", {
  position = "right",
  icon = { string = icons.ram, font = icon_font },
  label = { width = 38, align = "right" },
  update_freq = 5,
})

local disk = style.pill_item("disk", {
  position = "right",
  icon = { string = icons.disk, font = icon_font },
  label = { width = 38, align = "right" },
  update_freq = 60,
})

local toggle = sbar.add("item", "separator_right", {
  position = "right",
  icon = {
    string = icons.stats.expanded,
    font = settings.font .. ":Regular:15.0",
    color = colors.grey,
    padding_left = 4,
    padding_right = 4,
  },
  label = { drawing = false },
  padding_right = 2,
})

cpu:subscribe("cpu_update", function(env)
  local load = tonumber(env.total_load) or 0
  local color = colors.white
  if load >= 70 then color = colors.red
  elseif load >= 30 then color = colors.orange
  elseif load >= 10 then color = colors.yellow
  end
  cpu:set({ label = { string = load .. "%", color = color } })
end)

memory:subscribe({ "routine", "forced" }, function()
  sbar.exec("memory_pressure | awk '/free percentage/ { printf \"%.0f\", 100 - $5 }'", function(used)
    memory:set({ label = { string = tostring(used):gsub("%s", "") .. "%" } })
  end)
end)

disk:subscribe({ "routine", "forced" }, function()
  sbar.exec("df -H / | awk 'NR==2 { print $5 }'", function(used)
    disk:set({ label = { string = (tostring(used):gsub("%s", "")) } })
  end)
end)

-- Collapse / expand the stats pills
local stats = { cpu, memory, disk }
local expanded = true

local function set_expanded(on)
  expanded = on
  for _, item in ipairs(stats) do
    item:set({ drawing = on })
  end
  toggle:set({ icon = { string = on and icons.stats.expanded or icons.stats.collapsed } })
end

sbar.add("event", "hide_stats")
sbar.add("event", "show_stats")
sbar.add("event", "toggle_stats")

toggle:subscribe("mouse.clicked", function() set_expanded(not expanded) end)
toggle:subscribe("toggle_stats", function() set_expanded(not expanded) end)
toggle:subscribe("hide_stats", function() set_expanded(false) end)
toggle:subscribe("show_stats", function() set_expanded(true) end)

-- Collapsed by default; click the chevron to show disk, RAM and CPU
set_expanded(false)

local top = settings.config_dir .. "/helpers/scripts/top_procs.sh"
style.hover_script(cpu, top .. " cpu", 5)
style.hover_script(memory, top .. " mem", 5)
