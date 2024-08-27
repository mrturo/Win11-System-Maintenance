# Save the current location
$currentLocation = Get-Location

function Delete-Temps {
    # Get the path of the temp directory
    $tempPath = [System.Environment]::GetEnvironmentVariable("TEMP", "User")

    # Get all files and folders in the temp directory
    $items = Get-ChildItem -Path $tempPath -Recurse

    # Display the count of found items
    Write-Host "Found $($items.Count) items in the TEMP folder."

    # Attempt to remove all found items
    Get-ChildItem -Path $tempPath -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

    # Get all files and folders in the temp directory
    $newItems = Get-ChildItem -Path $tempPath -Recurse

    # Display the count of successfully removed items
    Write-Host "Found $($items.Count - $newItems.Count) items were successfully removed from the TEMP folder."}

# Call the function to delete temp files
Delete-Temps

# Restore the original location
Set-Location -Path $currentLocation
