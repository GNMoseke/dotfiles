# Requires https://github.com/GNMoseke/tmux-ci/tree/main

show_ci-status() { # This function name must match the module name!
  local index icon color text module

  index=$1 # This variable is used internally by the module loader in order to know the position of this module

  icon="$(  get_tmux_option "@catppuccin_ci-status_icon"  "󱥸"           )"
  color="$( get_tmux_option "@catppuccin_ci-status_color" "$thm_orange" )"
  text="$(  get_tmux_option "@catppuccin_ci-status_text"  "#{ci}" )"
  module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}
