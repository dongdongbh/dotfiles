#!/usr/bin/zsh

current_variant="$(setxkbmap -query | grep -oP 'variant:\s*\K\w+')"
new_variant="basic"
if [ "$current_variant" = "basic" ]; then
  new_variant="engrammer"
fi
setxkbmap -layout us -variant "$new_variant"
