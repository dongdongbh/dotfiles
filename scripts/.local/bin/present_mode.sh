#!/bin/bash
set -euo pipefail

# Extract HDMI-1's current resolution.
# It finds the "HDMI-1 connected" line, then reads the next line which lists resolutions.
resolution=$(xrandr | awk '/^HDMI-1 connected/ {getline; print $1; exit}')
if [ -z "$resolution" ]; then
    echo "Could not determine HDMI-1 resolution" >&2
    exit 1
fi
echo "Detected HDMI-1 resolution: $resolution"

# Path to the autorandr profile config file.
config_file="$HOME/.config/autorandr/present/config"
if [ ! -f "$config_file" ]; then
    echo "Config file not found at $config_file" >&2
    exit 1
fi

# Update the HDMI-1 block in the config file.
# Replace any existing "mode" line or insert one if missing.
awk -v res="$resolution" '
BEGIN { inHDMI=0; foundMode=0 }
{
    # Start of HDMI-1 block.
    if ($0 ~ /^output HDMI-1/) {
        inHDMI=1; foundMode=0;
        print $0;
        next;
    }
    # If we hit a new output while in HDMI-1 block, end the block.
    if (inHDMI && $0 ~ /^output /) {
        if (foundMode == 0) {
            print "mode " res;
        }
        inHDMI=0;
    }
    # If within HDMI-1 block and find an existing mode line, replace it.
    if (inHDMI && $0 ~ /^mode /) {
        print "mode " res;
        foundMode=1;
        next;
    }
    print $0;
}
END {
    # If still in HDMI-1 block at file end without a mode line, add it.
    if (inHDMI && foundMode == 0) {
        print "mode " res;
    }
}' "$config_file" > "$config_file.tmp" && mv "$config_file.tmp" "$config_file"

# Load the autorandr profile.
autorandr -l present

