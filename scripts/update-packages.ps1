# Script to update all applications with winget on Windows 11

# Define a function to get upgradable packages
function Get-UpgradablePackages {
    $upgradablePackages = @()
	$wingetOutput = winget upgrade --all --include-unknown
	$wingetLines = $wingetOutput -split "`n"
	$wingetLines | ForEach-Object {
		$line = $_
		if ($line -match '\swinget$') {
			$lineWithoutWinget = $line -replace '\swinget$', ''
			$processedLine = $lineWithoutWinget.Trim()
			$fields = $processedLine -split '\s+'
			$finalLine = ($fields[0..($fields.Length - 3)] -join ' ').Trim()
			$lastField = $finalLine -split '\s+' | Select-Object -Last 1
			$packageId = $lastField.Trim()
			if ($packageId -ne "Id") {
				$upgradablePackages += $packageId
			}
		}
	}
    return $upgradablePackages
}

# Get the list of upgradable packages
Write-Host "Checking for available updates..."
$upgradablePackages = Get-UpgradablePackages
$packageCount = $upgradablePackages.Count

# Check if there are no upgradable packages and stop if none
if ($packageCount -eq 0) {
    Write-Host "No upgradable packages found."
} else {
	# Attempt to update each package individually
	foreach ($packageId in $upgradablePackages) {
		Write-Host ""
		Write-Host " * ${packageId}"
		$isPinned = winget pin list | Select-String -Pattern $packageId
		if ($isPinned) {
			Write-Host "     Is pinned. Attempting to unpin..."
			winget pin remove --id $packageId
			Start-Sleep -Seconds 2  # Give some time for the unpin to take effect
		} else {
			Write-Host "     Is not pinned or already unpinned."
		}
		winget upgrade --id $packageId
	}
	Write-Host ""
	Write-Host "Update process completed."
	Write-Host ""
	# Final check for any remaining updates
	Write-Host "Checking for any remaining updates..."
	$remainingUpdates = Get-UpgradablePackages
	$remainingUpdatesCount = $remainingUpdates.Count
	if ($remainingUpdatesCount -eq 0) {
		Write-Host "All packages are fully updated."
	} else {
		Write-Host "There is/are still ${remainingUpdatesCount} upgradable package(s) available:"
		$remainingUpdates | ForEach-Object { Write-Host " * ${_}" }
	}
}
