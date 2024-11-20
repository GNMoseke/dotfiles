# Dotfiles
It's the dotfiles, wowee

1. Clone this repo to your home directory
2. ensure you have gnu `stow` installed

```sh
stow fish git nvim starship tmux wezterm lazygit notes
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
