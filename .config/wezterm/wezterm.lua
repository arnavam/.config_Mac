local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Font settings
-- config.font_size = 14
-- config.font_size = 8.5
-- config.line_height = 1.0
config.font = wezterm.font("JetBrains Mono")
config.colors ={
	cursor_bg = "#FFD700",
	cursor_border = "#FFD700",
	scrollbar_thumb = '#222222',

  -- The color of the split lines between panes
  split = '#444444',


}
config.default_cursor_style = 'BlinkingUnderline'
config.cursor_blink_rate = 100
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- ith_fallback {
	--
-- --   {
-- --     family = 'Dank Mono',
-- --     harfbuzz_features = {
-- --       'calt',
-- --       'ss01'-- --       'ss02',
-- --       'ss03',
-- --       'ss04',
-- --       'ss05',
-- --       'ss06',
-- --       'ss07',
-- --       'ss08',
-- --       'ss09',
-- --       'liga',
--     },
--   },
--   { family = 'Symbols Nerd Font Mono' },
-- }
-- config.font_rules = {
--   {
--     font = wezterm.font('Dank Mono', {
--       bold = true,
--     }),
--   },
--   {
--     italic = true,
--     font = wezterm.font('Dank Mono', {
--       italic = true,
--     }),
--   },
-- }

-- Colors
-- config.color_scheme = 'Catppuccin Mocha'

-- Appearance
config.cursor_blink_rate = 800
-- config.cursor_thickness = '2px'
-- config.line_height ='2.5px'
-- config.underline_position ='1px'
-- config.underline_thickness ='2px'
--
config.window_decorations = 'RESIZE'
-- config.hide_tab_bar_if_only_one_tab = true
-- config.enable_tab_bar=false

config.window_padding = {
  left = -1,
  right = 0,
  top = 0,
  bottom = 0,
}
config.macos_window_background_blur = 40

-- Miscellaneous settings
config.max_fps = 120
config.prefer_egl = true

config.background = {
  {
    source = {
      File = '/Users/arnav/Pictures/wallpaper/0042.jpg'
 -- Replace with the actual path to your image file
    },
    -- "Cover" is the default for height/width, ensuring the image
    -- scales to cover the entire window without leaving empty space.
    -- You can explicitly set it, but it's not strictly necessary for "cover" behavior:
    height = "Cover",
    width = "Cover",
    -- Optional: adjust opacity if needed (range 0.0 to 1.0)
    opacity = 1.0,
    -- Optional: dim the image to improve text readability
    hsb = { brightness = 0.5, saturation = 1.0, hue = 1.0 },
  },
}


-- Custom commands
-- wezterm.on('augment-command-palette', function()
--   return commands
-- end)
-- The art is a bit too bright and colorful to be useful as a backdrop
-- for text, so we're going to dim it down to 10% of its normal brightness


-- config.enable_scroll_bar = true
-- config.min_scroll_bar_height = '2cell'
-- config.colors = {
--   scrollbar_thumb = 'white',
-- }

-- local dimmer = { brightness = 0.1 }
-- config.background = {
--   -- This is the deepest/back-most layer. It will be rendered first
--   {
--     source = {
--       File = '~/Pictures/Alien_Ship_bg_vert_images/Backgrounds/spaceship_bg_1.png',
--     },
--     -- The texture tiles vertically but not horizontally.
--     -- When we repeat it, mirror it so that it appears "more seamless".
--     -- An alternative to this is to set `width = "100%"` and have
--     -- it stretch across the display
--     repeat_x = 'Mirror',
--     hsb = dimmer,
--     -- When the viewport scrolls, move this layer 10% of the number of
--     -- pixels moved by the main viewport. This makes it appear to be
--     -- further behind the text.
--     attachment = { Parallax = 0.1 },
--   },
--   -- Subsequent layers are rendered over the top of each other
--   {
--     source = {
--       File = '~/Pictures/Alien_Ship_bg_vert_images/Overlays/overlay_1_spines.png',
--     },
--     width = '100%',
--     repeat_x = 'NoRepeat',
--
--     -- position the spins starting at the bottom, and repeating every
--     -- two screens.
--     vertical_align = 'Bottom',
--     repeat_y_size = '200%',
--     hsb = dimmer,
--
--     -- The parallax factor is higher than the background layer, so this
--     -- one will appear to be closer when we scroll
--     attachment = { Parallax = 0.2 },
--   },
--   {
--     source = {
--       File = '/Users/arnav/Pictures/Alien_Ship_bg_vert_images/Overlays/overlay_2_alienball.png',
--     },
--     width = '100%',
--     repeat_x = 'NoRepeat',
--
--     -- start at 10% of the screen and repeat every 2 screens
--     vertical_offset = '10%',
--     repeat_y_size = '200%',
--     hsb = dimmer,
--     attachment = { Parallax = 0.3 },
--   },
--   {
--     source = {
--       File = '/Users/arnav/Pictures/Alien_Ship_bg_vert_images/Overlays/overlay_3_lobster.png',
--     },
--     width = '100%',
--     repeat_x = 'NoRepeat',
--
--     vertical_offset = '30%',
--     repeat_y_size = '200%',
--     hsb = dimmer,
--     attachment = { Parallax = 0.4 },
--   },
--   {
--     source = {
--       File = '/Users/arnav/Pictures/Alien_Ship_bg_vert_images/Overlays/overlay_4_spiderlegs.png',
--     },
--     width = '100%',
--     repeat_x = 'NoRepeat',
--
--     vertical_offset = '50%',
--     repeat_y_size = '150%',
--     hsb = dimmer,
--     attachment = { Parallax = 0.5 },
--   },
-- }

