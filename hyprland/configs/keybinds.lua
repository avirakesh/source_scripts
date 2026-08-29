-- #####################
-- ### KEYBINDINGS ###
-- #####################

-- See https://wiki.hypr.land/Configuring/Binds/

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- $leftMonitor / $rightMonitor come from monitors.lua (required first);
-- they are defined there as globals, mirroring the hyprlang $variables.

-- Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
hl.bind("CTRL + ALT + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.kill())
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exit())
hl.bind(mainMod .. " + F", hl.dsp.window.float())
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("togglesplit")) -- dwindle

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch virtual desktops
hl.bind("CTRL + ALT + left",  hl.dsp.focus({ workspace = "m-1" }))
hl.bind("CTRL + ALT + right", hl.dsp.focus({ workspace = "m+1" }))

-- Move windows between virtual desktops (silent: don't follow the window)
hl.bind("CTRL + ALT + SHIFT + left",  hl.dsp.window.move({ workspace = "m-1", follow = false }))
hl.bind("CTRL + ALT + SHIFT + right", hl.dsp.window.move({ workspace = "m+1", follow = false }))

-- Special workspaces (scratchpads)
hl.bind(mainMod .. " + O",           hl.dsp.workspace.toggle_special("obsidian"))
hl.bind(mainMod .. " + SHIFT + O",   hl.dsp.window.move({ workspace = "special:obsidian" }))
hl.bind(mainMod .. " + CTRL + SHIFT + O", hl.dsp.window.move({ workspace = "e+0" }))

hl.bind(mainMod .. " + M",           hl.dsp.workspace.toggle_special("minimized"))
hl.bind(mainMod .. " + SHIFT + M",   hl.dsp.window.move({ workspace = "special:minimized" }))
hl.bind(mainMod .. " + CTRL + SHIFT + M", hl.dsp.window.move({ workspace = "e+0" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.window.move({ workspace = "m-1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.window.move({ workspace = "m+1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Move tiled windows within monitor
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.move({ direction = "down" }))

-- Move tiled window to specific displays
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ monitor = "mon:" .. leftMonitor }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ monitor = "mon:" .. rightMonitor }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                   { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Hyprshot
hl.bind("Print",                   hl.dsp.exec_cmd("hyprshot -m region")) -- Capture a region
hl.bind(mainMod .. " + Print",     hl.dsp.exec_cmd("hyprshot -m window")) -- Capture a window
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m output")) -- Capture an output
