<#
This script assumes the script file is located two levels deep in the module/repo directory, e.g. ./pipeline/scripts
Use that assumption to get the path the module directory
#>
[CmdletBinding()]
param(
    [string] $ModulePath = (Get-Item (Split-Path $MyInvocation.MyCommand.Path)).Parent.Parent.FullName
)

$manifestFile = Join-Path -Path $ModulePath -ChildPath dLogger.psd1

if (Test-Path -Path $manifestFile)
{
    $publicFunctions = @(Get-ChildItem -Path "$ModulePath\public" -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue)
    Update-ModuleManifest -Path $manifestFile -Function $publicFunctions.BaseName
    Write-Verbose "Module manifest updated in: $ModulePath"
}
else 
{
    Write-Error "Module root not found"
}
