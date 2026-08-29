-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
--
-- hl.exec_cmd(terminal)
-- hl.exec_cmd("nm-applet")

hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css")

    -- Auto wallpaper script
    hl.exec_cmd("/home/highonh2o/.config/hypr/scripts/awww-random.sh")

    hl.exec_cmd("swaync")

    hl.exec_cmd("hypridle")

    -- Portal setup (standard way)
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets,ssh")

    hl.exec_cmd("hyprpm reload")
end)
