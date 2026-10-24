local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local style = require("style")

local battery = style.pill_item("battery", {
  position = "right",
  icon = { font = settings.font .. ":Regular:19.0" },
  update_freq = 120,
  updates = true,
})

local function update()
  sbar.exec("pmset -g batt", function(batt)
    local percentage = tonumber(tostring(batt):match("(%d+)%%"))
    if not percentage then return end

    local icon, color
    if percentage >= 90 then
      icon, color = icons.battery._100, colors.green
    elseif percentage >= 60 then
      icon, color = icons.battery._75, colors.green
    elseif percentage >= 30 then
      icon, color = icons.battery._50, colors.yellow
    elseif percentage >= 10 then
      icon, color = icons.battery._25, colors.orange
    else
      icon, color = icons.battery._0, colors.red
    end

    if tostring(batt):find("AC Power") then
      icon, color = icons.battery.charging, colors.green
    end

    battery:set({
      icon = { string = icon, color = color },
      label = { string = percentage .. "%" },
    })
  end)
end

battery:subscribe({ "routine", "forced", "power_source_change", "system_woke" }, update)
update()

style.hover_script(battery, settings.config_dir .. "/helpers/scripts/battery_info.sh", 5)
