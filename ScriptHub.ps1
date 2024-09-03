function Show-Menu {
    Write-Host "Powershell Scripts" -ForegroundColor Cyan
    Write-Host "-------------------"
    Write-Host "1: Disk Management"
    Write-Host "2: Remote Management"
    Write-Host "3: User Management"
    Write-Host "4: Exit"
}

function Show-DiskManagementMenu {
    Write-Host "Disk Management" -ForegroundColor Cyan
    Write-Host "1: Cleanup Temporary Files"
    Write-Host "2: Defragment C Drive"
    Write-Host "3: Back to Main Menu"
}

function Show-RemoteManagementMenu {
    Write-Host "Remote Management" -ForegroundColor Cyan
    Write-Host "1: Enable/Disable Remote Desktop"
    Write-Host "2: Install/Uninstall or Enable/Disable OpenSSH"
    Write-Host "3: Back to Main Menu"
}

function Show-UserManagementMenu {
    Write-Host "User Management" -ForegroundColor Cyan
    Write-Host "1: Add/Remove User and Manage Passwords"
    Write-Host "2: Logoff Selected User's Session"
    Write-Host "3: Back to Main Menu"
}

function Run-DiskManagement {
    do {
        Show-DiskManagementMenu
        $choice = Read-Host "Enter your choice (1-3)"
        switch ($choice) {
            1 { iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/powershell-scripts/main/DiskManagement/disk_cleanup.ps1").Content }
            2 { iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/powershell-scripts/main/DiskManagement/disk_defragmentation.ps1").Content }
            3 { return }
            default { Write-Host "Invalid choice, please select again." -ForegroundColor Red }
        }
    } while ($true)
}

function Run-RemoteManagement {
    do {
        Show-RemoteManagementMenu
        $choice = Read-Host "Enter your choice (1-3)"
        switch ($choice) {
            1 { iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/powershell-scripts/main/RemoteManagement/Enable-DisableRemoteDesktop.ps1").Content }
            2 { iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/powershell-scripts/main/RemoteManagement/Enable-DisableOpenSSH.ps1").Content }
            3 { return }
            default { Write-Host "Invalid choice, please select again." -ForegroundColor Red }
        }
    } while ($true)
}

function Run-UserManagement {
    do {
        Show-UserManagementMenu
        $choice = Read-Host "Enter your choice (1-3)"
        switch ($choice) {
            1 { iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/powershell-scripts/main/UserManagement/UserManagement.ps1").Content }
            2 { iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nirravv/powershell-scripts/main/UserManagement/LogoffUserSession.ps1").Content }
            3 { return }
            default { Write-Host "Invalid choice, please select again." -ForegroundColor Red }
        }
    } while ($true)
}

# Main Menu
do {
    Show-Menu
    $mainChoice = Read-Host "Enter your choice (1-4)"
    switch ($mainChoice) {
        1 { Run-DiskManagement }
        2 { Run-RemoteManagement }
        3 { Run-UserManagement }
        4 { Write-Host "Exiting script." -ForegroundColor Green; break }
        default { Write-Host "Invalid choice, please select again." -ForegroundColor Red }
    }
} while ($true)
