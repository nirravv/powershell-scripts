# Function to verify file count in a directory
function Verify-Cleanup {
    param (
        [string]$Path
    )

    $BeforeCount = (Get-ChildItem -Path $Path -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count
    Write-Host "Before Cleanup: $BeforeCount items in $Path"

    # Run the cleanup command
    try {
        Remove-Item -Path $Path -Recurse -Force -ErrorAction Stop
    } catch {
        Write-Host "Could not delete some items in $Path due to access restrictions."
    }

    $AfterCount = (Get-ChildItem -Path $Path -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count
    Write-Host "After Cleanup: $AfterCount items in $Path"

    if ($AfterCount -lt $BeforeCount) {
        Write-Host "Cleanup Successful for $Path"
    } else {
        Write-Host "Cleanup Failed for $Path"
    }
}

# Verify temporary files deletion
Verify-Cleanup -Path "$env:Temp\*"

# Verify Recycle Bin is empty
$RecycleBinBefore = (Get-ChildItem -Path "C:\$Recycle.Bin\*" -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count
Clear-RecycleBin -Force -ErrorAction SilentlyContinue
$RecycleBinAfter = (Get-ChildItem -Path "C:\$Recycle.Bin\*" -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count
Write-Host "Recycle Bin Cleanup: $RecycleBinBefore -> $RecycleBinAfter"

# Skip Windows Update cache deletion
# Verify-Cleanup -Path "C:\Windows\SoftwareDistribution\Download\*"

# Verify Prefetch files deletion
Verify-Cleanup -Path "C:\Windows\Prefetch\*"
