#!/bin/bash

# Specify the target directory where USB drives will be mounted
mount_dir="/SambaShare"

# Check if the mount directory exists, if not, create it
if [ ! -d "$mount_dir" ]; then
    mkdir -p "$mount_dir"
fi

# Get a list of all connected USB drives
usb_drives=$(lsblk -o NAME,TYPE | grep 'disk' | grep -o 'sd[a-z]')

# Loop through each USB drive and mount it to the specified directory
for drive in $usb_drives; do
    # Construct the device path
    device="/dev/$drive"
    # Construct the mount point
    mount_point="$mount_dir/$drive"
    # Check if the drive is already mounted
    if ! mountpoint -q "$mount_point"; then
        # Mount the USB drive to the specified directory
        sudo mount "$device" "$mount_point"
        echo "Mounted $device to $mount_point"
    else
        echo "$device is already mounted to $mount_point"
    fi
done
