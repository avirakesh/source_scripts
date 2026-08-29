-- Dynamic colors from wallpaper
-- (hyprlang: source = ~/.cache/hypr/colors.conf)
-- The generated colors.conf still uses hyprlang variable syntax, which the
-- lua config no longer parses directly, so it is read manually here.
local wallpaperColors = {}
do
    local colorsFile = io.open(os.getenv("HOME") .. "/.cache/hypr/colors.conf", "r")
    if colorsFile then
        for line in colorsFile:lines() do
            local name, value = line:match("^%s*%$(%S+)%s*=%s*(.-)%s*$")
            if name and value then
                wallpaperColors[name] = value
            end
        end
        colorsFile:close()
    end
end

-- $gradient ?= rgba(ffffff33)
local gradient = wallpaperColors.gradient or "rgba(ffffff33)"

-- https://wiki.hypr.land/Configuring/Variables/#general
hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 8,

        border_size = 1,

        -- macOS-like subtle border (overridden by dynamic gradient)
        col = {
            active_border   = gradient,
            inactive_border = "rgba(50505022)",
        },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    -- https://wiki.hypr.land/Configuring/Variables/#decoration
    decoration = {
        rounding       = 12,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 20,
            render_power = 3,
            color        = "rgba(00000066)",
        },

        -- https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
            enabled           = true,
            size              = 8,
            passes            = 4,
            new_optimizations = true,
            vibrancy          = 0.2,
            noise             = 0.01,
            contrast          = 1.0,
            brightness        = 1.0,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#animations
hl.config({
    animations = {
        enabled = true,
    },
})

-- macOS-like cubic-bezier curves
hl.curve("menu_decel",  { type = "bezier", points = { {0.1, 1},    {0.5, 1}     } })
hl.curve("menu_accel",  { type = "bezier", points = { {0.38, 0.04}, {0.56, 0.31} } })
hl.curve("easeOutExpo", { type = "bezier", points = { {0.16, 1},   {0.3, 1}     } })
hl.curve("soft_spring", { type = "bezier", points = { {0.15, 0},   {0.1, 1}     } })

hl.animation({ leaf = "windows",          enabled = true, speed = 3,   bezier = "menu_decel",  style = "popin 90%" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 1.5, bezier = "menu_decel",  style = "popin 97%" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 1.5, bezier = "menu_accel",  style = "popin 97%" })
hl.animation({ leaf = "border",           enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "fade",             enabled = true, speed = 1.5, bezier = "menu_decel" })
hl.animation({ leaf = "layers",           enabled = true, speed = 1.5, bezier = "menu_decel",  style = "fade" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 4,   bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4,   bezier = "easeOutExpo", style = "slidevert" })

-- Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})
