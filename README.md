dotfiles

# How to use with stow
1. Install stow

```bash
# Arch / Endeavour / Manjaro
sudo pacman -S stow

# Fedora
sudo dnf install stow

# Ubuntu / Debian
sudo apt install stow
```

2. Link them to the .config directory

```bash
stow -t ~ dirname
```

# Terminal Tools:
- jq
- ripgrep
- ncdu <!--TODO add it in the install script-->

# Tmux
Clone TPM
```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

## Neovim plugins

This repository uses NvChad with Lazy.nvim to manage Neovim plugins.

- `3rd/image.nvim` renders images inline in Markdown and Vimwiki buffers. It
  uses ImageMagick’s CLI processor and can be toggled with `:ImageToggle`.
- `OXY2DEV/markview.nvim` renders Markdown syntax directly inside Neovim. Use
  `:Markview` to toggle its preview.

<!--TODO add other plugins-->

After changing plugin specifications, run `:Lazy sync` in Neovim.
