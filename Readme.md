## dotfiles
This is mydotfile repo. The dotfiles are managed by stow. 

System startup procedure: 

>bios->bootloader->X server (.xinitrc) with display manager -> login && window manager -> .xprofile 

The tools I'm using:

- display manager: [ lightdm ](https://github.com/canonical/lightdm)
- greeter: unity-greeter. See [this](https://askubuntu.com/questions/64001/how-do-i-change-the-wallpaper-of-the-login-screen) to change the greeter background.
- window manager: [ bspwm ](https://github.com/baskerville/bspwm)
- key mapping: [ sxhkd ](https://github.com/baskerville/sxhkd)
- bar: [ polybar ](https://github.com/polybar/polybar)
- X wallpaper: [feh](https://github.com/derf/feh)
- lockscreen: [betterlockscreen](https://github.com/betterlockscreen/betterlockscreen)
- X compositor: [picom](https://github.com/yshui/picom)
- menu: [rofi](https://github.com/davatorium/rofi)
- notify: [dunst](https://github.com/dunst-project/dunst) and libnotify frontend
- screenshot: [main](https://github.com/naelstrof/maim)
- screecast: [simplescreenrecorder](https://www.maartenbaert.be/simplescreenrecorder/)
- video player: [vlc](https://www.videolan.org/vlc/)
- video editor: [kdenlive](https://kdenlive.org/en/)
- input method framework: [ibus](https://github.com/ibus/ibus)
- terminal: [alacritty](https://github.com/alacritty/alacritty)
- fuzzy finder: [fzf](https://github.com/junegunn/fzf)
- editor: [nvim](https://github.com/neovim/neovim)
- shell: [zsh](https://www.zsh.org/)
- terminal session manager: [tmux](https://github.com/tmux/tmux/wiki) 
- file manager: [vifm](https://vifm.info/)
- filedinder: [ fdfind ](https://github.com/sharkdp/fd)
- grep: [ ripgrep ](https://github.com/BurntSushi/ripgrep)
- terminal text picker: [tmux-thumbs](https://github.com/fcsonline/tmux-thumbs)
- clipboard manager: [clipmenu](https://github.com/cdown/clipmenu)
- filesystem tool: [ duf ](https://github.com/muesli/duf)
- disk usage tool: [ dust ](https://github.com/bootandy/dust)
- git: [ lazygit ](https://github.com/jesseduffield/lazygit)
- cat: [ bat ](https://github.com/sharkdp/bat)
- top: [htop-vim](https://github.com/KoffeinFlummi/htop-vim)
- ls: [exa](https://github.com/ogham/exa) 
- pdf reader: [zathura](https://github.com/pwmt/zathura) 
- terminal browser: [w3m](https://w3m.sourceforge.net/) 
- git cli diff: [delta](https://github.com/dandavison/delta) 
- timer: [pomotroid](https://github.com/Splode/pomotroid)
- file share: [syncthing](https://github.com/syncthing/syncthing)
- network overlay: [nebula](https://github.com/slackhq/nebula) constructing mash network by UDP punching.
- windows app: [winapps](https://github.com/Fmstrat/winapps) with [qemu](https://github.com/qemu/qemu).

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
