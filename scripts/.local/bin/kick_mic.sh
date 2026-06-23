#!/bin/bash
# Replace this with YOUR actual card name from step 1
CARD="alsa_card.usb-HDA_Webcam_USB_HDA_Webcam_USB_HDA_Webcam_USB-02"

# Wait for desktop to load
sleep 5

# Toggle to OFF
pactl set-card-profile $CARD off

# Toggle back to your preferred profile (Digital or Analog)
pactl set-card-profile $CARD input:iec958-stereo
# OR if you prefer analog:
# pactl set-card-profile $CARD input:analog-stereo
