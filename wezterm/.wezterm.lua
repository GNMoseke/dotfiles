local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.enable_tab_bar = false
config.window_background_opacity = 0.85
config.font_size = 12
config.default_cursor_style = 'SteadyBar'

return config

