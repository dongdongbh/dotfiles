# Setup fzf
# ---------
if [[ ! "$PATH" == */home/nvio/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/nvio/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/nvio/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/dd/.fzf/shell/key-bindings.zsh"
