local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font("JetBrainsMono Nerd Font Propo")
config.enable_tab_bar = false
config.window_background_opacity = 0.88
config.default_cursor_style = 'SteadyBlock'
config.window_decorations = "RESIZE"

if wezterm.target_triple == 'aarch64-apple-darwin' then
    config.font_size = 12
    config.macos_window_background_blur = 20
else
    config.font_size = 10
end

-- TODO: can be removed once https://github.com/wez/wezterm/issues/5103 included in new wezterm release
if os.getenv("XDG_CURRENT_DESKTOP") == "Hyprland" then
	config.enable_wayland = false
else
	config.enable_wayland = true
end
return config
