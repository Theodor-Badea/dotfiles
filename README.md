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

# Git

Git configuration lives in the `git` Stow package and is installed at
`~/.config/git/config`. It is independent of the NvChad configuration under
`~/.config/nvim`, so enabling it does not change Neovim behavior.

Install or update it from this repository with:

```bash
stow -R -t ~ git
```

The configuration provides:

- `git l` — a colorful, compact graph of all local and remote branches,
  including relative commit times and authors.
- `git ll` — the same history with file statistics.
- `git last` — the latest commit and its statistics.
- `git s` — short status with the current branch and upstream information.
- `git co`, `git sw`, and `git cm` — shorter checkout, switch, and commit
  commands.
- `git amend` — amend the last commit without opening an editor.
- `git unstage` and `git unstaged` — restore staged or working-tree changes.
- `git merged` and `git unmerged` — list branches merged or not merged into
  the current branch.

It also sets `main` as the default initial branch, automatically sets an
upstream on the first push of a new branch, sorts branches by recent activity
and tags by version, uses the histogram diff algorithm and `zdiff3` conflict
style, and enables Git's recorded-resolution helper (`rerere`). These are
ordinary Git settings and do not require GitHub CLI or any additional plugin.

To inspect the effective settings and aliases:

```bash
git config --list --show-origin
git config --get-regexp '^alias\.'
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
