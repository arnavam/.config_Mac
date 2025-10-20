#!/bin/sh

while true;do
# Get the index of the current space
current_space=$(yabai -m query --spaces --space | jq '.index')

# Count the number of windows assigned to the current space
window_count=$(yabai -m query --windows | jq "[.[] | select(.space == $current_space)] | length")



# Toggle fullscreen mode if there is exactly one window
if [ "$window_count" -eq 2 ]; then
yabai -m config top_padding          0
yabai -m config bottom_padding       0
yabai -m config left_padding         0
yabai -m config right_padding        0 
yabai -m config window_gap           0
else 
yabai -m config top_padding          10
yabai -m config bottom_padding       10
yabai -m config left_padding         10
yabai -m config right_padding        10 
yabai -m config window_gap           10
fi


current_state=$(defaults read NSGlobalDomain _HIHideMenuBar)
if [ "$current_state" -eq 2 ]; then
    defaults write NSGlobalDomain _HIHideMenuBar -bool false
else
    defaults write NSGlobalDomain _HIHideMenuBar -bool true
fi

echo "running"
sleep 5
done 