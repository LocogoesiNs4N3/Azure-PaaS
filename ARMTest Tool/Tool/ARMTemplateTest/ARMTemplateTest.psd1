﻿<#
Module manifest for module 'ARMTemplateTest'

Generated by: Stanislav Zhelyazkov (stanislav.zhelyazkov@lumagate.com) - Principal Consultant - Elite Incubation Team at Lumagate
Innovate | Incubate | Repeat
Generated on: 14/01/2016
#>

@{

# Script module or binary module file associated with this manifest.
RootModule = 'ARMTemplateTest.psm1'

# Version number of this module.
ModuleVersion = '2.0.1'

# ID used to uniquely identify this module
GUID = 'c87626f0-cf4a-48c2-bbda-1bb0550da287'

# Author of this module
Author = 'Stanislav Zhelyazkov'

# Company or vendor of this module
CompanyName = 'Lumagate AS'

# Copyright statement for this module
Copyright = '(c) 2016 Lumagate AS.'

# Description of the functionality provided by this module
Description = 'This module provides testing for Azure Resource Manager Templates.'

# Minimum version of the Windows PowerShell engine required by this module
 PowerShellVersion = '5.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
 RequiredModules = @('AzureRM.profile';
                     'AzureRM.Resources';)

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module
FunctionsToExport = @('Remove-ARMTemplateDeployment' 
                      'Write-ARMTemplateLog'
                      'Move-ARMTemplateFolder'
                      'New-ARMTemplateDeployment'
                      'Get-GitHubRepositoryMasterArchive'
                      'Expand-GitHubMasterArchive'
                      'Merge-ARMTemplateLog'
                      'Test-ARMTemplate'
                      'Add-ARMTemplateLogin'
                      'Set-ARMTemplateParameterFile'
                      'Set-ARMTemplateFile'
                      'Export-ARMTemplateLogToCSV'
                      'Get-ARMTemplateRandomStorageAccountName'
                      'Get-ARMTemplateRandomPassword'
                      )

# Cmdlets to export from this module
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = '*'

# List of all modules packaged with this module
ModuleList = @('ARMTemplateTest.psm1')

# List of all files packaged with this module
 FileList = @(
              'ARMTemplateTest.psd1'
              'ARMTemplateTest.psm1'
 )

# Private data to pass to the module specified in RootModule/ModuleToProcess
# PrivateData = ''

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}