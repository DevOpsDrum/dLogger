# PSScriptAnalyzer settings for this repo. 
# Reference: https://github.com/PowerShell/PSScriptAnalyzer/blob/master/README.md#settings-support-in-scriptanalyzer
@{
    Severity     = @('Error', 'Warning')
    IncludeRules = @(
        'PSAlignAssignmentStatement', # CodeFormatting
        'PSAvoidDefaultValueSwitchParameter', # CmdletDesign, PSGallery
        'PSAvoidGlobalVars', # PSGallery
        'PSAvoidUsingCmdletAliases', # PSGallery
        'PSAvoidUsingComputerNameHardcoded', # PSGallery
        'PSAvoidUsingConvertToSecureStringWithPlainText', # ScriptSecurity
        'PSAvoidUsingEmptyCatchBlock', # PSGallery
        'PSAvoidUsingInvokeExpression', # PSGallery
        'PSAvoidUsingPlainTextForPassword', # PSGallery
        'PSAvoidUsingPositionalParameters', # PSGallery
        'PSAvoidUsingUserNameAndPasswordParams', # ScriptSecurity
        'PSAvoidUsingWMICmdlet', # PSGallery
        'PSAvoidUsingWriteHost', # ScriptingStyle
        'PSDSC*', # PSGallery
        'PSMissingModuleManifestField', # CmdletDesign, PSGallery
        'PSPlaceCloseBrace', # CodeFormatting
        'PSPlaceOpenBrace', # CodeFormatting
        'PSProvideCommentHelp', # ScriptingStyle
        'PSReservedCmdletChar', # CmdletDesign, PSGallery
        'PSReservedParams', # CmdletDesign, PSGallery
        'PSShouldProcess', # CmdletDesign, PSGallery
        'PSUseApprovedVerbs', # CmdletDesign, PSGallery
        'PSUseCmdletCorrectly', # PSGallery
        'PSUseConsistentIndentation', # CodeFormatting
        'PSUseConsistentWhitespace', # CodeFormatting
        'PSUseCorrectCasing', # CodeFormatting
        'PSUseDeclaredVarsMoreThanAssignments', # PSGallery
        'PSUsePSCredentialType', # PSGallery
        'PSUseShouldProcessForStateChangingFunctions', # CmdletDesign, PSGallery
        'PSUseShouldProcessForStateChangingFunctions', # PSGallery
        'PSUseSingularNouns' # CmdletDesign, PSGallery
    )

    # CodeFormattingAllman rules
    Rules        = @{
        PSPlaceOpenBrace           = @{
            Enable             = $true
            OnSameLine         = $false
            NewLineAfter       = $true
            IgnoreOneLineBlock = $true
        }

        PSPlaceCloseBrace          = @{
            Enable             = $true
            NewLineAfter       = $true
            IgnoreOneLineBlock = $true
            NoEmptyLineBefore  = $false
        }

        PSUseConsistentIndentation = @{
            Enable              = $true
            Kind                = 'space'
            PipelineIndentation = 'IncreaseIndentationForFirstPipeline'
            IndentationSize     = 4
        }

        PSUseConsistentWhitespace  = @{
            Enable                                  = $true
            CheckInnerBrace                         = $true
            CheckOpenBrace                          = $true
            CheckOpenParen                          = $true
            CheckOperator                           = $true
            CheckPipe                               = $true
            CheckPipeForRedundantWhitespace         = $false
            CheckSeparator                          = $true
            CheckParameter                          = $false
            IgnoreAssignmentOperatorInsideHashTable = $true
        }

        PSAlignAssignmentStatement = @{
            Enable         = $true
            CheckHashtable = $true
        }

        PSUseCorrectCasing         = @{
            Enable = $true
        }
    }
}