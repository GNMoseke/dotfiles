# Dotfiles
It's the dotfiles, wowee

1. Clone this repo to your home directory
2. ensure you have gnu `stow` installed

```sh
stow fish git nvim starship tmux wezterm lazygit notes
```
On macOS, you can additionally
```sh
stow aerospace sketchybar
```

## LSP Servers
Ensure you have the following lsp servers installed as per [https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md]:
* [rust_analyzer](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#rust_analyzer)
* [bashls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bashls)
* [dockerls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#dockerls)
* [terraformls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#terraformls)
* [lua_ls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls)
* [jsonls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls)

Additionally make sure you have `sourcekit-lsp` in your path

## Additional Tools
Stuff in here assumes that you have the following tools installed and accessible in your `$PATH`:
* [fish](https://fishshell.com/)
* [tmux](https://github.com/tmux/tmux/wiki/Installing)
* [neovim](https://neovim.io/) (ideally 0.10+)
* [kubectl](https://kubernetes.io/docs/tasks/tools/) (optional)
* [swift](https://www.swift.org/)
* [lsd](https://github.com/lsd-rs/lsd)
* [tokei](https://github.com/XAMPPRocky/tokei)
* [bat](https://github.com/sharkdp/bat)
* [codium](https://github.com/VSCodium/vscodium)
* [podman](https://podman.io/)
* [fzf](https://github.com/junegunn/fzf)
* [lazygit](https://github.com/jesseduffield/lazygit)
* [starship](https://starship.rs/)
* [wezterm](https://wezfurlong.org/wezterm/index.html)
* [fastfetch](https://github.com/fastfetch-cli/fastfetch)

### macOS Only
* [aerospace](https://github.com/nikitabobko/AeroSpace)
* [sketchybar](https://github.com/FelixKratz/SketchyBar)
* [borders](https://github.com/FelixKratz/JankyBorders)
