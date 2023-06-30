## dotfiles
This is mydotfile repo. The dotfiles are managed by stow. 

System startup procedure: 

>bios->bootloader->X server (.xinitrc) with display manager -> login && window manager -> .xprofile 

The tools I'm using:

| Tool                 | Link                                                        |
|----------------------|-------------------------------------------------------------|
| display manager          | [lightdm](https://github.com/canonical/lightdm)                                                                                                      |
| greeter                  | unity-greeter. See [this](https://askubuntu.com/questions/64001/how-do-i-change-the-wallpaper-of-the-login-screen) to change the greeter background. |
| window manager           | [bspwm](https://github.com/baskerville/bspwm)                                                                                                        |
| screen manager           | [autorandr](https://github.com/phillipberndt/autorandr/)                                                                                            |
| key mapping              | [sxhkd](https://github.com/baskerville/sxhkd)                                                                                                        |
| bar                      | [polybar](https://github.com/polybar/polybar) 3.6.3-85                                                                                               |
| X wallpaper              | [feh](https://github.com/derf/feh)                                                                                                                   |
| Image Viewer | [nsxiv](https://nsxiv.codeberg.page/)                                                                                                                   |
| lockscreen               | [betterlockscreen](https://github.com/betterlockscreen/betterlockscreen) depend on imagemagick and i3lock-color                                      |
| X compositor             | [picom](https://github.com/yshui/picom)                                                                                                              |
| menu                     | [rofi](https://github.com/davatorium/rofi)                                                                                                           |
| menu                     | [dmenu](https://github.com/stilvoid/dmenu)  4.8                                                                                                      |
| notify                   | [dunst](https://github.com/dunst-project/dunst) and libnotify frontend                                                                               |
| screenshot               | [main](https://github.com/naelstrof/maim)                                                                                                            |
| screenshot               | [Flameshot](https://github.com/flameshot-org/flameshot) for more featured screenshot                                                                 |
| screecast                | [simplescreenrecorder](https://www.maartenbaert.be/simplescreenrecorder/)                                                                            |
| video player             | [vlc](https://www.videolan.org/vlc/)                                                                                                                 |
| video editor             | [kdenlive](https://kdenlive.org/en/)                                                                                                                 |
| input method framework   | [ibus](https://github.com/ibus/ibus)                                                                                                                 |
| terminal                 | [alacritty](https://github.com/alacritty/alacritty)                                                                                                  |
| fuzzy finder             | [fzf](https://github.com/junegunn/fzf) 0.35.1                                                                                                        |
| editor                   | [nvim](https://github.com/neovim/neovim), my neovim config can be found [here](https://github.com/dongdongbh/nvim.conf)                              |
| shell                    | [zsh](https://www.zsh.org/)                                                                                                                          |
| terminal session manager | [tmux](https://github.com/tmux/tmux/wiki)                                                                                                            |
| file manager             | [ranger](https://github.com/ranger/ranger)                                                                                                           |
| file manager             | [vifm](https://vifm.info/)                                                                                                                           |
| password manager             | [pass](https://www.passwordstore.org) with [rofi-pass](https://github.com/carnager/rofi-pass), [browserpass-native](https://github.com/browserpass/browserpass-native/) with [extension](https://chrome.google.com/webstore/detail/browserpass/naepdomgkenhinolocfifgehidddafch?hl=en) on chrome and [Android-Password-Store](https://github.com/android-password-store/Android-Password-Store) on android      |
| filedinder               | [fdfind](https://github.com/sharkdp/fd)                                                                                                              |
| grep                     | [ripgrep](https://github.com/BurntSushi/ripgrep)                                                                                                     |
| terminal text picker     | [tmux-thumbs](https://github.com/fcsonline/tmux-thumbs)                                                                                              |
| clipboard                | [xclip](https://manpages.ubuntu.com/manpages/bionic/man1/xclip.1.html)                                                                               |
| clipboard manager        | [clipmenu](https://github.com/cdown/clipmenu)                                                                                                        |
| filesystem tool          | [duf](https://github.com/muesli/duf)                                                                                                                 |
| disk usage tool          | [dust](https://github.com/bootandy/dust)                                                                                                             |
| git                      | [lazygit](https://github.com/jesseduffield/lazygit)                                                                                                  |
| cat                      | [bat](https://github.com/sharkdp/bat)                                                                                                                |
| top                      | [htop-vim](https://github.com/KoffeinFlummi/htop-vim)                                                                                                |
| ls                       | [exa](https://github.com/ogham/exa)                                                                                                                  |
| pdf reader               | [zathura](https://github.com/pwmt/zathura)
| terminal browser         | [w3m](https://w3m.sourceforge.net/)                                                                                                                  |
| git cli diff             | [delta](https://github.com/dandavison/delta)                                                                                                         |
| timer                    | [pomotroid](https://github.com/Splode/pomotroid)                                                                                                     |
| file share               | [syncthing](https://github.com/syncthing/syncthing)                                                                                                  |
| network overlay          | [nebula](https://github.com/slackhq/nebula)                                                                                                          |
| windows app              | [winapps](https://github.com/Fmstrat/winapps) with [qemu](https://github.com/qemu/qemu)                                                              |

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

* mounting /var/cache/apt as tmpfs, the apt package manager will be downloading all archives to RAM, and extracting them from RAM to disk. This speeds up installations and upgrades.
* mounting /ram as tmpfs, gives us a general folder to use as RAM disk, with a size of 8GB. This can be used to download files, archives to extract to disk, etc., where the speed of RAM is desirable.
* the size=[x] option will specify how much RAM can be used for each mountpoint.
* the mode=[xxxx] option will set the directory permissions (who can read, write, and execute)
* using the noatimeoption will eliminate needless disk operations, improving all disk performance.

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
