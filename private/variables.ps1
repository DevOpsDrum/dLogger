<#
ideas:
- logging level
- datetime format
- create some variables with "Private" option, so they're not visible to user # https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes?view=powershell-7.2#powershell-scopes
#>

<#
sample:
# setup a global variable for script settings
$session = [ordered]@{
    BaseUri               = $null
    ResourcesUri          = $null
    AuthToken             = $null
    ResourceEntitiesRoute = "resources"
    ResourceSearchRoute   = "search"
}

New-Variable -Name session -Value $session -Scope Script -Force
#>