-- Shared look for the pill layout. The bar is transparent, so pills use the
-- dark theme background to stay readable on any wallpaper. Items register what they theme so
-- items/theme_watcher.lua can recolor them on theme_changed.
local theme = require("theme")

local style = {
  pill_height = 30,
  pill_radius = 9,
  gap = 4,
  pills = {},
}

-- Background for a pill. Use on single items or on brackets.
function style.pill()
  return {
    color = theme.current.bg,
    height = style.pill_height,
    corner_radius = style.pill_radius,
    border_width = 0,
    drawing = true,
  }
end

function style.register(name)
  table.insert(style.pills, name)
  return name
end

-- Single-item pill: icon + label inside one rounded background
function style.pill_item(name, props)
  props.background = style.pill()
  props.padding_left = props.padding_left or style.gap
  props.padding_right = props.padding_right or style.gap
  props.icon = props.icon or {}
  props.icon.padding_left = props.icon.padding_left or 10
  props.icon.color = props.icon.color or theme.current.accent
  props.label = props.label or {}
  props.label.padding_right = props.label.padding_right or 10
  local item = sbar.add("item", name, props)
  style.register(name)
  return item
end

-- Bracket pill around several items
function style.pill_bracket(name, members)
  sbar.add("bracket", name, members, { background = style.pill() })
  return style.register(name)
end

-- Hover popup. on_open(item) fills the popup each time it opens. Interactive
-- popups stay open while the mouse is inside them and close on
-- mouse.exited.global; info popups close as soon as the mouse leaves the item.
-- A short delay avoids flashing popups when the mouse just passes over.
-- Overlapping popups never get their own exit event, so entering or opening
-- one popup closes all the others.
local closers = {}

function style.hover(item, on_open, interactive)
  local hovering = false
  item:set({ popup = { align = "right" } })

  local function close()
    hovering = false
    item:set({ popup = { drawing = false } })
  end

  local function close_others()
    for other, fn in pairs(closers) do
      if other ~= item.name then fn() end
    end
  end
  closers[item.name] = close

  item:subscribe("mouse.entered", function()
    close_others()
    hovering = true
    sbar.delay(0.3, function()
      if not hovering then return end
      close_others()
      if on_open then on_open(item) end
      item:set({ popup = { drawing = true } })
    end)
  end)

  item:subscribe("mouse.exited.global", close)
  if interactive then
    item:subscribe("mouse.exited", function() hovering = false end)
  else
    item:subscribe("mouse.exited", close)
  end
end

-- Fixed pool of text rows inside an item's popup. Returns set(rows) where
-- rows is a list of strings or { icon =, label =, click = } tables.
function style.popup_rows(parent, count, font, icon_font)
  local rows = {}
  for i = 1, count do
    rows[i] = sbar.add("item", parent.name .. ".row." .. i, {
      position = "popup." .. parent.name,
      icon = { drawing = false, padding_left = 10, font = icon_font },
      label = { font = font, padding_left = 10, padding_right = 10 },
      drawing = false,
    })
  end

  return function(lines)
    for i = 1, count do
      local line = lines[i]
      if line == nil then
        rows[i]:set({ drawing = false })
      else
        if type(line) == "string" then line = { label = line } end
        rows[i]:set({
          drawing = true,
          icon = { string = line.icon or "", drawing = line.icon ~= nil },
          label = { string = line.label or "" },
          click_script = line.click or "",
        })
      end
    end
  end
end

-- Info popup filled from a script's output, one row per line
function style.hover_script(item, command, count, font)
  local set_rows = style.popup_rows(item, count, font)
  style.hover(item, function()
    sbar.exec(command, function(result)
      local lines = {}
      for line in tostring(result):gmatch("([^\n]*)\n?") do
        if #lines < count then table.insert(lines, line == "" and " " or line) end
      end
      while #lines > 0 and lines[#lines] == " " do table.remove(lines) end
      set_rows(lines)
    end)
  end)
end

return style
