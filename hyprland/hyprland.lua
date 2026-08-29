-- Hyprland Modular Configuration

-- Load all configuration modules.
-- Order matters: monitors and programs define shared globals
-- (leftMonitor, rightMonitor, terminal, fileManager, menu) that
-- later modules (autostart, keybinds) reference.
require("configs/monitors")
require("configs/programs")
require("configs/autostart")
require("configs/env_vars")
require("configs/look_and_feel")
require("configs/input")
require("configs/keybinds")
require("configs/window_rules")
require("configs/plugins")
