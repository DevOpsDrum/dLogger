# [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidTrailingWhitespace', '', Justification = 'unnecessary')]
# [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSPlaceOpenBrace', '', Justification = 'prefer C# formatting')]
# param() # having param here prevents line above from producing parsing error "UnexpectedAttribute"

<#PSScriptInfo

.VERSION 1.0

.GUID 3341ada7-310e-4cb8-984d-33f641105779

.AUTHOR MichaelDrum

.COMPANYNAME

.COPYRIGHT

.TAGS

.LICENSEURI

.PROJECTURI

.ICONURI

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES


.PRIVATEDATA

#> 
function Test-Module
{
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidTrailingWhitespace', '', Justification = 'not helpful')]
    [CmdletBinding()]
    param()
    
    Write-Output "Testing dLogger module"
}
