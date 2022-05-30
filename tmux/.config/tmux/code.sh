#! /bin/bash
SESSION_NAME="code"
cd ~/code/
tmux has-session -t ${SESSION_NAME} &> /dev/null

if [ $? != 0 ]
then
  # Create the session
  tmux new-session -s ${SESSION_NAME} -n vim -d

  # First window (1) -- vim and console
  tmux send-keys -t ${SESSION_NAME} 'vim' C-m
  tmux split-window -v -p 30 
  tmux split-window -h -p 50

  # shell (2)
  tmux new-window -n bash -t ${SESSION_NAME}
  #tmux send-keys -t ${SESSION_NAME}:2.1 'git status' C-m

  # monitor htop and nvidia-smi (3)
  tmux new-window -n monitor -t ${SESSION_NAME}
  tmux send-keys -t ${SESSION_NAME}:3.1 'htop' C-m

  # debug&log (4)
  tmux new-window -n log -t ${SESSION_NAME}
  #tmux send-keys -t ${SESSION_NAME}:4 'bundle exec rails s' C-m
  #tmux split-window -v -t ${SESSION_NAME}:3
  #tmux send-keys -t ${SESSION_NAME}:4.1 'tail -f log/development.log | grep "DEBUG"' C-m

  # Start out on the first window when we attach
  tmux select-window -t ${SESSION_NAME}:1
  tmux select-pane -t ${SESSION_NAME}:1.1
fi
tmux attach -t ${SESSION_NAME}
