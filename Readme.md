# My Dotfiles

This repository contains my personal dotfiles for Arch Linux, running the `niri` Wayland compositor. The configurations are managed using GNU Stow.

### System Startup Procedure

The startup process for this Wayland-based system is:

> BIOS/UEFI → Bootloader (e.g., GRUB) → systemd → Display Manager (SDDM) → Niri (Wayland Compositor) & Session Components

---

### Software Stack

Here is a list of the primary tools used in this configuration:

| Category                 | Tool                                                                                                   | Description                                                                                             |
| ------------------------ | ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------- |
| **Graphical Environment**|                                                                                                        |                                                                                                         |
| Wayland Compositor       | [Niri](https://github.com/YaLTeR/niri)                                                                 | A scrollable-tiling Wayland compositor with a focus on a smooth, intuitive workflow.                    |
| Display Manager          | [SDDM](https://github.com/sddm/sddm)                                                                   | A modern, QML-based display manager.                                                                    |
| Status Bar               | [Waybar](https://github.com/Alexays/Waybar)                                                            | A highly customizable status bar for Wayland compositors like Niri and Sway.                            |
| Application Launcher     | [Rofi](https://github.com/davatorium/rofi)                                                             | A versatile application launcher and window switcher with Wayland support.                              |
| Notification Daemon      | [Mako](https://github.com/emersion/mako)                                                               | A lightweight and fast Wayland notification daemon.                                                     |
| Screen Management        | [Kanshi](https://github.com/emersion/kanshi)                                                           | A dynamic display configuration tool for Wayland, used to manage multi-monitor profiles automatically.  |
| Wallpaper Utility        | [swaybg](https://github.com/swaywm/sway)                                                               | A simple wallpaper utility for Wayland compositors.                                                     |
| Idle Management          | [swayidle](https://github.com/swaywm/swayidle)                                                         | A daemon for managing idle states, used here with `hyprlock`.                                           |
| Screen Locker            | [Hyprlock](https://github.com/hyprwm/hyprlock)                                                         | A fast and feature-rich screen locker for Wayland.                                                      |
| **Terminal & Shell** |                                                                                                        |                                                                                                         |
| Terminal Emulator        | [Alacritty](https://github.com/alacritty/alacritty)                                                    | A fast, GPU-accelerated terminal emulator.                                                              |
| Shell                    | [Zsh](https://www.zsh.org/)                                                                            | An extended Bourne shell with many improvements, configured with custom prompts and functions.          |
| Terminal Multiplexer     | [Tmux](https://github.com/tmux/tmux)                                                                   | A terminal multiplexer for managing multiple terminal sessions in a single window.                      |
| Editor                   | [Neovim](https://github.com/neovim/neovim)                                                             | A hyperextensible, Vim-based text editor.                                                               |
| Fuzzy Finder             | [fzf](https://github.com/junegunn/fzf)                                                                 | A general-purpose command-line fuzzy finder, integrated with Zsh for history and file searching.        |
| **System Utilities** |                                                                                                        |                                                                                                         |
| Input Method Framework   | [Fcitx5](https://github.com/fcitx/fcitx5) & [Rime](https://rime.im/)                                     | The input method framework and engine used for Xiaohe Double Pinyin Chinese input.                      |
| Audio Server             | [PipeWire](https://pipewire.org/) & [WirePlumber](https://pipewire.pages.freedesktop.org/wireplumber/)   | The modern audio and video server for Linux.                                                            |
| Screenshot Tools         | [grim](https://github.com/emersion/grim) & [slurp](https://github.com/emersion/slurp)                    | Core Wayland utilities for capturing the screen (`grim`) and selecting regions (`slurp`).               |
| GUI Screenshot           | [Flameshot](https://github.com/flameshot-org/flameshot)                                                | A feature-rich graphical tool for taking and annotating screenshots, with Wayland support.              |
| Clipboard Manager        | [wl-clipboard](https://github.com/bugaevc/wl-clipboard)                                                | Command-line copy and paste utilities for Wayland.                                                      |
| File Finder              | [fd](https://github.com/sharkdp/fd)                                                                    | A simple, fast, and user-friendly alternative to `find`.                                                |
| `grep` Alternative       | [ripgrep](https://github.com/BurntSushi/ripgrep)                                                       | A line-oriented search tool that recursively searches the current directory for a regex pattern.        |
| `cat` Alternative        | [bat](https://github.com/sharkdp/bat)                                                                  | A `cat` clone with syntax highlighting and Git integration.                                             |
| **File Management** |                                                                                                        |                                                                                                         |
| TUI File Manager         | [Yazi](https://github.com/sxyazi/yazi)                                                                 | A fast, terminal-based file manager with image previews powered by `ueberzugpp`.                        |
| PDF Viewer               | [Zathura](https://pwmt.org/projects/zathura/)                                                          | A highly customizable and Vim-like document viewer with a `poppler` backend for PDFs.                   |
| Disk Usage Analyzers     | [dust](https://github.com/bootandy/dust) & [duf](https://github.com/muesli/duf)                         | Modern command-line tools for analyzing disk usage and free space.                                      |
| Storage Device Manager   | [udiskie](https://github.com/coldfix/udiskie)                                                          | A user-level daemon for automatically mounting removable media.                                         |

### speed up your linux

#### using swap

It is better to have more ram memory.

Using more swap memory is not a good idea, because it will slow down your system.
by change the swappiness, you can make the system use swap memory less often.
The default swappiness is 60, you can change it to 10 by `sudo sysctl vm.swappiness=25`
Make this permanent by `sudo echo vm.swappiness=25 >> /etc/sysctl.conf`

#### speed up linux by tmpfs

Many Linux distro use tmpfs for /tmp, but debain/ubuntu currently don't.
Enable tmpfs for /tmp by

```bash
echo "tmpfs /tmp tmpfs rw,noatime,nosuid,nodev" | sudo tee -a /etc/fstab
sudo reboot
```

By default, a tmpfs partition has its maximum size set to half your total RAM.
You can change this by adding a size parameter to the fstab entry, e.g. tmpfs /tmp tmpfs rw,size=2G 0 0
Another method is enable it by systemd

```bash
sudo cp -v /usr/share/systemd/tmp.mount /etc/systemd/system/
sudo systemctl enable tmp.mount
sudo reboot
systemctl status tmp.mount
```

Note that you should do this only if your machine has enough ram available (generally at least 8GB)
You can also change the size of the tmpfs partition by changing the value of the SizeMax parameter in /etc/systemd/system/tmp.mount

make program use tmpfs for /tmp

```bash
#!/bin/bash
mkdir /tmp/chrome-cache-alw
ln -sf /tmp/chrome-cache-alw ~/.cache/google-chrome
```

You can mount ~/.cache as tmpfs, but Some naughty programs store things there that they want later and assume it will be there after a reboot.
Take you own risk.

`/etc/fstab` can be

```
tmpfs       /tmp                    tmpfs   rw,noatime,nosuid,nodev                         0   0
tmpfs       /var/cache/apt          tmpfs   noatime,mode=0755,uid=0,gid=0                   0   0
tmpfs       /home/dd/.cache         tmpfs   size=4g,noatime,mode=0700,uid=1000,gid=1000     0   0
tmpfs       /ram                    tmpfs   size=8g,noatime,mode=0700,uid=1000,gid=1000     0   0
```

- mounting /var/cache/apt as tmpfs, the apt package manager will be downloading all archives to RAM, and extracting them from RAM to disk. This speeds up installations and upgrades.
- mounting /ram as tmpfs, gives us a general folder to use as RAM disk, with a size of 8GB. This can be used to download files, archives to extract to disk, etc., where the speed of RAM is desirable.
- the size=[x] option will specify how much RAM can be used for each mountpoint.
- the mode=[xxxx] option will set the directory permissions (who can read, write, and execute)
- using the noatimeoption will eliminate needless disk operations, improving all disk performance.

### stow

stow create symbolic link to files or directories automatically. The symbol link use same name as the original files. For management of dotfiles, you should first move your dot file to the dofiles dir, then use stow to create a symbol link.

Here is an exampled:

```
cd ~
mkdir dotfiles
mkdir dotfiles/bash
mv ~/.bashrc ~/dotfiles/bash/
cd dotfiles
stow bash
```

The default target folder that stow creating symbol link is the parent dir of current dir. In the above example, it's the home dir. You can specify the target dir with `stow -t`.
stow also create subdir automatically. e.g. let's say you original is

```
---home
-----|
-----|--.config
-----------|
-----------|----nvim
-----------|------|
-----------|------|---init.lua
```

You should have the following in dotfiles by `mv ~/.config/nvim ~/dotfiles/nvim`, which results in

```

---home
-----|
-----|--dotfiles
-----------|
-----------|---nvim
-----------------|--.config
-----------------------|
-----------------------|----nvim
-----------------------|------|
-----------------------|------|---init.lua
```

Then just `stow nvim` in `~/dotfiles`.

For tmux, you should use tmux version newer than 3.1 to use config file located in `.config/tmux/`.

### other way to manage dotfiles

use [ git bare repository ](https://www.atlassian.com/git/tutorials/dotfiles).
