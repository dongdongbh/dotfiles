#!/usr/bin/zsh

current_variant="$(setxkbmap -query | grep -oP 'variant:\s*\K\w+')"
new_variant="basic"
if [ "$current_variant" = "basic" ]; then
  new_variant="engrammer"
fi
xinput | sed -n 's/.*AT Translated.*id=\([0-9]*\).*keyboard.*/\1/p' | xargs -I% setxkbmap -device % -layout us -variant "$new_variant"
