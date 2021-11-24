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
Install-ModuleFromGitHub -GitHubRepo madrum/dLogger
```

* Clone repo and import module
```PowerShell
# clone repo
cd $home\repos
git clone https://github.com/madrum/dLogger.git

# import module
Import-Module -Name .\dLogger -Force -Verbose -noclobber
# use `-NoClobber` and `-Prefix d` if function names may overlap with others in session
```

## Functions
TODO:

# Contribute
[Create PowerShell Module](docs/create-ps-module.md)
