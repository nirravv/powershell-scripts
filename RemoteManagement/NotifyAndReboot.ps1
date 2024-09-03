$notificationMessage = "The system will reboot in 5 minutes. Please save your work."

# Notify users about the impending reboot
msg * /time:300 $notificationMessage

# Wait for 5 minutes (300 seconds) before rebooting
Start-Sleep -Seconds 300

# Force a reboot of the local computer
Restart-Computer -Force

Write-Host "The computer has been rebooted."
