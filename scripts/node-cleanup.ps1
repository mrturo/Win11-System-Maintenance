param (
    [string]$reposPath
)

# Check if reposPath parameter is provided
if (-not $reposPath) {
    Write-Host "Error: The parameter 'reposPath' is required."
    exit 1
}

# Save the current location
$currentLocation = Get-Location

function Clean-Repository {
    param ([string]$repoPath)

    try {
        $packageJsonPath = Join-Path -Path $repoPath -ChildPath "package.json"

        # Check if package.json exists in the repository directory
        if (Test-Path $packageJsonPath) {
            Write-Host "Entering repository: $repoPath"
            Set-Location -Path $repoPath

            # Check if the clean script is defined in package.json and run npm run clean
            $npmScripts = & npm run | Out-String
            if ($npmScripts -match "clean-all") {
                Write-Host "Running npm run clean-all in $repoPath"
                & npm run clean-all
            } elseif ($npmScripts -match "clean") {
                Write-Host "Running npm run clean in $repoPath"
                & npm run clean
            } else {
                Write-Host "The clean script is not defined in $repoPath"
            }
        } else {
            # Recursively process subdirectories
            Get-ChildItem -Path $repoPath -Directory | ForEach-Object {
                $subRepo = $_.FullName
                Clean-Repository -repoPath $subRepo
            }
        }
    } catch {
        Write-Host "Error processing repository: $repoPath - $_"
    }
}

# Call the initial function with the base directory
Clean-Repository -repoPath $reposPath

# Restore the original location
Set-Location -Path $currentLocation
