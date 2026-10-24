local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")
local style = require("style")

-- yabai window state: icon + color, and the matching JankyBorders color
-- Spacer so the spaces pill and this pill don't touch
sbar.add("item", "gap.left", { width = 8 })

local yabai = sbar.add("item", "yabai", {
  icon = {
    string = icons.yabai.grid,
    font = settings.font .. ":Regular:17.0",
    color = colors.orange,
    padding_left = 10,
    padding_right = 4,
  },
  label = { drawing = false },
  associated_display = "active",
})

local front_app = sbar.add("item", "front_app", {
  icon = {
    font = settings.app_font .. ":Regular:17.0",
    padding_right = 2,
  },
  label = {
    color = colors.white,
    padding_right = 10,
    max_chars = 24,
  },
  associated_display = "active",
  updates = true,
})

local bordersrc = os.getenv("HOME") .. "/.config/borders/bordersrc"

-- Read on every call because borders/color_script.sh rewrites it with a random hue
local function default_border()
  local file = io.open(bordersrc, "r")
  if not file then return colors.white end
  local content = file:read("a")
  file:close()
  return content:match("[^n]active_color=(0x%x+)") or colors.white
end

local function set_border(color)
  sbar.exec(string.format(
    "pgrep -x borders >/dev/null && borders active_color=0x%08x", color))
end

local function window_state()
  sbar.exec("yabai -m query --windows --window 2>/dev/null", function(window)
    if type(window) ~= "table" then
      yabai:set({ icon = { string = icons.yabai.grid, color = colors.orange }, label = { drawing = false } })
      return
    end

    if (window["stack-index"] or 0) > 0 then
      sbar.exec("yabai -m query --windows --window stack.last", function(last)
        local total = type(last) == "table" and last["stack-index"] or window["stack-index"]
        yabai:set({
          icon = { string = icons.yabai.stack, color = colors.red },
          label = { drawing = true, string = string.format("[%d/%d]", window["stack-index"], total) },
        })
      end)
      set_border(colors.red)
      return
    end

    local icon, color, border
    if window["is-floating"] then
      icon, color, border = icons.yabai.float, colors.magenta, colors.magenta
    elseif window["has-fullscreen-zoom"] then
      icon, color, border = icons.yabai.fullscreen_zoom, colors.green, colors.green
    elseif window["has-parent-zoom"] then
      icon, color, border = icons.yabai.parent_zoom, colors.blue, colors.blue
    else
      icon, color = icons.yabai.grid, colors.orange
      border = tonumber(default_border()) or colors.white
    end

    yabai:set({ icon = { string = icon, color = color }, label = { drawing = false } })
    set_border(border)
  end)
end

sbar.add("event", "window_focus")
yabai:subscribe("window_focus", window_state)
yabai:subscribe("mouse.clicked", function()
  sbar.exec("yabai -m window --toggle float", window_state)
end)

front_app:subscribe("front_app_switched", function(env)
  front_app:set({
    icon = { string = app_icons[env.INFO] or ":default:" },
    label = { string = env.INFO },
  })
end)

style.pill_bracket("group.front_app", { "yabai", "front_app" })
