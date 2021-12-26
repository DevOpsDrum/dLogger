# Create PowerShell Module
This is how I created the dLogger PowerShell module.

Reference: [MS documentation](https://docs.microsoft.com/en-us/powershell/scripting/developer/module/how-to-write-a-powershell-module-manifest?view=powershell-7.2)

## Create initial files and folders
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
$psModuleRoot = $psModule.ModuleBase # var can be used in module scripts
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

# exporting functions here is much easier than manually updating psd1 file with function to export
Export-ModuleMember -Function $publicFunctions.BaseName # -Variable @() -Alias @()
'@
$psm1Contents | Out-File 'dLogger.psm1'

# Create module manifest (*.psd1) with minimal parameters
$splat = @{
    ModuleVersion = '0.1'
    Path = '.\dLogger.psd1'
    Author = 'Michael A. Drum'
    Description = 'Functions to make logging in scripts a bit easier'
    Copyright= '(c) Michael A. Drum. All rights reserved.'
    CompanyName = 'n/a'
    ProjectUri = 'https://github.com/DevOpsDrum/dLogger'
    Tags = @('logging', 'logger', 'log', 'logs')
}
New-ModuleManifest $splat

# Import module to confirm module can be imported successfully
Import-Module .\dLogger.psd1 -Force -Verbose
# An alternate way to test module manifest: Test-ModuleManifest dLogger.psd1
```

## Test module and scripts
* Run PSScriptAnalyzer on module, which is required to publish to PSGallery:  
`Invoke-ScriptAnalyzer -Path . -Settings PSGallery -Recurse`
* Run Test-ModuleManifest for modules:  
`Test-ModuleManifest -Path .\dLogger.psd1`
* Run Test-ScriptFileInfo for scripts:  
`Test-ScriptFileInfo`
* Test with docker:  
`docker run -it mcr.microsoft.com/powershell pwsh -c "Install-Module PSScriptAnalyzer -Force; Invoke-ScriptAnalyzer -Recurse -Settings PSGallery"`  
  > todo: add `-v` and proper values to mount current directory as `/work` in image

## Register and publish to PSRepository
Publish to a local PSRepository and/or PSGallery.

* [Microsoft documentation](https://docs.microsoft.com/en-us/powershell/scripting/gallery/how-to/publishing-packages/publishing-a-package?view=powershell-7.2) on publishing modules and scripts
* Publish to PSGallery
  > Ensure modules and scripts have been tested using: [Test module and scripts](#test-module-and-scripts)
```PowerShell
# publish module
Publish-Module -Name <moduleName> -NuGetApiKey <apiKey> -Verbose -WhatIf
# publish script
Publish-Script -Path <scriptPath> -NuGetApiKey <apiKey> -Verbose -WhatIf
```
  * Get API key [here](https://www.powershellgallery.com/account/apikeys) 
* Publish to local file share (unlikely)
```PowerShell
# register local folder as PSRepository
Register-PSRepository -Name 'LocalPSRepo ' -SourceLocation '\\localhost\PSRepoLocal\' -InstallationPolicy Trusted

# publish to repository
Publish-Module -Name myModuleName -Repository LocalPSRepo
```

## Create functions
---
### General
Use command to ensure each script has proper file info
`Update-ScriptFileInfo -Path .\public\test-module.ps1 -force -Description 'Test function'`

### Public functions
Public functions will be exported and available to end users.

### Private functions
Private functions will not be exported and are only available to internal functions.
