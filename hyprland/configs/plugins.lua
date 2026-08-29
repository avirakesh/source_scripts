-- Plugins
-- Migrated from plugins.conf (old hyprlang syntax):
--
--   plugin {
--       virtual-desktops {
--           cycleworkspaces = 0
--       }
--   }
--
-- Note: the old file contained no `plugin = name:path` load line; the
-- virtual-desktops plugin (installed via hyprpm) is loaded automatically.
-- To load a plugin explicitly in a lua config, use:
--
--   hl.plugin.load("/var/cache/hyprpm/highonh2o/virtual-desktops/virtual-desktops.so")
--
-- Plugin values are registered by the plugin as `plugin:<name>:<key>` and are
-- addressed in lua with `.` separators and `_` instead of `-`
-- (see CConfigManager::luaConfigValueName / registerPluginValue in
-- src/ConfigManager.cpp).

hl.config({
    plugin = {
        virtual_desktops = {
            cycleworkspaces = 0,
        },
    },
})
