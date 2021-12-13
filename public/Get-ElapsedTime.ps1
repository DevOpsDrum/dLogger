# [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidTrailingWhitespace', '', Justification = 'unnecessary')]
# [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSPlaceOpenBrace', '', Justification = 'prefer C# formatting')]
# [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSPlaceCloseBrace', '', Justification = 'unnecessary')]
# param() # having param here prevents line above from producing parsing error "UnexpectedAttribute"

<#
.SYNOPSIS
    Get elapsed time
.DESCRIPTION
    Return the elapsed time since $script:startTime, or since function was first called in session, in format "[22m4s elapsed]"
    This is useful when script is waiting on a dependency or you want to see how long sections of a script are taking to execute
.EXAMPLE
    PS> Get-ElapsedTimes
    PS> [4m14s elapsed]
    Get elapsed time since $script:startTime, or since function was first called in session
    
    PS> Write-Host "This is a helpful message $(Get-ElapsedTime)"
    PS> This is a helpful message [6m14s elapsed]
    
    PS> Get-ElapsedTimes -ResetStartTime
    PS> [0m0s elapsed]
    Reset start time to current time
.INPUTS
    n/a
.OUTPUTS
    String in format "[6m14s elapsed]"
.NOTES
    General notes
#>
function Get-ElapsedTime
{
    [Alias("elapsed", "et")]
    [OutputType([String])]
    [CmdletBinding()]
    param(
        [Alias("Reset", "Restart")]
        [parameter(HelpMessage = "Reset start time to current time")]
        [switch] $ResetStartTime
    )
    
    if ($null -eq $script:startTime)
    {
        $script:startTime = Get-Date
        Write-Verbose "'`$script:startTime' var not declared yet, so creating now and setting to current time: $($script:startTime)"
    }
    else
    {
        if ($ResetStartTime)
        {
            $script:startTime = Get-Date
            Write-Verbose "Resetting start time: $script:startTime"
        }
        else
        {
            Write-Verbose "Start time: $script:startTime"
        }
    }
    
    $now = Get-Date
    $elapsedTime = $now - ($script:startTime)
    # [math]::floor([decimal]) Returns the largest integral value less than or equal to the specified number,
    # i.e. the whole number without the decimal, e.g. `4.7` will be `4`, not `5`, as would be the case when casting `4.7` as an int like this, `[int]'4.7'`
    $msg = "[$([math]::floor($elapsedTime.TotalMinutes))m$($elapsedTime.Seconds)s elapsed]"
    
    return $msg
}