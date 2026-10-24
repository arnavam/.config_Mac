sbar = require("sketchybar")

-- Bundle all initial setup into one message to sketchybar
sbar.begin_config()
require("bar")
require("default")
require("items")
sbar.end_config()

-- Keep the process alive to handle event callbacks
sbar.event_loop()
