#!/bin/bash

# This script takes a screenshot of either a selected area or the full screen,
# saves it, copies it to the clipboard, and sends a notification.
#
# Usage:
# ./wayland-screenshot.sh full      # Takes a full-screen screenshot
# ./wayland-screenshot.sh selection # Takes a screenshot of a selected area

# --- Configuration ---
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILENAME="$(date '+%Y-%m-%d_%H-%M-%S').png"
FILE_PATH="$DIR/$FILENAME"

# --- Mode Selection ---
MODE=$1 # The first argument passed to the script

# --- Main Logic ---
take_screenshot() {
  if [ "$MODE" = "full" ]; then
    # Full-screen screenshot
    grim "$FILE_PATH"
  else
    # Default to selected area screenshot
    grim -g "$(slurp)" "$FILE_PATH"
  fi
}

# --- Execution ---
if ! take_screenshot; then
  notify-send -a "Screenshot" -i "dialog-error" "Screenshot Cancelled"
  exit 1
fi

# --- Post-Capture Actions ---
canberra-gtk-play -i "camera-shutter"
wl-copy < "$FILE_PATH"
notify-send -a "Screenshot" -i "$FILE_PATH" "Screenshot Taken" "Copied and Saved"
