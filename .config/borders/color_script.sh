#!/bin/bash

# Function to convert HSL to ARGB hex (alpha included)
# Optional 4th argument: alpha as two hex digits (default ff)
hsl_to_argb_hex() {
  H=$1
  S=$2
  L=$3
  A=${4:-ff}

  # Use Python for accurate HSL to RGB conversion
  python3 - <<END
import colorsys
h = $H / 360.0
s = $S
l = $L
r, g, b = colorsys.hls_to_rgb(h, l, s)
argb = "0x$A{:02X}{:02X}{:02X}".format(int(r * 255), int(g * 255), int(b * 255))
print(argb)
END
}

# Create the config directory if it doesn't exist
CONFIG_DIR="$HOME/.config/borders"
mkdir -p "$CONFIG_DIR"


# Select a random hue (0-360)
HUE=$(( RANDOM % 360 ))
# Saturation fixed at 0.8 for vivid colors
SAT=0.8
# Define three lightness values for shades (lighter to darker)
LIGHTNESS_INACTIVE=0.85
LIGHTNESS_ACTIVE=0.65
LIGHTNESS_BACKGROUND=0.95

# Generate colors
INACTIVE_COLOR=$(hsl_to_argb_hex $HUE $SAT $LIGHTNESS_INACTIVE)
ACTIVE_COLOR=$(hsl_to_argb_hex $HUE $SAT $LIGHTNESS_ACTIVE)
BACKGROUND_COLOR=$(hsl_to_argb_hex $HUE $SAT $LIGHTNESS_BACKGROUND)

# Near-neutral dark shades of the same hue for bar surfaces
BAR_BG_COLOR=$(hsl_to_argb_hex $HUE 0.12 0.10 e6)
BAR_BG_ALT_COLOR=$(hsl_to_argb_hex $HUE 0.10 0.20 ff)
BAR_BORDER_COLOR=$(hsl_to_argb_hex $HUE 0.35 0.35 ff)

# Update your options array with these colors
cat <<EOF > "$CONFIG_DIR/bordersrc" 
options=(
	style=round
	width=4.0
	hidpi=on
	ax_focus=on
	inactive_color=$INACTIVE_COLOR
	active_color=$ACTIVE_COLOR
	blur_radius=0.2
)
borders "\${options[@]}"


EOF
brew services restart borders

# Shared theme for sketchybar (read by sketchybar/theme.lua)
THEME_DIR="$HOME/.cache/theme"
mkdir -p "$THEME_DIR"
cat <<THEME > "$THEME_DIR/colors"
accent=$ACTIVE_COLOR
accent_soft=$INACTIVE_COLOR
bg=$BAR_BG_COLOR
bg_alt=$BAR_BG_ALT_COLOR
border=$BAR_BORDER_COLOR
THEME
sketchybar --trigger theme_changed 2>/dev/null

echo "Updated colors saved to bordersrc"
echo "Inactive Color: $INACTIVE_COLOR"
echo "Active Color: $ACTIVE_COLOR"
echo "Background Color: $BACKGROUND_COLOR"

## background_color=$INACTIVE_COLOR

##gradient(top_left=0xAARRGGBB,bottom_right=0xAARRGGBB)
##              gradient(top_right=0xAARRGGBB,bottom_left=0xAARRGGBB)
##              glow(0xAARRGGBB)
##      	   (You might need to quote these arguments depending on your
##         shell)
