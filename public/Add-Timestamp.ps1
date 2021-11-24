filter Add-Timestamp { "$(Get-Date -AsUTC -Format "yyyy-MM-dd HH:mm:ss.fff'Z'"): $_" }

Set-Alias -Name timestamp -Value Add-Timestamp -Scope Script

<#
the filter above is the same as as this function, but the filter is a bit more streamlined

function Add-TimeStamp { process { "$(Get-Date -AsUTC -Format "yyyy-MM-dd HH:mm:ss.fff'Z'"): $_"  } }
#>