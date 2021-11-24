# How to create a PowerShell module?
This is how I created the dLogger PowerShell module.

Reference: [MS documentation](https://docs.microsoft.com/en-us/powershell/scripting/developer/module/how-to-write-a-powershell-module-manifest?view=powershell-7.2).

## Create standard files and folders (psm1)
---
Create a few directories and a couple files to get things started. 

```PowerShell
# create directories for private scripts, public scripts, and pester test scripts
New-Item -Name 'private' -ItemType Directory
New-Item -Name 'public' -ItemType Directory
New-Item -Name 'tests' -ItemType Directory

$psm1Contents = @'
$scriptPath = Split-Path $MyInvocation.MyCommand.Path
$psModule = $ExecutionContext.SessionState.Module
$psModuleRoot = $psModule.ModuleBase # can be used in other module scripts
Write-Verbose "PS module root: $psModuleRoot"

# Dot source public/private functions
$publicFunctions = @(Get-ChildItem -Path "$scriptPath\public" -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue)
$privateFunctions = @(Get-ChildItem -Path "$scriptPath\private" -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue)

$allFunctions = $publicFunctions + $privateFunctions
foreach ($function in $allFunctions) {
    try
    {
        . $Function.FullName
    }
    catch
    {
        throw ('Unable to dot source {0}' -f $Function.FullName)
    }
}

Export-ModuleMember -Function $publicFunctions.BaseName # -Variable @() -Alias @()
'@
$psm1Contents | Out-File 'dLogger.psm1'

# Create module manifest with minimal parameters
$splat = @{
    ModuleVersion = '0.1'
    Path = '.\dLogger.psd1'
    Author = 'Michael A. Drum'
    Description = 'Functions to make logging in scripts a bit easier'
    Copyright= '(c) Michael A. Drum. All rights reserved.'
    CompanyName = 'n/a'
}
New-ModuleManifest $splat

# Import module to to confirm module gets imported successfully
Import-Module .\dLogger.psd1 -Force -Verbose
# alternate way to test module manifest: Test-ModuleManifest dLogger.psd1
```

## Create public functions
---
TODO:
## Create private functions to support public functions
---
TODO:
## Test module manifest


