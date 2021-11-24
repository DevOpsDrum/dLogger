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

# exporting functions here is much easier than manually updating psd1 file with functions
Export-ModuleMember -Function $publicFunctions.BaseName # -Variable @() -Alias @()
