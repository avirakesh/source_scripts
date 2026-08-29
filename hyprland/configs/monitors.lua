-- Intentionally global (not local) so other config modules (e.g. keybinds)
-- can reference them, mirroring the hyprlang $variables.
-- This module must be required before any module that uses these names.
leftMonitor  = "DP-3"
rightMonitor = "DP-4"

-- See https://wiki.hypr.land/Configuring/Monitors/
hl.monitor({
    output    = leftMonitor,
    mode      = "2560x1440@59.95",
    position  = "0x0",
    scale     = 1,
    transform = 1,
})

hl.monitor({
    output   = rightMonitor,
    mode     = "3840x2160@143.96",
    position = "1440x200",
    scale    = 1.2,
})
