#!/bin/bash

if acpi -a | grep -q 'off-line'; then
    xset s 90 90  # Set screen blank time to 2 minutes when on battery
else
    xset s 300 300  # Set screen blank time to 10 minutes when charging
fi

