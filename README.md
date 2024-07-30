# PowerShell Maintenance Scripts

This repository contains a set of PowerShell scripts designed for system maintenance tasks, such as cleaning Node.js project directories and updating applications using winget on Windows 11.

## Table of Contents

- [Scripts](#scripts)
  - [run-cleanup.ps1](#run-cleanupps1)
  - [node-cleanup.ps1](#node-cleanupps1)
  - [update-packages.ps1](#update-packagesps1)
- [Usage](#usage)

## Scripts

### run-cleanup.ps1
This script runs all maintenance scripts.

#### Usage
```.\run-cleanup.ps1```

### node-cleanup.ps1

This script cleans Node.js project directories by removing dependencies and files generated during the installation and execution of the projects.

#### Parameters
- `reposPath` (string): The base directory containing all the repositories to be cleaned. This parameter is required.

#### Usage
```.\node-cleanup.ps1 -reposPath "C:\path\to\your\node\repos"```

### update-packages.ps1
This script updates all applications using winget on Windows 11.

#### Usage
```.\update-packages.ps1```

## Usage
Clone this repository to your local machine.
Modify the paths and parameters in the scripts according to your needs.
Run the scripts from PowerShell as per the usage instructions provided above.

Make sure you have the necessary permissions to run PowerShell scripts and have correctly set up the execution policy on your system.