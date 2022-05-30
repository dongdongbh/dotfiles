#! /bin/bash
SESSION_NAME="regular"
cd ~
tmux has-session -t ${SESSION_NAME} &> /dev/null

if [ $? != 0 ]
then
  # Create the session
  tmux new-session -s ${SESSION_NAME} -n bash -d

  # First window (1) 
  tmux split-window -h -p 50

  # dotfiles 
  tmux new-window -n dot -t ${SESSION_NAME}
  tmux split-window -h -p 50
  tmux send-keys -t ${SESSION_NAME}:2.1 'cd ~/.config/'
  tmux select-pane -t ${SESSION_NAME}:2.1
  # tmux send-keys -t ${SESSION_NAME}:3.1 'git status' C-m

  # shell (2)
  tmux new-window -n bash -t ${SESSION_NAME}
  # tmux send-keys -t ${SESSION_NAME}:3.1 'git status' C-m

  # Start out on the first window when we attach
  tmux select-window -t ${SESSION_NAME}:1
  tmux select-pane -t ${SESSION_NAME}:1.1
fi
tmux attach -t ${SESSION_NAME}
