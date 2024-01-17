#!/usr/bin/zsh -eu
if [[ -z "${TMUX-}" ]]; then
  if ! tmux ls | grep -q "main"; then
    tmux new -s main -n start
  else
    tmux attach -t main
  fi
fi