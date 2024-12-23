local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.enable_tab_bar = false
config.window_background_opacity = 0.85
config.default_cursor_style = 'SteadyBar'
config.window_decorations = "RESIZE"

if wezterm.target_triple == 'aarch64-apple-darwin' then
    config.font_size = 12
    config.macos_window_background_blur = 15
else
    config.initial_cols = 220
    config.initial_rows = 80
    config.font_size = 10
end

return config
