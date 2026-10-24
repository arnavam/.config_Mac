local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local theme = require("theme")
local style = require("style")
local app_icons = require("helpers.app_icons")

-- Space items mirror the live yabai space list. yabairc triggers
-- spaces_refresh on space_created / space_destroyed.
-- Left click focuses a space, right click destroys it, + creates one.
-- Inactive spaces show their apps as icons; the active space gets an accent
-- number with an accent underline, and its app icons collapse.

local spaces = {}
local apps = {}
local focused_sid = nil

sbar.add("event", "spaces_refresh")

local add_button = sbar.add("item", "separator", {
  icon = {
    string = icons.plus,
    font = settings.font .. ":Regular:17.0",
    color = colors.grey,
    padding_left = 10,
    padding_right = 14,
  },
  label = { drawing = false },
  associated_display = "active",
  click_script = "yabai -m space --create && sketchybar --trigger spaces_refresh",
})

local function render(sid)
  local space = spaces[sid]
  if not space then return end
  local selected = sid == focused_sid
  local strip = apps[sid] or ""
  local show_apps = not selected and strip ~= ""

  -- "dynamic" width can't be animated, so only the underline color animates
  space:set({
    icon = { highlight = selected, highlight_color = theme.current.accent },
    label = {
      string = strip,
      width = show_apps and "dynamic" or 0,
      padding_right = show_apps and 6 or 0,
    },
  })
  sbar.animate("tanh", 15, function()
    space:set({ background = { color = selected and theme.current.accent or colors.transparent } })
  end)
end

local function set_apps(sid, app_counts)
  -- Ligatures need a separator or the font can't shape them
  local names = {}
  for app, _ in pairs(app_counts or {}) do
    table.insert(names, app_icons[app] or ":default:")
  end
  table.sort(names)
  apps[sid] = table.concat(names, " ")
  render(sid)
end

local function add_space(sid)
  local space = sbar.add("space", "space." .. sid, {
    space = sid,
    icon = {
      string = tostring(sid),
      color = colors.grey,
      highlight_color = theme.current.accent,
      padding_left = 9,
      padding_right = 9,
    },
    label = {
      font = settings.app_font .. ":Regular:16.0",
      color = colors.grey,
      padding_left = 0,
      padding_right = 0,
      width = 0,
      y_offset = -1,
    },
    -- Item background drawn as a 2px underline below the number
    background = {
      color = colors.transparent,
      height = 2,
      corner_radius = 1,
      y_offset = -12,
      drawing = true,
    },
    padding_left = 3,
    padding_right = 3,
  })

  space:subscribe("space_change", function(env)
    if env.SELECTED == "true" then
      focused_sid = sid
    elseif focused_sid == sid then
      focused_sid = nil
    end
    render(sid)
  end)

  space:subscribe("mouse.clicked", function(env)
    if env.BUTTON == "right" then
      sbar.exec("yabai -m space --destroy " .. sid, function()
        sbar.trigger("spaces_refresh")
      end)
    else
      sbar.exec("yabai -m space --focus " .. sid .. " 2>/dev/null")
    end
  end)

  -- Hover: windows on this space as "App - title"
  local set_windows = style.popup_rows(space, 6, settings.font .. ":Light:13.0",
    settings.app_font .. ":Regular:14.0")
  style.hover(space, function()
    sbar.exec("yabai -m query --windows --space " .. sid, function(windows)
      if type(windows) ~= "table" or #windows == 0 then
        set_windows({ "Empty" })
        return
      end
      local rows = {}
      for _, w in ipairs(windows) do
        local text = w.app
        if w.title and w.title ~= "" and w.title ~= w.app then text = text .. " - " .. w.title end
        if utf8.len(text) and utf8.len(text) > 48 then text = text:sub(1, utf8.offset(text, 48) - 1) .. "…" end
        table.insert(rows, { icon = app_icons[w.app] or ":default:", label = text })
      end
      set_windows(rows)
    end)
  end)
  space:set({ popup = { align = "left" } })

  spaces[sid] = space
end

-- Fill every space's app strip from one yabai window query
local function load_apps()
  sbar.exec("yabai -m query --windows", function(windows)
    if type(windows) ~= "table" then return end
    local by_space = {}
    for _, w in ipairs(windows) do
      if not w["is-minimized"] and not w["is-hidden"] then
        by_space[w.space] = by_space[w.space] or {}
        by_space[w.space][w.app] = true
      end
    end
    for sid, _ in pairs(spaces) do
      set_apps(sid, by_space[sid])
    end
  end)
end

local function refresh()
  sbar.exec("yabai -m query --spaces", function(result)
    if type(result) ~= "table" then return end

    local want, order = {}, {}
    for _, s in ipairs(result) do
      want[s.index] = true
      table.insert(order, s.index)
      if s["has-focus"] then focused_sid = s.index end
    end
    table.sort(order)

    for sid, _ in pairs(spaces) do
      if not want[sid] then
        sbar.remove("/space\\." .. sid .. "\\.row\\..*/")
        sbar.remove(spaces[sid])
        spaces[sid] = nil
        apps[sid] = nil
      end
    end
    for _, sid in ipairs(order) do
      if not spaces[sid] then add_space(sid) end
    end

    -- Keep spaces in index order and in front of the + button
    local move = "sketchybar"
    for _, sid in ipairs(order) do
      move = move .. " --move space." .. sid .. " before separator"
    end
    sbar.exec(move, load_apps)
  end)
end

-- Native event: env.INFO = { space = <index>, apps = { [app] = count } }
add_button:subscribe("space_windows_change", function(env)
  if type(env.INFO) == "table" and env.INFO.space then
    set_apps(tonumber(env.INFO.space), env.INFO.apps)
  end
end)

add_button:subscribe({ "spaces_refresh", "display_change", "system_woke" }, refresh)

add_button:subscribe("theme_changed", function(env)
  if env.SENDER ~= "theme_changed" then return end
  theme.load()
  for sid, _ in pairs(spaces) do render(sid) end
end)

-- apple.logo .. separator spans every space between them
style.pill_bracket("group.spaces", { "apple.logo", "separator" })

refresh()