config.keys = {
	{
key = "w",
mods = "CMD",
action = wezterm.action.CloseCurrentPane {confirm = false },

	},
	{
	key = 'd',
mods = 'CMD',
action = wezterm. action.SplitHorizontal { domain = 'CurrentPaneDomain' },
	},
	{
	key = 'd',
	mods = 'CMD|SHIFT' ,
	action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
	},
	{
	key = 'k',
 mods = 'CMD',
 action = wezterm.action.SendString 'clear\n',
	},
}


--[[
============================
Custom Configuration
============================
]] --

-- Rounded or Square Style Tabs

-- change to square if you don't like rounded tab style
local tab_style = "rounded"

-- leader active indicator prefix
local leader_prefix = utf8.char(0x1f30a) -- ocean wave


--[[
============================
Shortcuts
============================
]] --

-- shortcut_configuration
config.leader = { key = "`",
									-- mods = "ALT",
									timeout_milliseconds = 2000 }
config.keys = {
    {
        mods = "LEADER",
        key = "c",
        action = wezterm.action.SpawnTab "CurrentPaneDomain",
    },
    {
        mods = "LEADER",
        key = "x",
        action = wezterm.action.CloseCurrentPane { confirm = true }
    },
    {
        mods = "LEADER",
        key = "b",
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        mods = "LEADER",
        key = "n",
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        mods = "LEADER",
        key = "|",
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
    },
    {
        mods = "LEADER",
        key = "-",
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
    },
    {
        mods = "LEADER",
        key = "h",
        action = wezterm.action.ActivatePaneDirection "Left"
    },
    {
        mods = "LEADER",
        key = "j",
        action = wezterm.action.ActivatePaneDirection "Down"
    },
    {
        mods = "LEADER",
        key = "k",
        action = wezterm.action.ActivatePaneDirection "Up"
    },
    {
        mods = "LEADER",
        key = "l",
        action = wezterm.action.ActivatePaneDirection "Right"
    },
    {
        mods = "LEADER",
        key = "LeftArrow",
        action = wezterm.action.AdjustPaneSize { "Left", 5 }
    },
    {
        mods = "LEADER",
        key = "RightArrow",
        action = wezterm.action.AdjustPaneSize { "Right", 5 }
    },
    {
        mods = "LEADER",
        key = "DownArrow",
        action = wezterm.action.AdjustPaneSize { "Down", 5 }
    },
    {
        mods = "LEADER",
        key = "UpArrow",
        action = wezterm.action.AdjustPaneSize { "Up", 5 }
    },
}

for i = 0, 9 do
    -- leader + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = wezterm.action.ActivateTab(i),
    })
end

--[[
============================
Tab Bar
============================
]] --

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = top 
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
end

wezterm.on(
    "format-tab-title",
    function(tab, tabs, panes, config, hover, max_width)
        local title = " " .. tab.tab_index .. ": " .. tab_title(tab) .. " "
        local left_edge_text = ""
        local right_edge_text = ""

        if tab_style == "rounded" then
            title = tab.tab_index .. ": " .. tab_title(tab)
            title = wezterm.truncate_right(title, max_width - 2)
            left_edge_text = wezterm.nerdfonts.ple_left_half_circle_thick
            right_edge_text = wezterm.nerdfonts.ple_right_half_circle_thick
        end

        -- ensure that the titles fit in the available space,
        -- and that we have room for the edges.
        -- title = wezterm.truncate_right(title, max_width - 2)

        if tab.is_active then
            return {
                { Background = { Color = colors.tab_bar_active_tab_bg } },
                { Foreground = { Color = colors.tab_bar_active_tab_fg } },
                { Text = left_edge_text },
                { Background = { Color = colors.tab_bar_active_tab_fg } },
                { Foreground = { Color = colors.tab_bar_text } },
                { Text = title },
                { Background = { Color = colors.tab_bar_active_tab_bg } },
                { Foreground = { Color = colors.tab_bar_active_tab_fg } },
                { Text = right_edge_text },
            }
        end
    end
)

return config
