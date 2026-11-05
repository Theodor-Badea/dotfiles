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

Neovim transparency is enabled through NvChad's native
`base46.transparency = true` setting in `lua/chadrc.lua`. A small startup
override in `lua/options.lua` also clears the generated Base46 background
highlights, so no extra plugin or cache file is required.

- The Markdown preview plugin exposes `:MarkdownPreviewToggle`,
  `:MarkdownPreview`, and `:MarkdownPreviewStop` globally. It opens a dark
  preview in Google Chrome; for an in-Neovim preview, use `:Markview` instead.
- `3rd/image.nvim` renders images inline in Markdown and Vimwiki buffers. It
  uses ImageMagick’s CLI processor and can be toggled with `:ImageToggle`.
- `OXY2DEV/markview.nvim` renders Markdown syntax directly inside Neovim. Use
  `:Markview` to toggle its preview.

<!--TODO add other plugins-->

After changing plugin specifications, run `:Lazy sync` in Neovim.

### Stow behavior

The `nvim` directory is a Stow package. From this repository, run:

```bash
stow -t ~ nvim
```

Stow creates symlinks such as `~/.config/nvim` to the files in this repository;
it does not continuously watch or update them. Changes made in the repository
are visible immediately through the symlink, but adding or removing files may
require running Stow again (usually `stow -R -t ~ nvim`). The `install.sh`
script runs the dotfiles installer once, so it does not automatically rerun
Stow whenever a file changes.
