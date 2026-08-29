-- Set programs that you use
-- Note: intentionally global (not local) so other config modules can reference
-- them, mirroring how hyprlang $variables were visible across sourced files.
-- This module must be required before any module that uses these names.
terminal    = "alacritty"
fileManager = "dolphin"
menu        = "wofi --show drun"
