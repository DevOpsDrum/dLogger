# Test Documentation

## Pester
TODO: add stuff

## PSScriptAnalyzer
Static code analysis using PSScriptAnalyzer [repo and documentation](https://github.com/PowerShell/PSScriptAnalyzer)

### Installation
* Install PS module
    ```PowerShell
    Install-Module -Name PSScriptAnalyzer
    ```
* Run test in docker container
    ```sh
    docker run -it mcr.microsoft.com/powershell pwsh -c "Install-Module PSScriptAnalyzer -Force; Invoke-ScriptAnalyzer -ScriptDefinition 'gci'"
    ```

> Confirm installation by running `Get-ScriptAnalyzerRule`

### Run tests
```PowerShell
# use PSGallery settings
# Invoke-ScriptAnalyzer -Path </path/to/module/> -Recurse
Invoke-ScriptAnalyzer -Path ./ -Recurse -Settings CodeFormatting
Invoke-ScriptAnalyzer -Path ./ -Recurse -Settings CodeFormattingAllman
Invoke-ScriptAnalyzer -Path ./ -Recurse -Settings CodeFormattingOTBS
Invoke-ScriptAnalyzer -Path ./ -Recurse -Settings CodeFormattingStroustrup
Invoke-ScriptAnalyzer -Path ./ -Recurse -Settings PSGallery 
Invoke-ScriptAnalyzer -Path ./ -Recurse -Settings ScriptFunctions
Invoke-ScriptAnalyzer -Path ./ -Recurse -Settings ScriptingStyle
Invoke-ScriptAnalyzer -Path ./ -Recurse -Settings ScriptSecurity
# I don't think CmdletDesign and DSC would be helpful
```

#### Output as JUnit XML
When running in a pipeline, it is very helpful to produce output as JUnitXML, as that is the standard unit test report format.
At this time, the PSScriptAnalyzer module does not have the capability, but the `.\private\Export-NUnitXml.ps1` can produce NUnit XML. 

```PowerShell
# dot source Export-NUnitXML function
. .\private\Export-NUnitXml.ps1
# pipe output of script analyzer to Export-NUnitXML function
$result = Invoke-ScriptAnalyzer -Path ./ -Recurse -Settings PSGallery
Export-NUnitXml -ScriptAnalyzerResult $result -Path ./psscriptanalyzer-nunit.xml
```

### Suppress Rules
Suppress a rule by decorating script/function or parameter with .Net's SuppressMessageAttribute
```PowerShell
function SuppressMe()
{
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSProvideCommentHelp', '', Justification='Just an example')]
    param()

    Write-Verbose -Message "I'm making a difference!"

}
```

There are additional examples and scenarios in the [documentation](https://github.com/PowerShell/PSScriptAnalyzer#suppressing-rules).

### Violation Correction
You can have module automatically apply fix using `-Fix` param, as shown in [documentation](https://github.com/PowerShell/PSScriptAnalyzer#violation-correction).
`Invoke-ScriptAnalyzer` implements `SupportsShouldProcess` so you can use `-WhatIf` or `-Confirm` to see what would be done.
