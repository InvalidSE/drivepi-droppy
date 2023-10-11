#!/bin/bash

# Specify the target directory where USB drives will be mounted
mount_dir="/SambaShare"

# Check if the mount directory exists, if not, create it
if [ ! -d "$mount_dir" ]; then
    mkdir -p "$mount_dir"
    echo "Created mount directory: $mount_dir"
fi

# Get a list of all connected USB drive partitions
usb_partitions=$(lsblk -o NAME,FSTYPE,TYPE,MOUNTPOINT | grep 'part' | grep -o 'sd[a-z][0-9]')

# Loop through each USB partition and mount it to the specified directory
for partition in $usb_partitions; do
    # Construct the device path
    device="/dev/$partition"
    # Construct the mount point
    mount_point="$mount_dir/$(basename $partition)"
    # Check if the mount point directory exists, if not, create it
    if [ ! -d "$mount_point" ]; then
        mkdir -p "$mount_point"
        echo "Created mount point: $mount_point"
    fi
    # Check if the partition is already mounted, if yes, unmount it first
    if mountpoint -q "$mount_point"; then
        sudo umount "$mount_point"
        echo "Unmounted $mount_point"
    fi
    # Mount the USB partition to the specified directory
    sudo mount "$device" "$mount_point"
    echo "Mounted $device to $mount_point"
done
