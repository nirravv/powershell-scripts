# Powershell Scripts
---

### [DiskManagement](DiskManagement/README.md)

* For windows temporaty files Cleanups with one command:

        iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/powershell-scripts/main/DiskManagement/disk_cleanup.ps1").Content

* Disk Defragmentation of C drive using single command:

        iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/powershell-scripts/main/DiskManagement/disk_defragmentation.ps1").Content
---
### [RemoteManagement](RemoteManagement/README.md)

* Enable/Disable RDP using a single command:

        iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/powershell-scripts/main/RemoteManagement/Enable-DisableRemoteDesktop.ps1").Content

* Install/Uninstall OR Enable/Disable OpenSSH using one command:

        iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/powershell-scripts/main/RemoteManagement/Enable-DisableOpenSSH.ps1").Content

---
### [UserManagement](UserManagement/README.md)

* Add/Remove User and change userpasswords, Add/Remove user to Administrators Group using single command:

        iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/powershell-scripts/main/UserManagement/UserManagement.ps1").Content

* Logoff selected user's session using single command:

        iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/powershell-scripts/main/UserManagement/LogoffUserSession.ps1").Content
