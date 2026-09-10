#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
export DOTFILES_DIR="${DOTFILES_DIR:-$SCRIPT_DIR}"

log() { printf '[dotfiles] %s\n' "$*"; }
warn() { printf '[dotfiles] warning: %s\n' "$*" >&2; }
die() { printf '[dotfiles] error: %s\n' "$*" >&2; exit 1; }

INSTALL_PACKAGES=1
APPLY_STOW=1
SET_SHELL=0
for arg in "$@"; do
    case "$arg" in
        --no-packages) INSTALL_PACKAGES=0 ;;
        --no-stow) APPLY_STOW=0 ;;
        --set-shell) SET_SHELL=1 ;;
        -h|--help) echo 'Usage: install.sh [--no-packages] [--no-stow] [--set-shell]'; exit 0 ;;
        *) die "unknown option: $arg" ;;
    esac
done

[[ -d "$DOTFILES_DIR/.git" ]] || die "not a git repository: $DOTFILES_DIR"

SUDO=()
if (( EUID != 0 )); then
    command -v sudo >/dev/null 2>&1 || die "sudo is required when not running as root"
    SUDO=(sudo)
fi

detect_manager() {
    if command -v dnf >/dev/null 2>&1; then printf '%s' dnf
    elif command -v pacman >/dev/null 2>&1; then printf '%s' pacman
    elif command -v apt-get >/dev/null 2>&1; then printf '%s' apt
    elif command -v zypper >/dev/null 2>&1; then printf '%s' zypper
    else return 1
    fi
}

install_packages() {
    local manager="$1" package
    local -a packages=()
    case "$manager" in
        dnf) packages=(stow git gcc gcc-c++ make tmux neovim zsh fastfetch btop htop flameshot wireshark rofi-wayland waybar yazi zathura ripgrep keepassxc jq); "${SUDO[@]}" dnf makecache --refresh ;;
        pacman) packages=(stow git base-devel tmux neovim zsh fastfetch btop htop flameshot wireshark-qt rofi-wayland waybar yazi zathura ripgrep keepassxc jq); "${SUDO[@]}" pacman -Sy --noconfirm ;;
        apt) packages=(stow git build-essential tmux neovim zsh fastfetch btop htop flameshot wireshark rofi waybar yazi zathura ripgrep keepassxc jq); "${SUDO[@]}" apt-get update ;;
        zypper) packages=(stow git gcc gcc-c++ make tmux neovim zsh fastfetch btop htop flameshot wireshark rofi waybar yazi zathura ripgrep keepassxc jq); "${SUDO[@]}" zypper refresh ;;
    esac
    log "installing package set using $manager (already-installed packages are skipped)"
    for package in "${packages[@]}"; do
        case "$manager" in
            dnf) "${SUDO[@]}" dnf install -y "$package" || warn "could not install $package; continuing" ;;
            pacman) "${SUDO[@]}" pacman -S --needed --noconfirm "$package" || warn "could not install $package; continuing" ;;
            apt) "${SUDO[@]}" apt-get install -y --no-install-recommends "$package" || warn "could not install $package; continuing" ;;
            zypper) "${SUDO[@]}" zypper install -y "$package" || warn "could not install $package; continuing" ;;
        esac
    done
}

apply_stow() {
    command -v stow >/dev/null 2>&1 || { warn 'stow is unavailable; skipping dotfiles'; return; }
    log 'applying all dotfile packages with GNU Stow'
    while IFS= read -r -d '' package_dir; do
        package="${package_dir##*/}"
        if ! (cd "$DOTFILES_DIR" && stow --restow --target="$HOME" "$package"); then
            warn "could not stow $package; resolve conflicting files and rerun"
        fi
    done < <(find "$DOTFILES_DIR" -mindepth 1 -maxdepth 1 -type d ! -name .git -print0 | sort -z)
}

set_login_shell() {
    command -v zsh >/dev/null 2>&1 || { warn 'zsh is unavailable; cannot change login shell'; return; }
    zsh_path="$(command -v zsh)"
    [[ "${SHELL:-}" == "$zsh_path" ]] && return
    command -v chsh >/dev/null 2>&1 && chsh -s "$zsh_path" || warn 'could not change login shell'
}

if (( INSTALL_PACKAGES )); then
    manager="$(detect_manager || true)"
    [[ -n "$manager" ]] || die 'unsupported distribution; rerun with --no-packages after manual installation'
    install_packages "$manager"
fi
if (( APPLY_STOW )); then apply_stow; fi
if (( SET_SHELL )); then set_login_shell; fi
log 'dotfiles setup complete'
