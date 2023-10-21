#!/bin/bash

if acpi -a | grep -q 'off-line'; then
    xset dpms 90 120 180 # Set screen blank time to 2 minutes when on battery
else
    xset dpms 300 600 1200 # Set screen blank time to 5 minutes when charging
fi

