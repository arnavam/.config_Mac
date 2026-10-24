local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local theme = require("theme")
local style = require("style")
local app_icons = require("helpers.app_icons")

-- Global now-playing pill for any app (Music, Spotify, browsers, ...).
-- helpers/scripts/media_stream.sh wraps `media-control stream` and triggers
-- media_update; controls go through media-control too.
local scripts = settings.config_dir .. "/helpers/scripts"
local MC = "/opt/homebrew/bin/media-control "

sbar.add("event", "media_update")

local anchor = sbar.add("item", "media.anchor", {
  position = "center",
  icon = {
    string = icons.music,
    font = settings.nerd_font .. ":Regular:18.0",
    color = theme.current.accent,
    padding_left = 10,
  },
  label = { max_chars = 32, padding_right = 6 },
  scroll_texts = true,
  drawing = false,
  -- Hidden until something plays, so it must receive events while hidden
  updates = true,
  popup = { horizontal = true, align = "center", height = 200 },
})

local function inline_control(name, icon, command, padding_right)
  return sbar.add("item", name, {
    position = "center",
    icon = {
      string = icon,
      font = settings.font .. ":Regular:15.0",
      padding_left = 4,
      padding_right = padding_right or 4,
    },
    label = { drawing = false },
    drawing = false,
    click_script = MC .. command,
  })
end

local inline_back = inline_control("media.inline.back", icons.spotify.back, "previous-track")
local inline_play = inline_control("media.inline.play", icons.spotify.play, "toggle-play-pause")
local inline_next = inline_control("media.inline.next", icons.spotify.next, "next-track", 10)
local inline = { anchor, inline_back, inline_play, inline_next }

style.pill_bracket("group.media", { anchor.name, inline_next.name })

-- Popup: cover, title / artist / album, progress slider, control row
local popup = "popup." .. anchor.name

local cover = sbar.add("item", "media.cover", {
  position = popup,
  icon = { drawing = false },
  label = { drawing = false },
  padding_left = 12,
  padding_right = 10,
  background = {
    height = 120,
    image = { scale = 0.2, drawing = true, corner_radius = 8 },
    drawing = true,
  },
})

local function text_line(name, y_offset, font)
  return sbar.add("item", name, {
    position = popup,
    icon = { drawing = false },
    label = { font = font, max_chars = 28 },
    padding_left = 0,
    padding_right = 0,
    width = 0,
    y_offset = y_offset,
  })
end

local title = text_line("media.title", 55, settings.font .. ":Medium:16.0")
local artist = text_line("media.artist", 30, settings.font .. ":Light:14.0")
local album = text_line("media.album", 10, settings.font .. ":Light:13.0")

local progress = sbar.add("slider", "media.progress", 140, {
  position = popup,
  icon = { string = "0:00", font = settings.font .. ":Light:11.0", width = 38 },
  label = { string = "0:00", font = settings.font .. ":Light:11.0", width = 38 },
  padding_left = 0,
  padding_right = 0,
  y_offset = -15,
  width = 0,
  slider = {
    background = { height = 5, corner_radius = 3, color = colors.grey },
    highlight_color = theme.current.accent,
    percentage = 0,
  },
  update_freq = 1,
  updates = "when_shown",
})

local function control(name, icon, command)
  return sbar.add("item", name, {
    position = popup,
    icon = {
      string = icon,
      padding_left = 6,
      padding_right = 6,
      color = colors.white,
      highlight_color = theme.current.accent,
    },
    label = { drawing = false },
    y_offset = -45,
    click_script = MC .. command,
  })
end

local shuffle = control("media.shuffle", icons.spotify.shuffle, "toggle-shuffle")
control("media.back", icons.spotify.back, "previous-track")
local play = control("media.play", icons.spotify.play, "toggle-play-pause")
local next_item = control("media.next", icons.spotify.next, "next-track")
local repeat_mode = control("media.repeat", icons.spotify["repeat"], "toggle-repeat")
sbar.add("item", "media.spacer", { position = popup, width = 50 })

sbar.add("bracket", "media.controls", {
  shuffle.name, "media.back", play.name, next_item.name, repeat_mode.name,
}, {
  background = { color = theme.current.bg_alt, corner_radius = 10, height = 28, y_offset = -45, drawing = true },
})

local function show_inline(on)
  for _, item in ipairs(inline) do item:set({ drawing = on }) end
end

