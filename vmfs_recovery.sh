#!/bin/bash
# ESXi VMFS Recovery Script
# Author: Qamar Paracha
# Description: This script helps recover a damaged VMFS datastore on ESXi due to mishandling.

LOGFILE="/var/log/vmfs_recovery.log"
exec > >(tee -i $LOGFILE)
exec 2>&1

# Function to check VMFS status
check_vmfs() {
    echo "Checking VMFS health..."
    esxcli storage filesystem list
    esxcli storage core device list | grep -i "naa"
}

# Function to run VOMA scan
run_voma() {
    read -p "Enter the NAA ID of the disk (e.g., naa.123456789): " NAA_ID
    echo "Running VOMA check on $NAA_ID..."
    voma -m vmfs -d /dev/disks/$NAA_ID
}

# Function to fix VMFS metadata issues
fix_vmfs() {
    read -p "Enter the NAA ID of the disk: " NAA_ID
    echo "Attempting to fix VMFS metadata on $NAA_ID..."
    voma -m vmfs -d /dev/disks/$NAA_ID -s fix
}

# Function to clone disk using ddrescue
clone_disk() {
    read -p "Enter source disk NAA ID: " SRC
    read -p "Enter target disk NAA ID: " DEST
    echo "Cloning $SRC to $DEST..."
    ddrescue -r3 /dev/disks/$SRC /dev/disks/$DEST /vmfs/volumes/datastore1/ddrescue.log
}

# Menu options
while true; do
    echo "\n=== ESXi VMFS Recovery Menu ==="
    echo "1. Check VMFS Status"
    echo "2. Run VOMA Scan"
    echo "3. Fix VMFS Metadata"
    echo "4. Clone Disk (ddrescue)"
    echo "5. Exit"
    read -p "Choose an option: " OPTION
    case $OPTION in
        1) check_vmfs ;;
        2) run_voma ;;
        3) fix_vmfs ;;
        4) clone_disk ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option, try again." ;;
    esac
done
