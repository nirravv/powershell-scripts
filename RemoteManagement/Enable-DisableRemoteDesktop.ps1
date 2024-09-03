# Check current Remote Desktop status
$currentStatus = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections"
if ($currentStatus.fDenyTSConnections -eq 0) {
    Write-Host "Remote Desktop is currently ENABLED."
} else {
    Write-Host "Remote Desktop is currently DISABLED."
}

# Prompt the user to enable, disable, or exit
Write-Host "Select an option:"
Write-Host "1: Enable Remote Desktop"
Write-Host "2: Disable Remote Desktop"
Write-Host "3: Exit"
$choice = Read-Host "Please enter your choice (1, 2, or 3)"

# Enable or disable Remote Desktop based on user input
switch ($choice) {
    1 {
        Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
        Write-Host "Remote Desktop has been ENABLED."
    }
    2 {
        Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 1
        Write-Host "Remote Desktop has been DISABLED."
    }
    3 {
        Write-Host "Exiting without making any changes."
        return
    }
    default {
        Write-Host "Invalid input. No changes were made."
    }
}
