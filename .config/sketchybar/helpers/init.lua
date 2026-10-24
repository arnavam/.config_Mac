-- Add the sketchybar module to the package cpath
package.cpath = package.cpath .. ";" .. os.getenv("HOME") .. "/.local/share/sketchybar_lua/?.so"

-- Build the C event providers (no-op when up to date)
os.execute("make -s -C " .. os.getenv("HOME") .. "/.config/sketchybar/helpers")
