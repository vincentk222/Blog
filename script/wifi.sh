#!/bin/bash

# Check if the script is executed with sudo privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run with sudo privileges. Trying to relaunch with sudo..."
    sudo "$0" "$@"
    exit $?
fi

# Check if already connected to a Wi-Fi network
current_connection=$(nmcli -t -f ACTIVE,SSID dev wifi | egrep '^yes' | cut -d: -f2)
if [ -n "$current_connection" ]; then
    echo "You are currently connected to Wi-Fi network '$current_connection'."
    read -p "Do you want to continue and connect to a different network? (yes/no): " response
    if [ "$response" != "yes" ]; then
        echo "Keeping the current configuration. Exiting..."
        exit 0
    fi
fi

echo "Scanning for available Wi-Fi networks..."

# List available Wi-Fi networks
mapfile -t ssids < <(nmcli --terse --fields SSID dev wifi | sort -u)

if [ ${#ssids[@]} -eq 0 ]; then
    echo "No Wi-Fi networks found. Please make sure your Wi-Fi is enabled and try again."
    exit 1
fi

echo "Available Wi-Fi networks:"
for i in "${!ssids[@]}"; do
    echo "$((i+1))) ${ssids[i]}"
done

# Ask the user to choose a Wi-Fi network
read -p "Enter the number of the Wi-Fi network you wish to connect to: " choice

# Validate the choice
if [[ $choice -le 0 || $choice -gt ${#ssids[@]} ]]; then
    echo "Invalid choice."
    exit 1
fi

ssid="${ssids[$((choice-1))]}"
read -sp "Enter the password for the Wi-Fi network '$ssid': " password
echo

# Connect to the Wi-Fi network
echo "Attempting to connect to the Wi-Fi network '$ssid'..."
nmcli dev wifi connect "$ssid" password "$password"

if [ $? -eq 0 ]; then
    echo "Successfully connected to the Wi-Fi network '$ssid'."
else
    echo "Failed to connect to the Wi-Fi network '$ssid'."
    exit 1
fi

# Display the IP address of the interface
wifi_interface=$(iw dev | grep Interface | awk '{print $2}')
ip_address=$(ip addr show $wifi_interface | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
echo "The IP address of the interface '$wifi_interface' is: $ip_address"
