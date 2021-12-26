# dLogger PowerShell Module
The dLogger PowerShell module is intended to make logging messages within scripts a bit easier.

# Getting started
Install the module and start using the functions.

## Install and import module
* Install module directly from GitHub repo
``` PowerShell
# install module to install modules from GitHub: InstallModuleFromGitHub
if ($null -eq (Get-Module -ListAvailable -Name InstallModuleFromGitHub)) { Install-Module -Name InstallModuleFromGitHub -Force -Verbose; Import-Module -Name InstallModuleFromGitHub; Get-Command -Module InstallModuleFromGitHub}
# install from GitHub
Install-ModuleFromGitHub -GitHubRepo DevOpsDrum/dLogger
```

* Clone repo and import module
```PowerShell
# clone repo
cd $home\repos
git clone https://github.com/DevOpsDrum/dLogger.git

# import module
Import-Module -Name .\dLogger -Force -Verbose -noclobber
# use `-NoClobber` and `-Prefix d` if function names may overlap with others in session
```

## Functions
* `Add-Timestamp`: Add a timestamp to begging of string. This is used when logging and you want to ensure a timestamp is in the message. 
  * e.g. `Write-Host ("This is a logging message" | Add-Timestamp)`
  * PS > 2021-12-26 22:11:22.189Z: This is a logging message
* `Get-ElapsedTime`: TODO:

# Contribute
[Create PowerShell Module](docs/create-ps-module.md)
