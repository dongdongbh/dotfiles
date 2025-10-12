#!/bin/sh

# Basic connectivity indicator for Waybar: show a connected/disconnected glyph.

if ! systemctl is-active --quiet bluetooth.service; then
    echo '  '
    exit 0
fi

if bluetoothctl show | grep -q "Powered: no"; then
    echo '  '
    exit 0
fi

if bluetoothctl devices Connected | grep -q "^Device"; then
    echo '  '
else
    echo '  '
fi