-- Bundle id -> app name (for the app icon), resolved once through Spotlight
local app_names = {
  ["com.apple.Music"] = "Music",
  ["com.spotify.client"] = "Spotify",
  ["com.apple.Safari"] = "Safari",
  ["com.apple.podcasts"] = "Podcasts",
  ["com.google.Chrome"] = "Google Chrome",
  ["app.zen-browser.zen"] = "Zen",
  ["company.thebrowser.Browser"] = "Arc",
  ["org.mozilla.firefox"] = "Firefox",
}
local current_bundle = nil

local function set_app_icon(bundle)
  local function apply(name)
    local icon = name and app_icons[name]
    anchor:set({
      icon = icon and { string = icon, font = settings.app_font .. ":Regular:16.0" }
        or { string = icons.music, font = settings.nerd_font .. ":Regular:18.0" },
    })
  end

  if app_names[bundle] ~= nil then return apply(app_names[bundle]) end
  sbar.exec("mdfind \"kMDItemCFBundleIdentifier == '" .. bundle:gsub("[^%w%.%-_]", "")
    .. "'\" | head -n1 | xargs -I{} basename {} .app", function(name)
      app_names[bundle] = tostring(name):gsub("%s+$", "")
      apply(app_names[bundle])
    end)
end

local function format_time(seconds)
  seconds = math.floor(tonumber(seconds) or 0)
  return string.format("%d:%02d", seconds // 60, seconds % 60)
end

local duration = 0

-- Hide when nothing is playing. Pauses wait a few seconds first, since
-- players report a brief pause between tracks.
local hide_token = 0
local function hide_later()
  hide_token = hide_token + 1
  local token = hide_token
  sbar.delay(3, function()
    if token ~= hide_token then return end
    show_inline(false)
    anchor:set({ popup = { drawing = false } })
  end)
end

anchor:subscribe("media_update", function(env)
  if env.playing == "none" or (env.title or "") == "" or env.playing == "false" then
    hide_later()
    if env.playing ~= "false" then return end
  else
    hide_token = hide_token + 1
  end

  local playing = env.playing == "true"
  local play_icon = playing and icons.spotify.pause or icons.spotify.play
  local now_playing = env.title
  if (env.artist or "") ~= "" then now_playing = now_playing .. " - " .. env.artist end

  duration = tonumber(env.duration) or 0
  anchor:set({ label = { string = now_playing } })
  inline_play:set({ icon = { string = play_icon } })
  play:set({ icon = { string = play_icon } })
  title:set({ label = { string = env.title } })
  artist:set({ label = { string = env.artist or "" } })
  album:set({ label = { string = env.album or "" } })
  shuffle:set({ icon = { highlight = (env.shuffle or "1") ~= "1" } })
  repeat_mode:set({ icon = { highlight = (env["repeat"] or "1") ~= "1" } })
  cover:set({ background = { image = { string = env.cover ~= "" and env.cover or "" } } })

  if env.bundle and env.bundle ~= "" and env.bundle ~= current_bundle then
    current_bundle = env.bundle
    set_app_icon(env.bundle)
  end
  if playing then show_inline(true) end
end)

-- Progress only updates while the popup is visible
progress:subscribe("routine", function()
  sbar.exec(scripts .. "/media_position.sh", function(result)
    local elapsed, total = tostring(result):match("(%d+)|(%d+)")
    elapsed, total = tonumber(elapsed), tonumber(total)
    if not total or total == 0 then return end
    progress:set({
      slider = { percentage = math.floor(elapsed * 100 / total) },
      icon = { string = format_time(elapsed) },
      label = { string = format_time(total) },
    })
  end)
end)

progress:subscribe("mouse.clicked", function(env)
  local percentage = tonumber(env.PERCENTAGE) or 0
  sbar.exec(MC .. "seek " .. math.floor(duration * percentage / 100))
  progress:set({ slider = { percentage = percentage } })
end)

sbar.add("event", "media_hide")
anchor:subscribe("media_hide", function()
  show_inline(false)
  anchor:set({ popup = { drawing = false } })
end)

-- Click the title to open the app that is playing
anchor:subscribe("mouse.clicked", function()
  if current_bundle then sbar.exec("open -b '" .. current_bundle:gsub("[^%w%.%-_]", "") .. "'") end
end)

style.hover(anchor, nil, true)
anchor:set({ popup = { align = "center" } })

-- Start the stream once the event loop runs, so its first update (the
-- current track) reaches the subscriptions above
sbar.delay(0.5, function()
  -- media_stream.sh replaces its previous instance through a pidfile
  sbar.exec(scripts .. "/media_stream.sh >/dev/null 2>&1 &")
end)
