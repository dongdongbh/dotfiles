## dotfiles
This is mydotfile repo. The dotfiles are managed by stow. 

### stow
stow create symbolic link to files or directories automatically. The symbol link use same name as the original files. For management of ditfiles, you should first move your dot file to the dofiles dir, then use stow to create a symbol link.

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

for tmux, you should use tmux version newer than 3.1 to use config file located in `.config/tmux/`.
### i3wm 
I use i3wm to manage windows. More specifically, the `regolith` i3 on Ubuntu.
The config files of regolith done by `Xresources`. After setting it, you can check by `xrdb -query` to show configurations. 
The notification bar which I use is `polybar`. With `picom` for opacity. `rifo` for app launcher.
