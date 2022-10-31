# C Programming
export CC='clang'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Locale/Langs
export LANG='en_US.utf8'
export LC_ALL='en_US.utf8'

# Programs
export EDITOR="nvim"
export VISUAL="nvim"
export FILE_BROWSER="vifm"
export VID_PLAYER="vlc"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# make bat show man page
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

