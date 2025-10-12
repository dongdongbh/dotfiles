# Dotfiles for Arch + Niri

Personal configuration for an Arch Linux workstation running the [Niri](https://github.com/YaLTeR/niri) Wayland compositor.  GNU Stow keeps everything modular so I can selectively link packages (`waybar`, `niri`, `zsh`, etc.) into `$HOME`.

> **Note:** The `niri` branch is the primary target.  I keep Hyprland-specific configs on a separate branch; only the shared assets live here (`hypr-common/`, `hyprlock/`).

---

## What’s Inside

| Area | Highlights |
|------|------------|
| **Compositor & Session** | Niri, Hyprlock, Waybar, swayidle/swaybg, systemd user units under `systemd/.config/systemd/user/` |
| **Shell & Terminal** | Zsh (lazy-loaded NVM, autosuggestions, syntax highlighting), Alacritty, tmux, fzf, custom functions in `zsh/.config/zsh/` |
| **Editor** | Neovim + plugins in `vim/` (legacy Vim config included) |
| **Launchers & UI** | Rofi, mako, kanshi profiles, wallpapers |
| **CLI Helpers** | Scripts in `scripts/.local/bin/` (Waybar media player, Bluetooth toggles, screenshot helper, hotspot manager, etc.) |

Repository layout is intentionally Stow‑friendly: each top-level directory mirrors the eventual `$HOME` location (for example `waybar/.config/waybar/config.jsonc` → `~/.config/waybar/config.jsonc`).

---

## Quick Start

1. **Install prerequisites**
   ```bash
   sudo pacman -S --needed git stow
   ```
2. **Clone and enter the repo**
   ```bash
   git clone https://github.com/<you>/dotfiles ~/dotfiles
   cd ~/dotfiles
   ```
3. **Bootstrap packages**
   ```bash
   ./install.sh
   ```
   The script is idempotent:
   - uses `set -euo pipefail`
   - installs dependencies with `pacman -S --needed`
   - builds `yay` if it is missing
   - backs up an existing `~/.zshrc` before stowing

4. **Restow later**
   ```bash
   make        # restow everything
   make delete # remove symlinks
   ```

If you only want a subset, run `stow <package>` manually (e.g. `stow zsh waybar`).

---

## Session Overview

- **Display manager:** SDDM launches Niri.  
- **Waybar:** dynamically chooses `config-docked.jsonc` or `config-undocked.jsonc` via `~/.local/bin/launch-waybar.sh`.  Media information comes from `mediaplayer.py`, Bluetooth status from `system-bluetooth-bluetoothctl.sh`, and power actions from `power_menu.xml`.
- **Lock screen:** Hyprlock is started for both Niri and Hyprland sessions.
- **Systemd user units:** enable optional services with:
  ```bash
  systemctl --user enable --now swaybg.service
  systemctl --user enable --now swayidle.service
  ```
- **Hyprland configs:** shared pieces are in `hypr-common/`; per-host Hyprland packages live on other branches.

---

## Shell Notes

- Zsh loads instantly thanks to lazy NVM wrappers defined in `zsh/.zshrc`.  Node tooling is only initialised the first time you run `node`, `npm`, `npx`, `corepack`, or `nvm`.
- Plugins (`zsh-autosuggestions`, `zsh-syntax-highlighting`) are stored under `zsh/.config/zsh/plugins/`.  `zsh_add_completion` now updates completions safely and refreshes `compinit` on demand.
- Custom helpers live in `zsh/.config/zsh/functions.zsh` and `zsh-functions`.  Examples: `batdiff`, `y` (yazi integration), `jssh` for jump hosts.

---

## Scripts Worth Knowing

| Script | Purpose |
|--------|---------|
| `scripts/.local/bin/system-bluetooth-bluetoothctl.sh` | Waybar module helper: prints connected device aliases and toggles power/connection cleanly. |
| `scripts/.local/bin/bluetooth-simple.sh` | Minimal glyph output for bar widgets. |
| `scripts/.local/bin/wayland-screenshot.sh` | Grim + slurp based screenshot utility (`full` or region). |
| `scripts/.local/bin/launch-waybar.sh` | Chooses docked vs. undocked Waybar config based on active outputs. |
| `scripts/.local/bin/hotspot` | Start/stop a Wi-Fi hotspot with NetworkManager handoff. |
| `scripts/.local/bin/present_mode.sh` | Sync external display resolution to `autorandr` profile. |

Most scripts assume Wayland; a few legacy X11 helpers remain and are marked accordingly in comments.

---

## Secrets & Environment

`zsh/.config/zsh/api_keys` contains API tokens and **must stay out of version control**.  I `.gitignore` the file, but rotate keys immediately if one ever leaks.  For a safer setup consider:

- loading secrets through `pass`, `sops`, or a `.env` sourced from `~/.config/zsh/envrc`
- exporting tokens inside systemd user units or using `direnv`

---

## Maintaining the Dotfiles

- **Update packages:** rerun `./install.sh` after pulling changes; it will skip what is already installed.  
- **Waybar testing:** run `waybar -c ~/.config/waybar/config.jsonc` and look at `journalctl --user -u waybar.service` for errors.  
- **Zsh profiling:** `zsh -i -f -c 'zmodload zsh/zprof; source ~/.zshrc; zprof'` to keep startup fast.  
- **Niri debugging:** `niri msg logs` and `~/.local/state/niri/` contain helpful traces.

---

## Contributing / Forking

- Prefer small, focused Stow packages—new program? Create `<pkg>/.config/<pkg>/…` and add it to the restow loop in `install.sh`.
- Keep Wayland-friendly replacements for legacy X11 utilities and document them in the Scripts section.
- Branch structure:
  - `niri` (default): Wayland with Niri.
  - `hyprland`: host-specific Hyprland configs; merge shared pieces via `hypr-common/`.

---

Happy hacking!  If you spot something stale or have ideas for simplifying the bootstrap, open an issue or drop me a note. 
