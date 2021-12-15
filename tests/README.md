# Test Documentation

## Pester
TODO: add stuff

## PSScriptAnalyzer
Static code analysis using PSScriptAnalyzer [repo and documentation](https://github.com/PowerShell/PSScriptAnalyzer)

### Example usage
This is a [good example](https://cloudlumberjack.com/posts/ado-pr-psscriptanalyzer/) of using PSScriptAnalyzer in an ADO pipeline

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
Invoke-ScriptAnalyzer -Path ./ -Recurse -Settings ./tests/PSScriptAnalyzerSettings.psd1
```

#### Output as NUnit XML
When running in a pipeline, it is very helpful to produce output as JUnitXML, as that is the standard unit test report format.
The PSScriptAnalyzer module does not export to specific formats, but the `.\private\Export-NUnitXml.ps1` can produce NUnit XML for us. 

```PowerShell
# dot source Export-NUnitXML function
. .\tests\Export-NUnitXml.ps1
# pipe output of script analyzer to Export-NUnitXML function
$result = Invoke-ScriptAnalyzer -Path ./ -Recurse -Settings ./tests/PSScriptAnalyzerSettings.psd1
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
