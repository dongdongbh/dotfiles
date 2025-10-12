#!/usr/bin/env bash

bluetooth_print() {
    if ! systemctl is-active --quiet bluetooth.service; then
        echo "#2"
        return
    fi

    if ! bluetoothctl show | grep -q "Powered: yes"; then
        echo "#2"
        return
    fi

    mapfile -t connected_devices < <(bluetoothctl devices Connected | awk '{print $2}')
    if [ "${#connected_devices[@]}" -eq 0 ]; then
        echo "#1"
        return
    fi

    local aliases=()
    for device in "${connected_devices[@]}"; do
        local alias_name
        alias_name=$(bluetoothctl info "$device" | awk -F ': ' '/Alias:/{print $2; exit}')
        aliases+=("${alias_name:-$device}")
    done

    printf '#1 %s\n' "$(IFS=", " ; echo "${aliases[*]}")"
}

bluetooth_toggle() {
    if bluetoothctl show | grep -q "Powered: no"; then
        bluetoothctl power on > /dev/null
        sleep 1

        mapfile -t paired < <(bluetoothctl devices Paired | awk '{print $2}')
        for device in "${paired[@]}"; do
            bluetoothctl connect "$device" > /dev/null 2>&1
        done
    else
        mapfile -t connected < <(bluetoothctl devices Connected | awk '{print $2}')
        for device in "${connected[@]}"; do
            bluetoothctl disconnect "$device" > /dev/null 2>&1
        done

        bluetoothctl power off > /dev/null
    fi
}

case "$1" in
    --toggle)
        bluetooth_toggle
        ;;
    *)
        bluetooth_print
        ;;
esac
