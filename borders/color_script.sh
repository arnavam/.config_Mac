#!/bin/bash

# Function to convert HSL to ARGB hex (alpha included)
hsl_to_argb_hex() {
  H=$1
  S=$2
  L=$3

  # Use Python for accurate HSL to RGB conversion
  python3 - <<END
import colorsys
h = $H / 360.0
s = $S
l = $L
r, g, b = colorsys.hls_to_rgb(h, l, s)
argb = "0xff{:02X}{:02X}{:02X}".format(int(r * 255), int(g * 255), int(b * 255))
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
	background_color=$INACTIVE_COLOR
)
borders "\${options[@]}"


EOF
brew services restart borders

echo "Updated colors saved to bordersrc"
echo "Inactive Color: $INACTIVE_COLOR"
echo "Active Color: $ACTIVE_COLOR"
echo "Background Color: $BACKGROUND_COLOR"

##gradient(top_left=0xAARRGGBB,bottom_right=0xAARRGGBB)
##              gradient(top_right=0xAARRGGBB,bottom_left=0xAARRGGBB)
##              glow(0xAARRGGBB)
##      	   (You might need to quote these arguments depending on your
##         shell)
