# Powershell Windows Cleanup Scripts
----

For all these scripts please first open your powershell with Administrator privilages. 

- Click on the Start menu.
- Type PowerShell in the search bar.
- Right-click on the Windows PowerShell app and select Run as administrator.

Now run following scripts according to your needs:

1. **Disk Cleanup:** A PowerShell script to clean up temporary files, Recycle Bin, Windows Update cache, and Prefetch files on Windows systems. It frees up disk space and helps maintain system performance. After running, the script automatically deletes itself to keep your system tidy.
        
        iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/Scripts/main/powershell/DiskManagement/disk_cleanup.ps1").Content

2. **Disk Defragmentation:** A PowerShell script to defragment the C: drive on Windows systems. Optionally, you can modify the script to defragment other drives as well. The script helps optimize disk performance.

        iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/Scripts/main/powershell/DiskManagement/disk_defragmentation.ps1").Content

