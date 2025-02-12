# esxi-vmfs-recovery
ESXi VMFS Recovery bash script 🚀 A bash script for recovering VMFS datastores on ESXi!  Why This Project? ESXi VMFS corruption can occur due to:  Unexpected shutdowns (power failure, mishandling or backup process interruption can leads of disk block write failures in ESXi) we can use crefully disk recovery process with the help of ESXi built-in-tools. 

 ESXi VMFS Recovery Tool

 **Why This Project?**

This project provides a script to help recover a damaged VMFS datastore on ESXi. Often, VMFS corruption occurs due to mishandling, sudden shutdowns, interrupted backups, or unexpected reboots. Instead of reinstalling ESXi, this script provides methods to diagnose and fix VMFS issues.

 **Author**
Qamar Paracha**

 **Features**

- Check VMFS status
- Run **VOMA** to scan and fix metadata corruption
- Unlock and repair VMFS volumes
- Clone a damaged disk using **ddrescue**

 **Requirements**

- ESXi 6.5 or newer
- SSH access enabled on the ESXi host

 **Usage**

1. Download and copy the script to your ESXi host:
   ```sh
   wget https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/esxi-vmfs-recovery/main/vmfs_recovery.sh
   chmod +x vmfs_recovery.sh
   ```
2. Run the script:
   ```sh
   ./vmfs_recovery.sh
   ```
3. Follow the interactive menu to perform recovery actions.

**Menu Options**

| Option | Description           |
| ------ | --------------------- |
| 1      | Check VMFS Status     |
| 2      | Run VOMA Scan         |
| 3      | Fix VMFS Metadata     |
| 4      | Clone Disk (ddrescue) |
| 5      | Exit                  |

**Example Commands**

- **Check VMFS Status:**
  ```sh
  esxcli storage filesystem list
  esxcli storage core device list
  ```
- **Run VOMA to check for corruption:**
  ```sh
  voma -m vmfs -d /dev/disks/naa.xxxxxxxx
  ```
- **Fix VMFS metadata corruption:**
  ```sh
  voma -m vmfs -d /dev/disks/naa.xxxxxxxx -s fix
  ```
- **Clone a disk with ddrescue:**
  ```sh
  ddrescue -r3 /dev/disks/naa.src /dev/disks/naa.dest /vmfs/volumes/datastore1/ddrescue.log
  ```

**License**
This project is licensed under the MIT License - see the LICENSE file for details.

**Disclaimer**
This script is provided as-is. Use it at your own risk. Always back up critical data before performing recovery actions.

---

 🚀 Contribute & Improve!
If you have suggestions or improvements, feel free to contribute!

