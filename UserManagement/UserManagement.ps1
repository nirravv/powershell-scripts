function Get-LocalUsers {
    Get-LocalUser | Where-Object { $_.Enabled -eq $true } | Select-Object -ExpandProperty Name
}

function Get-AdministratorsGroupMembers {
    Get-LocalGroupMember -Group "Administrators" | Select-Object -ExpandProperty Name
}

function Add-User {
    $username = Read-Host "Enter the username to add"
    $password = Read-Host "Enter the password for the new user" -AsSecureString

    New-LocalUser -Name $username -Password $password -PasswordNeverExpires:$true -AccountNeverExpires:$true
    Write-Host "User $username has been added."
}

function Delete-User {
    $users = Get-LocalUsers

    if ($users.Count -eq 0) {
        Write-Host "No local users available to delete."
        return
    }

    Write-Host "Select a user to delete or type 'Back' to return to the main menu:"
    $users | ForEach-Object { Write-Host "$($_): $($_)" }

    $username = Read-Host "Enter the username from the list above"

    if ($username -eq 'Back') {
        return
    } elseif ($users -contains $username) {
        Remove-LocalUser -Name $username
        Write-Host "User $username has been deleted."
    } else {
        Write-Host "Invalid username. No action taken."
    }
}

function Add-UserToAdministrators {
    $users = Get-LocalUsers

    if ($users.Count -eq 0) {
        Write-Host "No local users available to add to the Administrators group."
        return
    }

    Write-Host "Select a user to add to the Administrators group or type 'Back' to return to the main menu:"
    $users | ForEach-Object { Write-Host "$($_): $($_)" }

    $username = Read-Host "Enter the username from the list above"

    if ($username -eq 'Back') {
        return
    } elseif ($users -contains $username) {
        Add-LocalGroupMember -Group "Administrators" -Member $username
        Write-Host "User $username has been added to the Administrators group."
    } else {
        Write-Host "Invalid username. No action taken."
    }
}

function Remove-UserFromAdministrators {
    $adminUsers = Get-AdministratorsGroupMembers

    if ($adminUsers.Count -eq 0) {
        Write-Host "No users available in the Administrators group to remove."
        return
    }

    Write-Host "Select a user to remove from the Administrators group or type 'Back' to return to the main menu:"
    $adminUsers | ForEach-Object { Write-Host "$($_): $($_)" }

    $username = Read-Host "Enter the username from the list above"

    if ($username -eq 'Back') {
        return
    } elseif ($adminUsers -contains $username) {
        Remove-LocalGroupMember -Group "Administrators" -Member $username
        Write-Host "User $username has been removed from the Administrators group."
    } else {
        Write-Host "Invalid username. No action taken."
    }
}

function Change-UserPassword {
    $users = Get-LocalUsers

    if ($users.Count -eq 0) {
        Write-Host "No local users available to change password."
        return
    }

    Write-Host "Select a user to change the password or type 'Back' to return to the main menu:"
    $users | ForEach-Object { Write-Host "$($_): $($_)" }

    $username = Read-Host "Enter the username from the list above"

    if ($username -eq 'Back') {
        return
    } elseif ($users -contains $username) {
        $password = Read-Host "Enter the new password" -AsSecureString
        Set-LocalUser -Name $username -Password $password
        Write-Host "Password for user $username has been changed."
    } else {
        Write-Host "Invalid username. No action taken."
    }
}

function Show-Menu {
    Write-Host "User Management Menu"
    Write-Host "1: Add User"
    Write-Host "2: Delete User"
    Write-Host "3: Add User to Administrators Group"
    Write-Host "4: Remove User from Administrators Group"
    Write-Host "5: Change User Password"
    Write-Host "6: Exit"
}

function Main {
    do {
        Show-Menu
        $choice = Read-Host "Please enter your choice (1-6)"

        switch ($choice) {
            1 { Add-User }
            2 { Delete-User }
            3 { Add-UserToAdministrators }
            4 { Remove-UserFromAdministrators }
            5 { Change-UserPassword }
            6 { Write-Host "Exiting..."; break }
            default { Write-Host "Invalid option. Please select a valid option." }
        }
    } while ($choice -ne 6)
}

# Run the main function
Main
