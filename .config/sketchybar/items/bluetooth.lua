local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local style = require("style")

-- No native bluetooth event, so poll. Needs blueutil (brew install blueutil).
local blueutil = "/opt/homebrew/bin/blueutil"

local bluetooth = style.pill_item("bluetooth", {
  position = "right",
  icon = {
    string = icons.bluetooth.on,
    font = settings.nerd_font .. ":Regular:18.0",
    padding_right = 8,
  },
  label = { max_chars = 14, drawing = false },
  update_freq = 10,
  updates = true,
  click_script = "open 'x-apple.systempreferences:com.apple.BluetoothSettings'",
})

local function update()
  sbar.exec(blueutil .. " --power", function(power)
    if tostring(power):match("^%s*1") == nil then
      bluetooth:set({
        icon = { string = icons.bluetooth.off, color = colors.grey },
        label = { string = "", drawing = false },
      })
      return
    end

    sbar.exec(blueutil .. " --connected --format json", function(devices)
      if type(devices) ~= "table" or #devices == 0 then
        bluetooth:set({
          icon = { string = icons.bluetooth.on, color = colors.white },
          label = { string = "", drawing = false },
        })
        return
      end

      -- First connected device name, plus a count when there are more
      local label = devices[1].name or "Device"
      if #devices > 1 then label = label .. " +" .. (#devices - 1) end
      bluetooth:set({
        icon = { string = icons.bluetooth.connected, color = colors.blue },
        label = { string = label, drawing = true },
      })
    end)
  end)
end

bluetooth:subscribe({ "routine", "forced", "system_woke" }, update)
update()

-- Hover: paired devices, click one to connect or disconnect it
local set_devices = style.popup_rows(bluetooth, 8)

style.hover(bluetooth, function()
  sbar.exec(blueutil .. " --paired --format json", function(devices)
    if type(devices) ~= "table" or #devices == 0 then
      set_devices({ "No paired devices" })
      return
    end
    local rows = {}
    for _, device in ipairs(devices) do
      local address = tostring(device.address or ""):gsub("[^%x%-:]", "")
      local action = device.connected and "--disconnect" or "--connect"
      table.insert(rows, {
        icon = device.connected and icons.bluetooth.connected or icons.bluetooth.on,
        label = device.name or address,
        click = blueutil .. " " .. action .. " " .. address .. "; sketchybar --set bluetooth popup.drawing=off",
      })
    end
    set_devices(rows)
  end)
end, true)
