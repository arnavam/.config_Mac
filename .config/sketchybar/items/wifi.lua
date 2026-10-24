local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local style = require("style")

-- One pill: wifi status icon (off / on / hotspot) + live up/down speed.
-- Not part of the stats toggle.
local providers = settings.config_dir .. "/helpers/event_providers"
local status_script = settings.config_dir .. "/helpers/scripts/wifi_status.sh"

local wifi = style.pill_item("wifi", {
  position = "right",
  icon = { string = icons.wifi.on, font = settings.nerd_font .. ":Regular:18.0" },
  label = { string = "↓0B ↑0B", width = 92, align = "right" },
  updates = true,
})

-- network_load measures one interface; restart it when the default route moves
local current_iface = nil
local function start_provider(iface)
  if iface == current_iface then return end
  current_iface = iface
  sbar.exec("pkill -x network_load; " .. providers .. "/network_load/bin/network_load "
    .. iface .. " network_update 2.0 &")
end

local function update_status()
  sbar.exec(status_script, function(result)
    local kind, iface = tostring(result):match("^(%a+)|(%w+)")
    kind = kind or "off"
    wifi:set({
      icon = {
        string = icons.wifi[kind] or icons.wifi.off,
        color = kind == "off" and colors.grey or nil,
      },
    })
    if iface then start_provider(iface) end
  end)
end

-- Provider sends e.g. "012KBps"; show it as "12K"
local function format_rate(raw)
  local value, unit = tostring(raw):match("(%d+)%s*(%a+)")
  if not value then return "0B" end
  return tonumber(value) .. unit:sub(1, 1)
end

sbar.add("event", "network_update")
wifi:subscribe("network_update", function(env)
  wifi:set({
    label = { string = "↓" .. format_rate(env.download) .. " ↑" .. format_rate(env.upload) },
  })
end)

wifi:subscribe({ "wifi_change", "system_woke", "forced" }, update_status)
update_status()

style.hover_script(wifi, settings.config_dir .. "/helpers/scripts/wifi_info.sh", 4)
