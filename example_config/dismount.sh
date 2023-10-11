#!/bin/bash

# Specify the directory where folders are mounted
mount_dir="/SambaShare"

# Unmount all mounted folders in the specified directory
sudo umount -l "$mount_dir"/*

# Delete empty folders in the specified directory
find "$mount_dir" -type d -empty -delete

echo "Unmounted all folders in $mount_dir and deleted empty folders."
