Workflow Test-ARMTemplateInParallel {
<#

    .SYNOPSIS
        Tests ARM Templates in parallel.

    .DESCRIPTION
        Tests ARM Template in parallel. You can specify how
        many ARM Templates can be tested at the same time.
        Downloads master archive with ARM Templates from GitHub 
        repository and expands it  or takes local path with 
        ARM templates. Templates in both location needs to 
        be organized in folders where every folder is a name 
        for ARM template. Every ARM Template folder must contain 
        azuredeploy.json and azuredeploy.parameters.json files. 
        Logins to Azure with user credentials either by Azure 
        Subscribtion ID or Azure Tenant ID. Creates Azure 
        Resource Group with the name of the ARM Template. Finds
        paramaters in azuredeploy.json and azuredeploy.parameters.json'
        matching keywords ('location','region') and replaces them
        with the value from AzureRegion parameter. Adds 
        '-modified' to the file names of changed. Deploys 
        ARM Template from azuredeploy.json/azuredeploy-modified.json 
        and azuredeploy.parameters.json/ 
        azuredeploy.parameters-modified.json. 
        Writes Success and Failed results to log files in each
        ARM template folder. Moves the successful ARM templates 
        to Successful folder and Failed templates to Queued 
        folder. Template folders without azuredeploy.json or
        azuredeploy.parameters.json are moved to Invalid folder.
        If any unexpected error (ex. invalid json) during deployment,
        ARM tempalte is moved to BadError folder. 
        Deletes the Azure Resource Group. Merges all successful 
        deployment logs into one log. Merges all error deployment 
        logs into one log. Outputs the location of summarized error 
        and successful logs and the number of failed, successful,
        invalid and baderror ARM Template deployments. 
        Formats and exports the most important data 
        of Error log to CSV report in table format.

    .PARAMETER  AzureSubscriptionID
        Mandatory parameter. Valid GUID for Azure 
        Subscribtion ID.

    .PARAMETER  AzureTenantID
        Mandatory parameter. Valid GUID for Azure
        Tenant ID.

    .PARAMETER  AzureCredentials
        Mandatory parameter. Valid credentials
        Azure credentials from Azure AD.

    .PARAMETER  AzureRegion
        Mandatory parameter. Valid Azure Region.

    .PARAMETER  GitHubRepositoryURL
        Mandatory parameter. Valid URL to GitHub.com
        master repostiory. This should be the URL to the 
        repository root location. The repository
        must contain ARM templates organized in folders.
        In each folder azuredeploy.json and
        azuredeploy.parameters.json must be present.
        Example https://github.com/Azure/azure-quickstart-templates

    .PARAMETER  ARMTemplatesPath
        Mandatory parameter. Location to folder with
        ARM templates organized in seperate fodler.
        In each ARM template folder azuredeploy.json and
        azuredeploy.parameters.json must be present.
        Example D:\ARMTEST\Downloaded

    .PARAMETER  OutputPath
        Mandatory parameter. Location for testing
        the ARM template/s.
        Example D:\ARMTEST

    .PARAMETER  ParallelTests
        Optional parameter. Soecifies the number
        of ARM Templates to Test in parallel.
        Default number is 3.
    
    .PARAMETER  ARMTemplateName
        Optional parameter. ARM Template Name or array of
        ARM Template Names.
        Example 101-application-gateway-create, 
        101-application-gateway-public-ip.

    .PARAMETER  ChangeLocationParameterValue
        Optional parameter. If used will 
        search for Location parameter in 
        azuredeploy.json and azuredeploy.parameters.json 
        files and change it if found.

    .PARAMETER  ChangeStorageAccountNameParameterValue
        Optional parameter. If used will 
        search for Storage Account Name parameter in 
        azuredeploy.json and azuredeploy.parameters.json 
        files and change it if found.

    .PARAMETER  ChangeStorageAccountNamePrefixParameterValue
        Optional parameter. If used will 
        search for Storage Account Name Prefix parameter in 
        azuredeploy.json and azuredeploy.parameters.json 
        files and change it if found.

    .PARAMETER  ChangeDNSLabelParameterValue
        Optional parameter. If used will 
        search for DNS Label parameter in 
        azuredeploy.json and azuredeploy.parameters.json 
        files and change it if found.

    .PARAMETER  ChangePasswordParameterValue
        Optional parameter. If used will 
        search for Password parameter in 
        azuredeploy.json and azuredeploy.parameters.json 
        files and change it if found.

    .PARAMETER  ChangeSSHKeyDataParameterValue
        Optional parameter. If used will 
        search for SSH Key Data parameter in 
        azuredeploy.json and azuredeploy.parameters.json 
        files and change it if found.

    .PARAMETER  ChangeVMNameParameterValue
        Optional parameter. If used will 
        search for VM Name parameter in 
        azuredeploy.json and azuredeploy.parameters.json 
        files and change it if found.

    .PARAMETER  ChangeUsrNameParameterValue
        Optional parameter. If used will 
        search for User Name parameter in 
        azuredeploy.json and azuredeploy.parameters.json 
        files and change it if found.

    .PARAMETER  ChangeAppNameParameterValue
        Optional parameter. If used will 
        search for App Name parameter in 
        azuredeploy.json and azuredeploy.parameters.json 
        files and change it if found.

    .EXAMPLE
        Test-ARMTemplateInParallel -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ChangeLocationParameterValue -ChangeStorageAccountNameParameterValue -ChangeStorageAccountNamePrefixParameterValue -ChangeDNSLabelParameterValue -ChangePasswordParameterValue -ChangeSSHKeyDataParameterValue -ChangeVMNameParameterValue -ChangeUsrNameParameterValue -ChangeAppNameParameterValue
        Description
        -----------
        Login by Subscription ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds the ARM templates from GitHub Master repository
        Changes Location parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes Storage Account Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes Storage Account Name Prefix parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes DNS Label parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes Password parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes SSH Key Data parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes VM Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes User Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes App Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Deploys all ARM Templates in the repository
        3 ARM Templates are tested at the same time
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplateInParallel -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ChangeLocationParameterValue -ChangeStorageAccountNameParameterValue -ChangeStorageAccountNamePrefixParameterValue -ChangeDNSLabelParameterValue -ChangePasswordParameterValue -ChangeSSHKeyDataParameterValue -ChangeVMNameParameterValue -ChangeUsrNameParameterValue -ChangeAppNameParameterValue
        Description
        -----------
        Login by Subscription ID.
        Changes Location parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes Storage Account Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes Storage Account Name Prefix parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes DNS Label parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes Password parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes SSH Key Data parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes VM Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes User Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes App Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Deploys all ARM Templates located in 'D:\ARMTEST\Downloaded'
        3 ARM Templates are tested at the same time
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplateInParallel -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ChangeLocationParameterValue -ChangeStorageAccountNameParameterValue -ChangeStorageAccountNamePrefixParameterValue -ChangeDNSLabelParameterValue -ChangePasswordParameterValue -ChangeSSHKeyDataParameterValue -ChangeVMNameParameterValue -ChangeUsrNameParameterValue -ChangeAppNameParameterValue -InformationAction Continue
        Description
        -----------
        Login by Subscription ID.
        Changes Location parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes Storage Account Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes Storage Account Name Prefix parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes DNS Label parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes Password parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes SSH Key Data parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes VM Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes User Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes App Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Deploys all ARM Templates located in 'D:\ARMTEST\Downloaded'
        3 ARM Templates are tested at the same time
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Show detailed information
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
   
    .EXAMPLE
        Test-ARMTemplateInParallel -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -ChangeLocationParameterValue
        Description
        -----------
        Login by Tenant ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds ARM template '101-application-gateway-create' from GitHub Master repository
        Deploys ARM Template '101-application-gateway-create' to 'North Europe' region
        3 ARM Templates are tested at the same time
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplateInParallel -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ChangeLocationParameterValue -ParallelTests 5
        Description
        -----------
        Login by Subscription ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds the ARM templates from GitHub Master repository
        Deploys all ARM Templates in the repository to 'North Europe' region
        5 ARM Templates are tested at the same time
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Shows detailed output information
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'
    
    .OUTPUTS
        System.Management.Automation.PSCustomObject.
        Returns summary of ARM Template Test Deployment.
        Number of Failed and succeeded deployments.

#>
[CmdletBinding(DefaultParameterSetName='LoginBySubscriptionIDAndGitHubURL')]
[OutputType([pscustomobject])]
param (
        [Parameter(ParameterSetName='LoginBySubscriptionIDAndLocalPath',Position=0,Mandatory=$true)]
        [Parameter(ParameterSetName='LoginBySubscriptionIDAndGitHubURL',Position=0,Mandatory=$true)]
        [ValidateScript({
            try {
                [System.Guid]::Parse($_) | Out-Null
                $true
            } catch {
                $false
            }
        })]
        [string]
        $AzureSubscriptionID,

        [Parameter(ParameterSetName='LoginByTenantIDAndLocalPath',Position=0,Mandatory=$true)]
        [Parameter(ParameterSetName='LoginByTenantIDAndGitHubURL',Position=0,Mandatory=$true)]
        [ValidateScript({
            try {
                [System.Guid]::Parse($_) | Out-Null
                $true
            } catch {
                $false
            }
        })]
        [string]
        $AzureTenantID,

        [Parameter(Position=1,Mandatory=$true)]
        [PSCredential]
        $AzureCredentials,

        [Parameter(Position=2,Mandatory=$true)]
        [ValidateSet('Central US', 'East US', 'East US 2', 'US Gov Iowa', 'US Gov Virginia', 'North Central US', 'South Central US', 'West US', 'North Europe', 'West Europe', 'East Asia', 'Southeast Asia', 'Japan East', 'Japan West', 'Brazil South', 'Australia East', 'Australia Southeast', 'Central India', 'South India', 'West India', 'China East', 'China North', 'Canada Central', 'Canada East', 'Germany Central', 'Germany Northeast')]
        [string]$AzureRegion,

        [Parameter(ParameterSetName='LoginBySubscriptionIDAndGitHubURL',Position=3,Mandatory=$true)]
        [Parameter(ParameterSetName='LoginByTenantIDAndGitHubURL',Position=3,Mandatory=$true)]
        [ValidateScript({
            If ($_ -match '.github\.com.' -or [string]::IsNullOrEmpty($_)) 
            {
                $True
            }
            else 
            {
                Throw "$_ is not valid Github.com URL."
            }
        })]
        [string]
        $GitHubRepositoryURL,

        [Parameter(ParameterSetName='LoginBySubscriptionIDAndLocalPath',Position=3,Mandatory=$true)]
        [Parameter(ParameterSetName='LoginByTenantIDAndLocalPath',Position=3,Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Container})]
        [string]
        $ARMTemplatesPath,

        [Parameter(Position=4,Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Container})] 
        [string]
        $OutputPath,

        [Parameter(Position=5,Mandatory=$false)]
        [int]
        $ParallelTests=3,

        [Parameter(Position=6,Mandatory=$false)]
        [string[]]
        $ARMTemplateName,

        [Parameter(Position=7,Mandatory=$false)]
        [switch]
        $ChangeLocationParameterValue,

        [Parameter(Position=8,Mandatory)]
        [switch]
        $ChangeStorageAccountNameParameterValue,

        [Parameter(Position=9,Mandatory=$false)]
        [switch]
        $ChangeStorageAccountNamePrefixParameterValue,

        [Parameter(Position=10,Mandatory=$false)]
        [switch]
        $ChangeDNSLabelParameterValue,

        [Parameter(Position=11,Mandatory=$false)]
        [switch]
        $ChangePasswordParameterValue,

        [Parameter(Position=12,Mandatory=$false)]
        [switch]
        $ChangeSSHKeyDataParameterValue,

        [Parameter(Position=13,Mandatory=$false)]
        [switch]
        $ChangeVMNameParameterValue,

        [Parameter(Position=14,Mandatory=$false)]
        [switch]
        $ChangeUsrNameParameterValue,

        [Parameter(Position=15,Mandatory=$false)]
        [switch]
        $ChangeAppNameParameterValue
        )
    
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'

    #region Login
    If ([string]::IsNullOrEmpty($AzureTenantID) -eq $false)
    {
        Add-ARMTemplateLogin `
            -AzureTenantID $AzureTenantID `
            -AzureCredentials $AzureCredentials `
            -ErrorAction Stop 
    }
    Else
    {
        Add-ARMTemplateLogin `
            -AzureSubscriptionID $AzureSubscriptionID `
            -AzureCredentials $AzureCredentials `
            -ErrorAction Stop 
    }
    #endregion

    #region If there is no GitHub Repository do not perform download
    If ([string]::IsNullOrEmpty($GitHubRepositoryURL) -eq $false)
    {
        # Download GitHub master repository
        $OutputArchiveFile = Get-GitHubRepositoryMasterArchive `
                                -GitHubRepositoryURL $GitHubRepositoryURL  `
                                -OutputPath $OutputPath `
                                -ErrorAction Stop
    }
    #endregion
    
    # Different parameter options
    $GitHubArchiveParms = @{}

    #region If one parameter $ARMTemplateName is specified
    If ($null -ne $ARMTemplateName)
    {
        $GitHubArchiveParms = $GitHubArchiveParms + @{'ARMTemplateName' = $ARMTemplateName}
    }
    #endregion
    
    #region If there is no GitHub Repository do not perform extraction
    If ([string]::IsNullOrEmpty($GitHubRepositoryURL) -eq $false)
    {
        # Expand ARM Template or array of ARM Templates from GitHub master repository
        $GitHubArchiveParms = $GitHubArchiveParms + @{'OutputPath' = $OutputPath}
        $GitHubArchiveParms = $GitHubArchiveParms + @{'GitHubMasterArchivePath' = $OutputArchiveFile}

        $ExtractLocation = Expand-GitHubMasterArchive `
                                -ErrorAction Stop `
                                @GitHubArchiveParms
    }
    Else
    {
        $ExtractLocation = $ARMTemplatesPath
    }
    #endregion

    #region If $ARMTemplateName parameter is not specified
    If ($null -eq $ARMTemplateName)
    {
        # Get array of names of the templates by using
        # the folder structure
        $newARMTemplateName = Get-ChildItem `
                                -Path $ExtractLocation `
                                -Directory `
                                -ErrorAction Stop | `
                                Select-Object `
                                    -ExpandProperty Name `
                                    -ErrorAction Stop
    }
    Else
    {
        $newARMTemplateName = $ARMTemplateName 
    } 
    #endregion
    
    # Null some counters
    $ARMTSucceeded = 0
    $ARMTFailed = 0
    $ARMTInvalid = 0
    $ARMTBadError = 0

    # Iterate trough every ARM template name
    foreach -parallel -throttlelimit $ParallelTests ($ARMTemplateFolderName in $newARMTemplateName)
    {
        #region Deploy ARM Template
        
        $ARMTemplateDeploymentParams = @{}
        If ([string]::IsNullOrEmpty($AzureTenantID) -eq $false)
        {
            $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'AzureTenantID' = $AzureTenantID}
        }
        Else
        {
            $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'AzureSubscriptionID' = $AzureSubscriptionID}
        }
        
        If ($ChangeLocationParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'ChangeLocationParameterValue' = $true}
        }
        
        If ($ChangeStorageAccountNameParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'ChangeStorageAccountNameParameterValue' = $true}
        }

        If ($ChangeStorageAccountNamePrefixParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'ChangeStorageAccountNamePrefixParameterValue' = $true}
        }

        If ($ChangeDNSLabelParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'ChangeDNSLabelParameterValue' = $true}
        }

        If ($ChangePasswordParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'ChangePasswordParameterValue' = $true}
        }

        If ($ChangeSSHKeyDataParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'ChangeSSHKeyDataParameterValue' = $true}
        }

        If ($ChangeVMNameParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'ChangeVMNameParameterValue' = $true}
        }

        If ($ChangeUsrNameParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'ChangeUsrNameParameterValue' = $true}
        }

        If ($ChangeAppNameParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'ChangeAppNameParameterValue' = $true}
        }

        $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'ARMTemplateName' = $ARMTemplateFolderName}
        $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'AzureRegion' = $AzureRegion}
        $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'ARMTemplatesPath' = $ExtractLocation}
        $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'OutputPath' = $OutputPath}
        $ARMTemplateDeploymentParams = $ARMTemplateDeploymentParams + @{'AzureCredentials' = $AzureCredentials}

        Try
        {
            $ARMTemplateDeploymentResults = New-ARMTemplateDeployment `
                                            -ErrorAction Stop `
                                            @ARMTemplateDeploymentParams
        }
        Catch
        {
            $ARMTemplateDeploymentResults = `
            [pscustomobject]@{'Succeeded' = 0;
                              'Failed'    = 0;
                              'Invalid'   = 0;
                              'BadError'  = 1}
            
            $WarningMessage = 'Template ' + $ARMTemplateFolderName + ' failed with BadError.'
            Write-Warning -Message $WarningMessage 
            Write-Warning -Message $_
        }
        
        # Increment
        $WORKFLOW:ARMTSucceeded += $ARMTemplateDeploymentResults.Succeeded
        $WORKFLOW:ARMTFailed    += $ARMTemplateDeploymentResults.Failed
        $WORKFLOW:ARMTInvalid   += $ARMTemplateDeploymentResults.Invalid
        $WORKFLOW:ARMTBadError  += $ARMTemplateDeploymentResults.BadError
        #endregion

        #region Move ARM Template

        # Move template folder to Successful
        $ARMTemplateStatus = $null
        If ($ARMTemplateDeploymentResults.Succeeded -eq 1)
        {
            $ARMTemplateStatus = 'Success'
        }
        Elseif ($ARMTemplateDeploymentResults.BadError -eq 1)
        {
            $ARMTemplateStatus = 'BadError'
        }
        Elseif ($ARMTemplateDeploymentResults.Failed -eq 1)
        {
            $ARMTemplateStatus = 'Error'
        }
        ElseIf ($ARMTemplateDeploymentResults.Invalid -eq 1)
        {
            $ARMTemplateStatus = 'Invalid'
        }
        
        $ARMTemplateLoc = $ExtractLocation.TrimEnd('\') + '\' + $ARMTemplateFolderName
        Move-ARMTemplateFolder `
            -ARMTemplatePath $ARMTemplateLoc `
            -OutputPath $OutputPath `
            -ARMTemplateStatus $ARMTemplateStatus `
            -ErrorAction Stop 
        #endregion

        #region Remove Azure Resource Group
        If ($ARMTemplateDeploymentResults.Invalid -eq 0)
        {
            $RemoveRGParams = @{}
            
            If ([string]::IsNullOrEmpty($AzureTenantID) -eq $false)
            {
                $RemoveRGParams = $RemoveRGParams + @{'AzureTenantID' = $AzureTenantID}
            }
            Else
            {
                $RemoveRGParams = $RemoveRGParams + @{'AzureSubscriptionID' = $AzureSubscriptionID}
            }
            
            $RemoveRGParams = $RemoveRGParams + @{'ARMTemplateName' = $ARMTemplateFolderName}
            $RemoveRGParams = $RemoveRGParams + @{'AzureCredentials' = $AzureCredentials}

            Remove-ARMTemplateDeployment `
                -ErrorAction Stop `
                @RemoveRGParams
       }
       #endregion
    }

    #region Merge Error logs
    $ARMErrorLogMergePath = Merge-ARMTemplateLog `
                                -OutputPath $OutputPath `
                                -LogType Error `
                                -ErrorAction Stop
    #endregion

    #region Merge Successful logs
    $ARMSuccessLogMergePath = Merge-ARMTemplateLog `
                                -OutputPath $OutputPath `
                                -LogType Success `
                                -ErrorAction Stop
    #endregion

    #region Generate error report
    $reportOuput = Export-ARMTemplateLogToCSV `
                    -FullLogPath $ARMErrorLogMergePath.LogPath `
                    -OutputPath $OutputPath `
                    -LogType Error `
                    -ErrorAction Stop
    #endregion

    #region Output results
    $OutputSummary = `
              [pscustomobject]@{'Successful ARM templates' = $ARMTSucceeded;
                                'Failed ARM templates'     = $ARMTFailed;
                                'Invalid ARM templates'    = $ARMTInvalid;
                                'BadError ARM Templates'   = $ARMTBadError;
                                'Summarized Success log'   = $ARMSuccessLogMergePath.LogPath;
                                'Summarized Error log'     = $ARMErrorLogMergePath.LogPath;
                                'Error Report'             = $reportOuput.'Report Path'}
    
    #endregion

    return $OutputSummary

}