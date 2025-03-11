# Dotfiles
It's the dotfiles, wowee

1. Clone this repo to your home directory
2. ensure you have gnu `stow` installed

## General
```sh
stow fish git nvim starship tmux wezterm lazygit notes
```
## macOS
On macOS, you can additionally
```sh
stow aerospace sketchybar
```

## Arch
On arch (or any other distro that supports hyprland), you can additionally
```sh
stow hypr rofi swanc waybar
```

## LSP Servers
Ensure you have the following lsp servers installed as per
[nvim-lspconfig docs](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md):
* [rust_analyzer](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#rust_analyzer)
* [bashls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bashls)
* [dockerls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#dockerls)
* [terraformls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#terraformls)
* [lua_ls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls)
* [jsonls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls)

## Additional Tools
Stuff in here assumes that you have the following tools installed and accessible in your `$PATH`:
* [fish](https://fishshell.com/)
* [tmux](https://github.com/tmux/tmux/wiki/Installing)
* [neovim](https://neovim.io/) (ideally 0.10+)
* [kubectl](https://kubernetes.io/docs/tasks/tools/) (optional)
* [swift](https://www.swift.org/) (optional)
* [lsd](https://github.com/lsd-rs/lsd)
* [tokei](https://github.com/XAMPPRocky/tokei)
* [bat](https://github.com/sharkdp/bat)
* [fzf](https://github.com/junegunn/fzf)
* [lazygit](https://github.com/jesseduffield/lazygit)
* [starship](https://starship.rs/)
* [wezterm](https://wezfurlong.org/wezterm/index.html)
* [tailspin](https://github.com/bensadeh/tailspin)
* [difftastic](https://difftastic.wilfred.me.uk/installation.html)
* [delta](https://dandavison.github.io/delta/installation.html) (for telescope-undo.nvim only, may remove if I go back to undotree)

### Fun stuff that I have fish functions for
* [fastfetch](https://github.com/fastfetch-cli/fastfetch)
* [cbonsai](https://gitlab.com/jallbrit/cbonsai)
* [pipes.sh](https://github.com/pipeseroni/pipes.sh)
* [Athenaeum](https://github.com/GNMoseke/Athenaeum)

### macOS Only
* [aerospace](https://github.com/nikitabobko/AeroSpace)
* [sketchybar](https://github.com/FelixKratz/SketchyBar)
* [borders](https://github.com/FelixKratz/JankyBorders)

Additionally make sure you have `sourcekit-lsp` in your path

### Linux (Arch assumed) Only
* [hyprland](https://github.com/hyprwm/Hyprland) (and `hyprpaper`, `hypridle`, `hyprlock`)
* [waybar](https://github.com/Alexays/Waybar)
* [rofi](https://github.com/davatorium/rofi)
* [swaync](https://github.com/ErikReider/SwayNotificationCenter)
* [cliphist](https://github.com/sentriz/cliphist)
