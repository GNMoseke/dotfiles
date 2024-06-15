local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.enable_tab_bar = false
config.window_background_opacity = 0.5
config.font_size = 10
config.default_cursor_style = 'SteadyBar'

return config

