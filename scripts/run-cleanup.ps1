# Base path where the scripts are located
$scriptsPath = "C:\path\to\your\scripts"

# Hash table with script names and their parameters
$scripts = @{
    "update-packages.ps1" = @{}
}

foreach ($scriptName in $scripts.Keys) {
    # Build the full path of the script
    $scriptPath = Join-Path -Path $scriptsPath -ChildPath $scriptName

    # Check if the script exists at the specified path
    if (Test-Path $scriptPath) {
        # Get parameters for the script
        $params = $scripts[$scriptName]

        # Execute the script with parameters
        if ($params.Count -gt 0) {
            # Convert parameters hash table to a dictionary for splatting
            $paramDict = @{}
            foreach ($key in $params.Keys) {
                $paramDict[$key] = $params[$key]
            }
            # Invoke the script with splatting
            & $scriptPath @paramDict
        } else {
            # Run the script without parameters
            & $scriptPath
        }

        Write-Output "The script at '$scriptPath' has been executed successfully."
    } else {
        Write-Output "The script at '$scriptPath' was not found."
    }
}

Read-Host -Prompt "Press Enter to finish"
