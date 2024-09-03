## Remote Management Powershell Commands
---

1. **Enable OR Disable RDP:** : This script provides a safe and clear way for the user to either enable or disable Remote Desktop or exit the script without making any changes.

        iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/Scripts/main/powershell/RemoteManagement/Enable-DisableRemoteDesktop.ps1").Content

2. **Install/Uninstall OR Enable/Disable openSSH:** This script provides a safe and clear way for the user to either install/Uninstall or Enable/Disable OpenSSH Server using the script without making any changes.

        iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/Scripts/main/powershell/RemoteManagement/Enable-DisableOpenSSH.ps1").Content