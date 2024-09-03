# Function to display session information in a more user-friendly format
function Display-SessionInfo {
    param (
        [array]$sessionInfo
    )
    Write-Host "Currently logged-in and disconnected users:" -ForegroundColor Cyan
    $sessionInfo | Format-Table -Property SessionId, Username, State, SessionName, IdleTime, LogonTime -AutoSize
    Write-Host ""
}

# Retrieve and list the active and disconnected user sessions
$sessionInfo = query user | ForEach-Object {
    if ($_ -match '^\s*([\>\w]+)\s+(\w*)\s+(\d+)\s+(\w+)\s+([\d:]+)\s+([\d\/]+\s+[\d:APM]+)') {
        [PSCustomObject]@{
            Username    = $matches[1].Trim()
            SessionName = $matches[2].Trim()
            SessionId   = $matches[3].Trim()
            State       = $matches[4].Trim()
            IdleTime    = $matches[5].Trim()
            LogonTime   = $matches[6].Trim()
        }
    }
}

if ($sessionInfo.Count -eq 0) {
    Write-Host "No users are currently logged in or disconnected." -ForegroundColor Yellow
    return
}

# Display the session information
Display-SessionInfo -sessionInfo $sessionInfo

# Prompt the user to select a session ID to log off
$sessionIdToLogOff = Read-Host "Enter the Session ID of the user you want to log off (or type 'exit' to quit)"

# Allow user to exit the script
if ($sessionIdToLogOff -eq 'exit') {
    Write-Host "Exiting script." -ForegroundColor Green
    return
}

# Validate the selected session ID
$selectedSession = $sessionInfo | Where-Object { $_.SessionId -eq $sessionIdToLogOff }

if ($null -eq $selectedSession) {
    Write-Host "Invalid Session ID. No action taken." -ForegroundColor Red
} else {
    # Log off the selected user session
    logoff $sessionIdToLogOff
    Write-Host "User session $sessionIdToLogOff ($($selectedSession.Username)) has been logged off." -ForegroundColor Green
}
