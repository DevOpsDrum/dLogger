$scriptPath = Split-Path $MyInvocation.MyCommand.Path
$psModule = $ExecutionContext.SessionState.Module
$psModuleRoot = $psModule.ModuleBase # can be used in other module scripts
Write-Verbose "PS module root: $psModuleRoot"

# Dot source public/private functions
$publicFunctions = @(Get-ChildItem -Path "$scriptPath\public" -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue)
$privateFunctions = @(Get-ChildItem -Path "$scriptPath\private" -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue)

$allFunctions = $publicFunctions + $privateFunctions
foreach ($function in $allFunctions)
{
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

#TODO: use Update-ModuleManifest to update manifest file (psd1) with functions to export
Update-ModuleManifest -Function $publicFunctions.BaseName
