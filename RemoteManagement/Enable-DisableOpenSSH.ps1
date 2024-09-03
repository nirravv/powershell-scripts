# Function to check the status of OpenSSH Server
function Check-OpenSSHStatus {
    Write-Host "Checking OpenSSH Server status..."

    $openssh = Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*'
    $sshdService = Get-Service -Name sshd -ErrorAction SilentlyContinue

    if ($openssh.State -eq "Installed") {
        Write-Host "OpenSSH Server is installed."

        if ($sshdService.Status -eq "Running") {
            Write-Host "OpenSSH Server is currently ENABLED and RUNNING."
            return "InstalledEnabled"
        } elseif ($sshdService.Status -eq "Stopped") {
            Write-Host "OpenSSH Server is INSTALLED but DISABLED."
            return "InstalledDisabled"
        }
    } else {
        Write-Host "OpenSSH Server is NOT installed."
        return "NotInstalled"
    }
}

# Function to install OpenSSH Server
function Install-OpenSSHServer {
    Write-Host "Installing OpenSSH Server..."
    $openssh = Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*'

    if ($openssh.State -eq "NotPresent") {
        Add-WindowsCapability -Online -Name "OpenSSH.Server~~~~0.0.1.0"
        Write-Host "OpenSSH Server installed successfully."
    } else {
        Write-Host "OpenSSH Server is already installed."
    }
}

# Function to start and enable OpenSSH Server
function Enable-OpenSSHServer {
    Write-Host "Enabling OpenSSH Server..."
    Set-Service -Name sshd -StartupType 'Automatic'
    Start-Service -Name sshd

    $serviceStatus = Get-Service -Name sshd
    if ($serviceStatus.Status -eq "Running") {
        Write-Host "OpenSSH Server is running."
    } else {
        Write-Host "Failed to start OpenSSH Server."
    }
}

# Function to stop and disable OpenSSH Server
function Disable-OpenSSHServer {
    Write-Host "Disabling OpenSSH Server..."
    Stop-Service -Name sshd
    Set-Service -Name sshd -StartupType 'Disabled'

    $serviceStatus = Get-Service -Name sshd
    if ($serviceStatus.Status -eq "Stopped") {
        Write-Host "OpenSSH Server has been stopped and disabled."
    } else {
        Write-Host "Failed to disable OpenSSH Server."
    }
}

# Function to uninstall OpenSSH Server
function Uninstall-OpenSSHServer {
    Write-Host "Uninstalling OpenSSH Server..."

    # Stop and disable the service before uninstalling
    Disable-OpenSSHServer

    # Uninstall OpenSSH Server
    Remove-WindowsCapability -Online -Name "OpenSSH.Server~~~~0.0.1.0"

    Write-Host "OpenSSH Server uninstalled successfully."
}

# Function to configure the firewall
function Configure-FirewallForSSH {
    Write-Host "Configuring firewall to allow SSH traffic..."
    New-NetFirewallRule -Name "SSH" -DisplayName "OpenSSH Server (sshd)" -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
    Write-Host "Firewall rule added to allow SSH traffic."
}

# Function to verify OpenSSH configuration
function Verify-OpenSSHConfig {
    Write-Host "Verifying OpenSSH Server configuration..."
    $sshdConfigPath = "$env:ProgramData\ssh\sshd_config"
    if (Test-Path $sshdConfigPath) {
        Write-Host "OpenSSH configuration file found at $sshdConfigPath."
        Get-Content $sshdConfigPath | Select-String -Pattern "Port|PermitRootLogin|PasswordAuthentication" | ForEach-Object { Write-Host $_ }
    } else {
        Write-Host "OpenSSH configuration file not found. Please check the installation."
    }
}

# Main script logic
$status = Check-OpenSSHStatus

if ($status -eq "NotInstalled") {
    Write-Host "1: Install OpenSSH Server"
    Write-Host "2: Exit"

    $choice = Read-Host "Please enter your choice (1 or 2)"

    switch ($choice) {
        1 {
            Install-OpenSSHServer
            Enable-OpenSSHServer
            Configure-FirewallForSSH
            Verify-OpenSSHConfig
        }
        2 {
            Write-Host "Exiting without making any changes."
            return
        }
        default {
            Write-Host "Invalid input. No changes were made."
        }
    }
} elseif ($status -eq "InstalledDisabled") {
    Write-Host "1: Enable OpenSSH Server"
    Write-Host "2: Uninstall OpenSSH Server"
    Write-Host "3: Exit"

    $choice = Read-Host "Please enter your choice (1, 2, or 3)"

    switch ($choice) {
        1 {
            Enable-OpenSSHServer
            Configure-FirewallForSSH
            Verify-OpenSSHConfig
        }
        2 {
            Uninstall-OpenSSHServer
        }
        3 {
            Write-Host "Exiting without making any changes."
            return
        }
        default {
            Write-Host "Invalid input. No changes were made."
        }
    }
} elseif ($status -eq "InstalledEnabled") {
    Write-Host "1: Disable OpenSSH Server"
    Write-Host "2: Uninstall OpenSSH Server"
    Write-Host "3: Exit"

    $choice = Read-Host "Please enter your choice (1, 2, or 3)"

    switch ($choice) {
        1 {
            Disable-OpenSSHServer
        }
        2 {
            Uninstall-OpenSSHServer
        }
        3 {
            Write-Host "Exiting without making any changes."
            return
        }
        default {
            Write-Host "Invalid input. No changes were made."
        }
    }
}

Write-Host "Script execution completed."
