local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local theme = require("theme")
local style = require("style")

-- Volume pill. Scroll to change, click to mute, hover for sliders and the
-- output device list. When Background Music is running the system output
-- is its virtual device, so the real device and per-app volume go through
-- its AppleScript API instead of SwitchAudioSource.
local volume = style.pill_item("volume", {
  position = "right",
  icon = { string = icons.volume._100, font = settings.nerd_font .. ":Regular:18.0" },
  label = { string = "--%", width = 38, align = "right" },
  updates = true,
})

local popup = "popup." .. volume.name

local function slider(name, icon)
  return sbar.add("slider", name, 160, {
    position = popup,
    icon = { string = icon, padding_left = 10, width = 70, font = settings.font .. ":Light:13.0" },
    label = { drawing = false },
    slider = {
      background = { height = 5, corner_radius = 3, color = colors.grey },
      highlight_color = theme.current.accent,
      knob = { string = "􀀁", drawing = true },
    },
    padding_right = 10,
  })
end

local master = slider("volume.master", "Main")
local app_slider = slider("volume.app", "App")
local set_devices = style.popup_rows(volume, 6, settings.font .. ":Light:13.0")

local function bgm_tell(command, callback)
  sbar.exec("osascript -e 'tell application \"Background Music\" to " .. command .. "' 2>/dev/null", callback)
end

local function level_icon(level)
  if level >= 60 then return icons.volume._100
  elseif level >= 30 then return icons.volume._66
  elseif level > 0 then return icons.volume._33
  end
  return icons.volume._0
end

local function show_level(level)
  volume:set({
    icon = { string = level_icon(level), color = level == 0 and colors.grey or theme.current.accent },
    label = { string = level .. "%" },
  })
  master:set({ slider = { percentage = level } })
end

volume:subscribe("volume_change", function(env) show_level(tonumber(env.INFO) or 0) end)

-- volume_change only fires on changes, so read the level once at startup
sbar.exec("osascript -e 'output volume of (get volume settings)'", function(level)
  show_level(tonumber(tostring(level):match("%d+")) or 0)
end)

volume:subscribe("mouse.scrolled", function(env)
  local delta = (tonumber(env.SCROLL_DELTA) or 0) * 2
  sbar.exec("osascript -e 'set volume output volume (output volume of (get volume settings) + " .. delta .. ")'")
end)

volume:subscribe("mouse.clicked", function()
  sbar.exec("osascript -e 'set volume output muted (not (output muted of (get volume settings)))'")
end)

master:subscribe("mouse.clicked", function(env)
  sbar.exec("osascript -e 'set volume output volume " .. (tonumber(env.PERCENTAGE) or 0) .. "'")
end)

-- Per-app volume for the app that is playing media (Background Music only)
local media_bundle = nil
volume:subscribe("media_update", function(env)
  if env.bundle and env.bundle ~= "" then media_bundle = env.bundle:gsub("[^%w%.%-_]", "") end
end)

local function app_target()
  return '(first audio application whose bundleID is "' .. media_bundle .. '")'
end

app_slider:subscribe("mouse.clicked", function(env)
  if not media_bundle then return end
  local percentage = tonumber(env.PERCENTAGE) or 50
  bgm_tell("set vol of " .. app_target() .. " to " .. percentage)
  app_slider:set({ slider = { percentage = percentage } })
end)

local function safe(name)
  return tostring(name):gsub("[\"'\\]", "")
end

local function fill_popup()
  sbar.exec("pgrep -x 'Background Music' >/dev/null && echo yes || echo no", function(bgm)
    local has_bgm = tostring(bgm):match("yes") ~= nil

    if has_bgm and media_bundle then
      bgm_tell("get vol of " .. app_target(), function(vol)
        app_slider:set({ drawing = true, slider = { percentage = tonumber(tostring(vol):match("%d+")) or 50 } })
      end)
    else
      app_slider:set({ drawing = false })
    end

    local list_cmd = has_bgm
      and "osascript -e 'tell application \"Background Music\" to get name of every output device' -e 'tell application \"Background Music\" to get name of selected output device'"
      or "SwitchAudioSource -a -t output | paste -sd, - ; SwitchAudioSource -c -t output"

    sbar.exec(list_cmd, function(result)
      local lines = {}
      for line in tostring(result):gmatch("[^\n]+") do table.insert(lines, line) end
      local current = lines[2] or ""
      local rows = {}
      for raw in (lines[1] or ""):gmatch("[^,]+") do
        local device = raw:gsub("^%s+", ""):gsub("%s+$", "")
        if device ~= "" and device ~= "Background Music" then
          local click = has_bgm
            and "osascript -e 'tell application \"Background Music\" to set selected output device to (first output device whose name is \"" .. safe(device) .. "\")'"
            or "SwitchAudioSource -t output -s '" .. safe(device) .. "'"
          table.insert(rows, {
            icon = device == current and icons.check or icons.speaker,
            label = device,
            click = click .. "; sketchybar --set volume popup.drawing=off",
          })
        end
      end
      set_devices(rows)
    end)
  end)
end

style.hover(volume, fill_popup, true)
