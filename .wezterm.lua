local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.enable_wayland = false
config.front_end = "WebGpu"

-- font
config.font_size = 10.0
config.font = wezterm.font_with_fallback { 'Berkeley Mono', 'Nerd Font Symbols' }

config.colors = {
    background = "rgba:0 0 0 80",
}

config.enable_tab_bar = false

-- cursor
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

return config
