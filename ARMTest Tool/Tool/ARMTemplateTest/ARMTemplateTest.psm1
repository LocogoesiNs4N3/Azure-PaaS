﻿Function Add-ARMTemplateLogin {
<#

    .SYNOPSIS
        Logins to Azure RM.

    .DESCRIPTION
        Logins to Azure RM.

    .PARAMETER  AzureSubscriptionID
        Mandatory parameter. Valid GUID for Azure 
        Subscribtion ID.

    .PARAMETER  AzureTenantID
        Mandatory parameter. Valid GUID for Azure
        Tenant ID.

    .PARAMETER  AzureCredentials
        Mandatory parameter. Valid credentials
        Azure credentials from Azure AD.

    .EXAMPLE
        Add-ARMTemplateLogin -AzureSubscriptionID $SubID -AzureCredentials $cred
        Description
        -----------
        Login to Azure with Subscription ID

        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential

    .EXAMPLE
        Add-ARMTemplateLogin -AzureTenantID $TenID -AzureCredentials $cred
        Description
        -----------
        Login to Azure with Tenant ID

        Example Variables
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential

    .EXAMPLE
        Add-ARMTemplateLogin -AzureSubscriptionID $SubID -AzureCredentials $cred -InformationAction Continue
        Description
        -----------
        Login to Azure with Subscription ID
        Shows detailed output information

        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        
    .EXAMPLE
        Add-ARMTemplateLogin -AzureTenantID $TenID -AzureCredentials $cred -InformationAction Continue
        Description
        -----------
        Login to Azure with Tenant ID
        Shows detailed output information

        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential

    .OUTPUTS
        No Output.

#>
[CmdletBinding(DefaultParameterSetName='LoginBySubscriptionID')]
param (
        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=0,Mandatory=$true)]
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

        [Parameter(ParameterSetName='LoginByTenantID',Position=0,Mandatory=$true)]
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

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=1,Mandatory=$true)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=1,Mandatory=$true)]
        [PSCredential]
        $AzureCredentials
        )
    
    #region Initial Setup
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'
    #endregion

    #region Login
    Try
    {
        #region TenantID login
        If ([string]::IsNullOrEmpty($AzureTenantID) -eq $false)
        {
            
            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Logging to Azure with TenantID: ' + $AzureTenantID
            Write-Verbose `
                 -Message $VerboseMessage 


            # Check if you are logged in already
            Try
            {
                Get-AzureRmSubscription `
                    -TenantId $AzureTenantID `
                    -ErrorAction Stop `
                    -WarningAction SilentlyContinue | `
                        Out-Null
                
                Select-AzureRmSubscription `
                    -TenantId $AzureTenantID `
                    -ErrorAction Stop `
                    -WarningAction SilentlyContinue  | `
                        Out-Null
            }
            Catch
            {
                Login-AzureRmAccount `
                    -TenantId $AzureTenantID `
                    -Credential $AzureCredentials `
                    -ErrorAction Stop `
                    -WarningAction SilentlyContinue | Out-Null

                #region Information
                $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Logged to Azure.'
                Write-Information `
                    -MessageData $InformationMessage
                #endregion
            }
            
            
            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Logged to Azure with TenantID: ' + $AzureTenantID
            Write-Verbose `
                 -Message $VerboseMessage 

        }
        #endregion
        
        #region SubscriptionID login
        Else
        {

            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Logging to Azure with SubscriptionID: ' + $AzureSubscriptionID
            Write-Verbose `
                 -Message $VerboseMessage 

            # Check if you are logged in already
            Try
            {
                Get-AzureRmSubscription `
                    -SubscriptionId $AzureSubscriptionID `
                    -ErrorAction Stop `
                    -WarningAction SilentlyContinue | `
                        Out-Null
                
                Select-AzureRmSubscription `
                    -SubscriptionId $AzureSubscriptionID `
                    -ErrorAction Stop `
                    -WarningAction SilentlyContinue  | `
                        Out-Null
            }
            Catch
            {
                Login-AzureRmAccount `
                    -SubscriptionId $AzureSubscriptionID `
                    -Credential $AzureCredentials `
                    -ErrorAction Stop | Out-Null

                #region Information
                $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Logged to Azure.'
                Write-Information `
                    -MessageData $InformationMessage
                #endregion
            }


            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Logged to Azure with SubscriptionID: ' + $AzureSubscriptionID
            Write-Verbose `
                 -Message $VerboseMessage 

        }
        #endregion
        
    }
    Catch
    {
        $ErrorMessage = 'Failed to login to Azure.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    #endregion

}
Function Remove-ARMTemplateDeployment {
<#

    .SYNOPSIS
        Removes Azure Resource Group and all resources in it.

    .DESCRIPTION
        Removes Azure Resource Group and all resources in it.

    .PARAMETER  ARMTemplateName
        Mandatory parameter. ARM Template Name or array of
        ARM Template Names
        Example 101-application-gateway-create, 101-application-gateway-public-ip

    .PARAMETER  AzureSubscriptionID
        Mandatory parameter. Valid GUID for Azure 
        Subscribtion ID.

    .PARAMETER  AzureTenantID
        Mandatory parameter. Valid GUID for Azure
        Tenant ID.

    .PARAMETER  AzureCredentials
        Mandatory parameter. Valid credentials
        Azure credentials from Azure AD.
    
    .EXAMPLE
        Remove-ARMTemplateDeployment -ARMTemplateName '101-application-gateway-create' -AzureSubscriptionID $SubID -AzureCredentials $cred
        Description
        -----------
        Remove single deployment by logging with Subscription ID

        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential

    .EXAMPLE
        Remove-ARMTemplateDeployment -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -AzureSubscriptionID $SubID -AzureCredentials $cred
        Description
        -----------
        Remove multuple deplouments by logging with Subscription ID
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential

    .EXAMPLE
        Remove-ARMTemplateDeployment -ARMTemplateName '101-application-gateway-public-ip' -AzureTenantID $TenID -AzureCredentials $cred
        Description
        -----------
        Remove single deployment by logging with Tenant ID

        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential

    .EXAMPLE
        Remove-ARMTemplateDeployment -ARMTemplateName '101-application-gateway-create' -AzureSubscriptionID $SubID -AzureCredentials $cred -InformationAction Continue
        Description
        -----------
        Remove single deployment by logging with Subscription ID
        Shows detailed output information
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential

    .EXAMPLE
        Remove-ARMTemplateDeployment -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -AzureSubscriptionID $SubID -AzureCredentials $cred -InformationAction Continue
        Description
        -----------
        Remove multuple deplouments by logging with Subscription ID
        Shows detailed output information

        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential

    .EXAMPLE
        Remove-ARMTemplateDeployment -ARMTemplateName '101-application-gateway-public-ip' -AzureTenantID $TenID -AzureCredentials $cred -InformationAction Continue
        Description
        -----------
        Remove single deployment by logging with Tenant ID
        Shows detailed output information

        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential

    .OUTPUTS
        No Output.

#>
[CmdletBinding(DefaultParameterSetName='LoginBySubscriptionID')]
param (
        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=0,Mandatory=$true)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=0,Mandatory=$true)]
        [string[]]
        $ARMTemplateName,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=1,Mandatory=$true)]
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

        [Parameter(ParameterSetName='LoginByTenantID',Position=1,Mandatory=$true)]
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

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=2,Mandatory=$true)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=2,Mandatory=$true)]
        [PSCredential]
        $AzureCredentials
        )
    
    #region Initial Setup      
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'
    #endregion
    
    #region ARG removal
    # Iterate trough every ARM template name
    foreach ($ARMTemplateFolderName in $ARMTemplateName)
    {
        Try
        {
            #region Login if needed
            If ([string]::IsNullOrEmpty($AzureTenantID) -eq $false)
            {
                Add-ARMTemplateLogin `
                    -AzureTenantID $AzureTenantID `
                    -AzureCredentials $AzureCredentials `
                    -ErrorAction Stop | Out-Null
            }
            Else
            {
                Add-ARMTemplateLogin `
                    -AzureSubscriptionID $AzureSubscriptionID  `
                    -AzureCredentials $AzureCredentials `
                    -ErrorAction Stop | Out-Null
            }
            #endregion

            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting removal of Azure Resource Group: ' + $ARMTemplateFolderName
            Write-Verbose `
                 -Message $VerboseMessage 

            #region Information
            $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Removing Azure Resource Group: ' + $ARMTemplateFolderName
            Write-Information `
               -MessageData $InformationMessage
            #endregion
            
            Remove-AzureRmResourceGroup `
                -Name $ARMTemplateFolderName `
                -Force `
                -ErrorAction Stop
            
            #region Information
            $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Removed Azure Resource Group: ' + $ARMTemplateFolderName
            Write-Information `
               -MessageData $InformationMessage
            #endregion

            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Removed Azure Resource Group: ' + $ARMTemplateFolderName
            Write-Verbose `
                 -Message $VerboseMessage 
        }
        Catch
        {
            $ErrorMessage = 'Failed to remove Azure Resource Group.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error `
                -Message $ErrorMessage `
                -ErrorAction Stop
        }
    }
    #endregion
}
Function Write-ARMTemplateLog {
<#

    .SYNOPSIS
        Writes Failure or Sucess information from ARM
        template deployment in json log.

    .DESCRIPTION
        Writes Failure or Sucess information from ARM
        template deployment in json log.

    .PARAMETER  DeploymentLog
        Mandatory parameter. Object from Get-AzureRmResourceGroupDeployment
        cmdlet.

    .PARAMETER  ResourcesLogs
        Mandatory parameter. Array of objects from 
        Get-AzureRmResourceGroupDeploymentOperation cmdlet.

    .PARAMETER  LogType
        Mandatory parameter. Type of log to write.
        Possible values are Error or Success.

    .PARAMETER  ARMTemplatePath
        Mandatory parameter. Path of the ARM Template.
        Example D:\ARMTEST\101-application-gateway-public-ip

    .EXAMPLE
        Write-ARMTemplateLog -DeploymentLog $DeploymetnStateObj -ResourcesLogs $SucceededOperations -LogType 'Success' -ARMTemplatePath 'D:\ARMTEST\101-application-gateway-public-ip'
        Description
        -----------
        Write Success log

        Example Variables
        -----------------
        $DeploymetnStateObj = Get-AzureRmResourceGroupDeployment -ResourceGroupName '101-application-gateway-public-ip' -Name '101-application-gateway-public-ip-200116-084611'
        $SucceededOperations = Get-AzureRmResourceGroupDeploymentOperation -ResourceGroupName '101-application-gateway-public-ip' -DeploymentName '101-application-gateway-public-ip-200116-084611'

    .EXAMPLE
        Write-ARMTemplateLog -DeploymentLog $DeploymetnStateObj -ResourcesLogs $FailedOperations -LogType 'Error' -ARMTemplatePath 'D:\ARMTEST\101-application-gateway-public-ip'
        Description
        -----------
        Write Error Log

        Example Variables
        -----------------
        $DeploymetnStateObj = Get-AzureRmResourceGroupDeployment -ResourceGroupName '101-application-gateway-public-ip' -Name '101-application-gateway-public-ip-200116-084611'
        $FailedOperations = Get-AzureRmResourceGroupDeploymentOperation -ResourceGroupName '101-application-gateway-public-ip' -DeploymentName '101-application-gateway-public-ip-200116-084611'

    .EXAMPLE
        Write-ARMTemplateLog -DeploymentLog $PowerShellErrorObj -ResourcesLogs $AzureAuditLogs -LogType 'PowerShellError' -ARMTemplatePath 'D:\ARMTEST\101-application-gateway-public-ip'
        Description
        -----------
        Write Error log of time PowerShellError
        
        Example Variables
        -----------------
        New-AzureRmResourceGroupDeployment -Name '101-application-gateway-public-ip-200116-084611' -ResourceGroupName '101-application-gateway-public-ip' -TemplateFile $azuredeployLocation -TemplateParameterFile $azuredeployParametersLocation -Force -ErrorAction SilentlyContinue -ErrorVariable DeploymentError
        $AzureAuditLogs = Get-AzureRmLog -ResourceGroup '101-application-gateway-public-ip' -StartTime (Get-Date).AddHours(-1)  -Status Failed -DetailedOutput 
        $PowerShellErrorObj = [pscustomobject]@{'Exception' = $DeploymentError.Exception.Message}

    .OUTPUTS
        System.Management.Automation.PSCustomObject.
        Returns path to the written log.

#>
[CmdletBinding(DefaultParameterSetName='DefaultParameterSet')]
[OutputType([pscustomobject])]
param (
        [Parameter(ParameterSetName='DefaultParameterSet',Position=0,Mandatory=$true)]
        [object]
        $DeploymentLog,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=1,Mandatory=$true)]
        [object[]]
        $ResourcesLogs,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=2,Mandatory=$true)]
        [ValidateSet('Error','Success','PowerShellError')]
        [string]
        $LogType,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=3,Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Container})] 
        [string]
        $ARMTemplatePath
        )

    #region Initial Setup
    
    # Set Error Preference	
    $ErrorActionPreference = 'Stop'
    
    # Needed for converting a time format in the logs
    $TimeFormat = New-Object System.Globalization.CultureInfo('en-US')
    
    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $LogType is: ' + $LogType
    Write-Verbose `
          -Message $VerboseMessage 
    
    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $TimeFormat is: ' + $TimeFormat
    Write-Verbose `
          -Message $VerboseMessage 
    
    #endregion
    
    #region Success Log Type
     If ($LogType -eq 'Success')
     {
         Try
         {
             # Set Success log name
             $SuccessLogName = 'SuccessLog.json'
         
             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $SuccessLogName is: ' + $SuccessLogName
             Write-Verbose `
                   -Message $VerboseMessage 
     
             $SuccessfulResources  = @()
             # Go trough every instance of Resource Logs
             foreach ($ResourcesLog in $ResourcesLogs)
             {
         
                # Go trough every instance of Target Resource
                foreach ($SuccessfulResource in $ResourcesLog.Properties.TargetResource)
                {
                    # Create PS custom object for additional information
                    $SuccessfulResourcesAddInf = `
                        [pscustomobject]@{'Timestamp'    = $ResourcesLog.Properties.Timestamp;
                                          'Operation ID' = $ResourcesLog.OperationId;
                                          'Duration'     = $ResourcesLog.Properties.Duration;
                                          'Tracking ID'  = $ResourcesLog.Properties.TrackingId}
                
                    # Create PS custom object for main information
                    # Add instance for each Target resource
                    $SuccessfulResources += `
                        [pscustomobject]@{'Operation ID'           = $ResourcesLog.id;
                                          'Provisioning State'     = $ResourcesLog.Properties.ProvisioningState;
                                          'Status Code'            = $ResourcesLog.Properties.StatusCode;
                                          'Target Resource Type'   = $SuccessfulResource.ResourceType;
                                          'Target Resource Name'   = $SuccessfulResource.ResourceName;
                                          'Target Resource ID'     = $SuccessfulResource.id;
                                          'Additional Information' = $SuccessfulResourcesAddInf }
                }
             
     
             }
         
             # Create PS custom object for additional deployment information
             $DeploymentLogAddProp  = `
                 [pscustomobject]@{ 'Correlation Id'        = $DeploymentLog.CorrelationId;
                                    'Timestamp'             = $DeploymentLog.Timestamp.ToString('o',$TimeFormat);
                                    'Deployment Mode'       = $DeploymentLog.Mode.ToString()}
         
             # Create PS custom object for main deployment information
             $DeploymentLogMainProp = `
                 [pscustomobject]@{'Deployment Name'        = $DeploymentLog.DeploymentName;
                                   'Resource Group Name'    = $DeploymentLog.ResourceGroupName;
                                   'Provisioning State'     = $DeploymentLog.ProvisioningState;
                                   'Successful Resources'   = $SuccessfulResources;
                                   'Input Parameters'       = $DeploymentLog.Parameters;
                                   'Template Outputs'       = $DeploymentLog.Outputs;
                                   'Additional Information' = $DeploymentLogAddProp}
     
             # Construct successful log path
             $SuccessLogFullPath = $ARMTemplatePath.TrimEnd('\') + '\' + $SuccessLogName
     
             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $SuccessLogFullPath is: ' + $SuccessLogFullPath
             Write-Verbose `
                   -Message $VerboseMessage 
     
             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting json convertion and writing to file: ' + $SuccessLogFullPath
             Write-Verbose `
                   -Message $VerboseMessage 
     
             # Convert log to JSON and write it into file
             $DeploymentLogMainProp | `
                 ConvertTo-Json `
                     -Depth 15 `
                     -ErrorAction Stop | `
                 Out-File `
                     -FilePath $SuccessLogFullPath `
                     -Encoding unicode `
                     -Force `
                     -ErrorAction Stop
         
             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Converted success log to json and wrote in file: ' + $SuccessLogFullPath
             Write-Verbose `
                   -Message $VerboseMessage 
     
             $OutputResult = `
                 [pscustomobject]@{'LogPath' = $SuccessLogFullPath}
         }
         Catch
         {
             $ErrorMessage = 'Failed to format and save Success log.'
             $ErrorMessage += " `n"
             $ErrorMessage += 'Error: '
             $ErrorMessage += $_
             Write-Error `
                 -Message $ErrorMessage `
                 -ErrorAction Stop
         }
         
     }
     #endregion
     #region Error Log Type
     Elseif ($LogType -eq 'Error')
     {
         Try
         {
             # Set Error log name
             $ErrorLogName = 'ErrorLog.json'
         

             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $ErrorLogName is: ' + $ErrorLogName
             Write-Verbose `
                   -Message $VerboseMessage 

     
             $FailedResources      = @()
             $SuccessfulResources  = @()
     
             # Go trough every instance of Resource Logs
             foreach ($ResourcesLog in $ResourcesLogs)
             {
                 # Get Failed resources
                 If ($ResourcesLog.Properties.ProvisioningState -eq 'Failed')
                 {
                     # Go trough every instance of Target Resource
                     foreach ($FailedResource in $ResourcesLog.Properties.TargetResource)
                     {
                         # Create PS custom object for additional information
                         $FailedResourcesAddInf = `
                             [pscustomobject]@{'Timestamp'    = $ResourcesLog.Properties.Timestamp; #2016-01-11T11:58:13.2837063Z
                                               'Operation ID' = $ResourcesLog.OperationId; # 24A2DD1F92DB6DB0
                                               'Duration'     = $ResourcesLog.Properties.Duration; #PT1.2905805S
                                               'Tracking ID'  = $ResourcesLog.Properties.TrackingId #f02f8766-8f18-4897-87b5-62e3f202e735
                                               }
                         
                         # Some Resource Providers are not consistant on Audit log implementation
                         If ($ResourcesLog.Properties.StatusMessage.Error.Code)
                         {
                            $ResourceLogErrorCode = $ResourcesLog.Properties.StatusMessage.Error.Code
                         }
                         ElseIf ($ResourcesLog.Properties.StatusMessage.code)
                         {
                            $ResourceLogErrorCode = $ResourcesLog.Properties.StatusMessage.code
                         }
                         
                         If ($ResourcesLog.Properties.StatusMessage.Error.Message)
                         {
                            $ResourceLogErrorMessage = $ResourcesLog.Properties.StatusMessage.Error.Message
                         }
                         ElseIf ($ResourcesLog.Properties.StatusMessage.message)
                         {
                            $ResourceLogErrorMessage = $ResourcesLog.Properties.StatusMessage.message
                         }
                         
                         # Create PS custom object for main information
                         # Add instance for each Target resource
                         $FailedResources += `
                             [pscustomobject]@{'Operation ID'           = $ResourcesLog.id; #/subscriptions/3c1d68a5-4064-4522-94e4-e0378165922e/resourceGroups/101-automation-runbook-getvms/providers/Microsoft.Resources/deployments/stan/operations/24A2DD1F92DB6DB0
                                               'Provisioning State'     = $ResourcesLog.Properties.ProvisioningState; #Failed
                                               'Status Code'            = $ResourcesLog.Properties.StatusCode; #Conflict
                                               'Error Code'             = $ResourceLogErrorCode #ResourceDeploymentFailure
                                               'Error Message'          = $ResourceLogErrorMessage; #The resource operation completed with terminal provisioning state 'Failed'.
                                               'Target Resource Type'   = $FailedResource.ResourceType; #Microsoft.Automation/automationAccounts/jobs
                                               'Target Resource Name'   = $FailedResource.ResourceName; #MyAutomationAccount/e6abf1fd-6311-4442-ac1a-22aae3cacdae
                                               'Target Resource ID'     = $FailedResource.id; # /subscriptions/3c1d68a5-4064-4522-94e4-e0378165922e/resourceGroups/101-automation-runbook-getvms/providers/Microsoft.Automation/automationAccounts/MyAutomationAccount/jobs/e6abf1fd-6311-4442-ac1a-22aae3cacdae
                                               'Additional Information' = $FailedResourcesAddInf }
                     }
                 }
                 # Get Succeeded resources
                 Elseif ($ResourcesLog.Properties.ProvisioningState -eq 'Succeeded')
                 {
                     # Go trough every instance of Target Resource
                     foreach ($SuccessfulResource in $ResourcesLog.Properties.TargetResource)
                     {
                         # Create PS custom object for additional information
                         $SuccessfulResourcesAddInf = `
                             [pscustomobject]@{'Timestamp'    = $ResourcesLog.Properties.Timestamp;
                                               'Operation ID' = $ResourcesLog.OperationId;
                                               'Duration'     = $ResourcesLog.Properties.Duration;
                                               'Tracking ID'  = $ResourcesLog.Properties.TrackingId}
                     
                         # Create PS custom object for main information
                         # Add instance for each Target resource
                         $SuccessfulResources += `
                             [pscustomobject]@{'Operation ID'           = $ResourcesLog.id;
                                               'Provisioning State'     = $ResourcesLog.Properties.ProvisioningState;
                                               'Status Code'            = $ResourcesLog.Properties.StatusCode;
                                               'Target Resource Type'   = $SuccessfulResource.ResourceType;
                                               'Target Resource Name'   = $SuccessfulResource.ResourceName;
                                               'Target Resource ID'     = $SuccessfulResource.id;
                                               'Additional Information' = $SuccessfulResourcesAddInf }
                     }
                 }
     
             }
         
             # Create PS custom object for additional deployment information
             $DeploymentLogAddProp  = `
                 [pscustomobject]@{ 'Correlation Id'        = $DeploymentLog.CorrelationId;
                                    'Timestamp'             = $DeploymentLog.Timestamp.ToString('o',$TimeFormat);
                                    'Deployment Mode'       = $DeploymentLog.Mode.ToString()}
         
             # Create PS custom object for main deployment information
             $DeploymentLogMainProp = `
                 [pscustomobject]@{'Deployment Name'        = $DeploymentLog.DeploymentName;
                                   'Resource Group Name'    = $DeploymentLog.ResourceGroupName;
                                   'Provisioning State'     = $DeploymentLog.ProvisioningState;
                                   'Failed Resources'       = $FailedResources ;
                                   'Input Parameters'       = $DeploymentLog.Parameters;
                                   'Template Outputs'       = $DeploymentLog.Outputs;
                                   'Successful Resources'   = $SuccessfulResources;
                                   'Additional Information' = $DeploymentLogAddProp}
         
         
     
             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $DeploymentLogMainProp is: ' + $DeploymentLogMainProp
             Write-Verbose `
                   -Message $VerboseMessage 

     
             $ErrorLogFullPath = $ARMTemplatePath.TrimEnd('\') + '\' + $ErrorLogName
     

             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $ErrorLogFullPath is: ' + $ErrorLogFullPath
             Write-Verbose `
                   -Message $VerboseMessage 

     

             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting json convertion and writing to file: ' + $ErrorLogFullPath
             Write-Verbose `
                   -Message $VerboseMessage 

     
             # Convert log to JSON and write it into file
             $DeploymentLogMainProp | `
                 ConvertTo-Json `
                     -Depth 10 `
                     -ErrorAction Stop | `
                 Out-File `
                     -FilePath $ErrorLogFullPath `
                     -Encoding unicode `
                     -Force `
                     -ErrorAction Stop
         

             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Converted error log to json and wrote in file: ' + $ErrorLogFullPath
             Write-Verbose `
                   -Message $VerboseMessage 

     
             $OutputResult = `
                 [pscustomobject]@{'LogPath' = $ErrorLogFullPath}
         }
         Catch
         {
             $ErrorMessage = 'Failed to format and save Error log.'
             $ErrorMessage += " `n"
             $ErrorMessage += 'Error: '
             $ErrorMessage += $_
             Write-Error `
                 -Message $ErrorMessage `
                 -ErrorAction Stop
         }
         
     }
     #endregion
     #region PowerShellError Log Type
     Elseif ($LogType -eq 'PowerShellError')
     {
         Try
         {
             # Set Error log name
             $ErrorLogName = 'ErrorLog.json'
         

             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $ErrorLogName is: ' + $ErrorLogName
             Write-Verbose `
                   -Message $VerboseMessage 
     
             $FailedResources      = @()
             $SuccessfulResources  = @()
     
             # Go trough every instance of Resource Logs
             foreach ($ResourcesLog in $ResourcesLogs)
             {
                 
                 $DeploymentName = $ResourcesLog.Authorization.Scope.Split('/')[-1]
                 $AzureRGName = $ResourcesLog.ResourceGroupName
                 $ProvisioningState = $ResourcesLog.Status
                 $CorrelationId = $ResourcesLog.CorrelationId
                 $Timestamp = $ResourcesLog.EventTimestamp.ToString('o',$TimeFormat)
                 
                 # For some logs conent is empty   
                 Try
                 {
                    $ErrorDetails = $ResourcesLog.Properties.Content.Get_Item('statusMessage') | ConvertFrom-Json
                    $ErrorDetailsErrorCode = $ErrorDetails.error.code
                    $ErrorDetailsErrorMessage = $ErrorDetails.error.message
                 }
                 Catch
                 {
                    $ErrorDetailsErrorCode = $null
                    $ErrorDetailsErrorMessage = $null
                 }
                 
     
                 
                 # Create PS custom object for additional information
                 $FailedResourcesAddInf = `
                     [pscustomobject]@{'Timestamp'    = $ResourcesLog.EventTimestamp.ToString('o',$TimeFormat);
                                       'Operation ID' = $ResourcesLog.OperationId; 
                                       'Duration'     = $null; 
                                       'Tracking ID'  = $null}
                                       
                 
                 # Create PS custom object for main information
                 # Add instance for each Target resource
                 $FailedResources += `
                     [pscustomobject]@{'Operation ID'           = $ResourcesLog.Authorization.Scope; #/subscriptions/3c1d68a5-4064-4522-94e4-e0378165922e/resourcegroups/101-dtl-create-lab/deployments/101-dtl-create-lab-140116-174950
                                       'Provisioning State'     = $ResourcesLog.Status; #Failed
                                       'Status Code'            = $ResourcesLog.SubStatus; #BadRequest
                                       'Error Code'             = $ErrorDetailsErrorCode; #Custom
                                       'Error Message'          = $ErrorDetailsErrorMessage; #DisallowedLocation: The provided location 'northeurope' is not permitted for subscription. List of permitted regions is...
                                       'Target Resource Type'   = $ResourcesLog.OperationName; #Microsoft.Resources/deployments/write
                                       'Target Resource Name'   = $ResourcesLog.ResourceProviderName;
                                       'Target Resource ID'     = $ResourcesLog.ResourceId;
                                       'Additional Information' = $FailedResourcesAddInf }
             }
             
             # Create PS custom object for additional deployment information
             $DeploymentLogAddProp  = `
                 [pscustomobject]@{ 'Correlation Id'  = $CorrelationId;
                                    'Timestamp'       = $Timestamp;
                                    'Deployment Mode' = 'Incremental'}
             
             # Create PS custom object for main deployment information
             $DeploymentLogMainProp = `
                 [pscustomobject]@{'Deployment Name'        = $DeploymentName;
                                   'Resource Group Name'    = $AzureRGName;
                                   'Provisioning State'     = $ProvisioningState;
                                   'Failed Resources'       = $FailedResources ;
                                   'Input Parameters'       = $null;
                                   'Template Outputs'       = $null;
                                   'Successful Resources'   = $null;
                                   'Additional Information' = $DeploymentLogAddProp}
             
         
     

             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $DeploymentLogMainProp is: ' + $DeploymentLogMainProp
             Write-Verbose `
                   -Message $VerboseMessage 

     
             $ErrorLogFullPath = $ARMTemplatePath.TrimEnd('\') + '\' + $ErrorLogName
     

             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $ErrorLogFullPath is: ' + $ErrorLogFullPath
             Write-Verbose `
                   -Message $VerboseMessage 

     
             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting json convertion and writing to file: ' + $ErrorLogFullPath
             Write-Verbose `
                   -Message $VerboseMessage 

     
             # Convert log to JSON and write it into file
             $DeploymentLogMainProp | `
                 ConvertTo-Json `
                     -Depth 10 `
                     -ErrorAction Stop | `
                 Out-File `
                     -FilePath $ErrorLogFullPath `
                     -Encoding unicode `
                     -Force `
                     -ErrorAction Stop
         

             $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Converted error log to json and wrote in file: ' + $ErrorLogFullPath
             Write-Verbose `
                   -Message $VerboseMessage 

     
             $OutputResult = `
                 [pscustomobject]@{'LogPath' = $ErrorLogFullPath}
         }
         Catch
         {
             $ErrorMessage = 'Failed to format and save Error log.'
             $ErrorMessage += " `n"
             $ErrorMessage += 'Error: '
             $ErrorMessage += $_
             Write-Error `
                 -Message $ErrorMessage `
                 -ErrorAction Stop
         }
         
     }
     #endregion
    
    return $OutputResult
}
Function Move-ARMTemplateFolder {
<#

    .SYNOPSIS
        Moves ARM Template folder to Queued, Successful, 
        BadError or Invalid folder depending on the 
        deployment status.

    .DESCRIPTION
        Moves ARM Template folder to Queued, Successful,
        Invalid or BadError folder depending on the 
        deployment status.

    .PARAMETER  ARMTemplatePath
        Mandatory parameter. Path of the ARM Template.
        Example D:\ARMTEST\Downloaded\101-application-gateway-public-ip

    .PARAMETER  OutputPath
        Mandatory parameter. Location where Output
        for the cmdlets are.
        Example: D:\ARMTEST\

    .PARAMETER  ARMTemplateStatus
        Mandatory parameter. Status of the ARM Template
        deployment. Possible values are Error, Success,
        Invalid and BadError. Success is when template
        was deployed successully. Error is when template
        was deployed but it had error. Invalid is when
        template was not containing azuredeploy.json and
        azuredeploy.parameters.json files in its tempalte
        folder. BadError is when template couldn't be 
        deployed completely. For example if one of the
        json files is incorrect.

    .EXAMPLE
        Move-ARMTemplateFolder -ARMTemplatePath 'D:\ARMTEST\Downloaded\101-application-gateway-public-ip' -OutputPath 'D:\ARMTEST\' -ARMTemplateStatus 'Error'
        Description
        -----------
        Move ARM Template folder to Queued folder

    .EXAMPLE
        Move-ARMTemplateFolder -ARMTemplatePath 'D:\ARMTEST\Downloaded\101-application-gateway-public-ip' -OutputPath 'D:\ARMTEST\' -ARMTemplateStatus 'Success'
        Description
        -----------
        Move ARM Template folder to Successful folder

    .EXAMPLE
        Move-ARMTemplateFolder -ARMTemplatePath 'D:\ARMTEST\Downloaded\101-application-gateway-public-ip' -OutputPath 'D:\ARMTEST\' -ARMTemplateStatus 'Invalid'
        Description
        -----------
        Move ARM Template folder to Invalid folder

    .EXAMPLE
        Move-ARMTemplateFolder -ARMTemplatePath 'D:\ARMTEST\Downloaded\101-application-gateway-public-ip' -OutputPath 'D:\ARMTEST\' -ARMTemplateStatus 'BadError'
        Description
        -----------
        Move ARM Template folder to BadError folder
    
    .EXAMPLE
        Move-ARMTemplateFolder -ARMTemplatePath 'D:\ARMTEST\Downloaded\101-application-gateway-public-ip' -OutputPath 'D:\ARMTEST\' -ARMTemplateStatus 'Error' -InformationAction Continue
        Description
        -----------
        Move ARM Template folder to Queued folder
        Shows detailed output information

    .EXAMPLE
        Move-ARMTemplateFolder -ARMTemplatePath 'D:\ARMTEST\Downloaded\101-application-gateway-public-ip' -OutputPath 'D:\ARMTEST\' -ARMTemplateStatus 'Success' -InformationAction Continue
        Description
        -----------
        Move ARM Template folder to Successful folder
        Shows detailed output information

    .EXAMPLE
        Move-ARMTemplateFolder -ARMTemplatePath 'D:\ARMTEST\Downloaded\101-application-gateway-public-ip' -OutputPath 'D:\ARMTEST\' -ARMTemplateStatus 'Invalid' -InformationAction Continue
        Description
        -----------
        Move ARM Template folder to Invalid folder
        Shows detailed output information

    .EXAMPLE
        Move-ARMTemplateFolder -ARMTemplatePath 'D:\ARMTEST\Downloaded\101-application-gateway-public-ip' -OutputPath 'D:\ARMTEST\' -ARMTemplateStatus 'BadError' -InformationAction Continue
        Description
        -----------
        Move ARM Template folder to BadError folder
        Shows detailed output information
    
    .OUTPUTS
       No Output

#>
[CmdletBinding(DefaultParameterSetName='DefaultParameterSet')]
param (
        [Parameter(ParameterSetName='DefaultParameterSet',Position=0,Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Container})]
        [string]
        $ARMTemplatePath,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=1,Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Container})]
        [string]
        $OutputPath,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=2,Mandatory=$true)]
        [ValidateSet('Error','Success','Invalid','BadError')]
        [string]
        $ARMTemplateStatus
        )
    
    #region Initial Setup
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'

    If ($ARMTemplateStatus -eq 'Error')
    {
        $ResultFolder = 'Queued'
    }
    Elseif ($ARMTemplateStatus -eq 'Success')
    {
        $ResultFolder = 'Successful'
    }
    Elseif ($ARMTemplateStatus -eq 'Invalid')
    {
        $ResultFolder = 'Invalid'
    }
    Elseif ($ARMTemplateStatus -eq 'BadError')
    {
        $ResultFolder = 'BadError'
    }



    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $ARMTemplatePath is: ' + $ARMTemplatePath
    Write-Verbose `
          -Message $VerboseMessage 

    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $OutputPath is: ' + $OutputPath
    Write-Verbose `
          -Message $VerboseMessage 

    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $ARMTemplateStatus is: ' + $ARMTemplateStatus
    Write-Verbose `
          -Message $VerboseMessage 

    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $ResultFolder is: ' + $ResultFolder 
    Write-Verbose `
          -Message $VerboseMessage 


    $FullOutputFolderPath = $OutputPath.TrimEnd('\') + '\' + $ResultFolder


    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $FullOutputFolderPath is: ' + $FullOutputFolderPath
    Write-Verbose `
          -Message $VerboseMessage 

    #endregion

    #region Check Path
    If ((Test-Path -Path $FullOutputFolderPath) -eq $false)
    {
        Try
        {

            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting creation of folder ' + $FullOutputFolderPath
            Write-Verbose `
                  -Message $VerboseMessage 


            New-Item `
                -Path $FullOutputFolderPath `
                -ItemType Directory `
                -Force `
                -ErrorAction Stop | Out-Null


            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Finished creation of folder ' + $FullOutputFolderPath
            Write-Verbose `
                  -Message $VerboseMessage 

        }
        Catch
        {
            $ErrorMessage = 'Failed to create folder: ' + $FullOutputFolderPath
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error `
                -Message $ErrorMessage `
                -ErrorAction Stop
        }
    }
    #endregion

    #region Move folder
    Try
    {

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Sarting moving files and folders from ' + $ARMTemplatePath + ' to ' + $FullOutputFolderPath
        Write-Verbose `
             -Message $VerboseMessage 


        Move-Item `
            -Path $ARMTemplatePath `
            -Destination $FullOutputFolderPath `
            -Force `
            -ErrorAction Stop
        
        #region Information
        $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Moved folder ' + $ARMTemplatePath + ' to ' + $FullOutputFolderPath
        Write-Information `
            -MessageData $InformationMessage
        #endregion


        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Finished moving files and folders from ' + $ARMTemplatePath + ' to ' + $FullOutputFolderPath
        Write-Verbose `
            -Message $VerboseMessage 

    }
    Catch
    {
        $ErrorMessage = 'Failed to move folder from ' + $ARMTemplatePath + ' to ' + $FullOutputFolderPath
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
             -Message $ErrorMessage `
             -ErrorAction Stop
    }
    #endregion
}
Function Set-ARMTemplateParameterFile {
<#

    .SYNOPSIS
        Changes location parameter in ARM Template
        json parameters file.

    .DESCRIPTION
        Changes location parameter in ARM Template
        json parameters file. Finds location parameters
        by matching the name to keywords like location and
        region. If json file cannot be read it will skip 
        everything and output the original file.

    .PARAMETER  ARMTemplateParameterFile
        Location to azuredeploy.parameters.json file.

    .PARAMETER  SetType
        Type of paramater to be searched and replaced 
        if found. Currently only location is valid
        value.

    .PARAMETER  AzureRegion
        Valid Azure region value. This paramater
        is needed if SetType is location.

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateParameterFile $path -SetType 'Location' -AzureRegion 'North Europe'
        Description
        -----------
        Find parameter of type 'Location' in ARM Template paramaters' file and replace the value for
        that parameter with 'North Europe'

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.parameters.json'
        
     .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateParameterFile $path -SetType 'Location' -AzureRegion 'North Europe' -InformationAction Continue
        Description
        -----------
        Find parameter of type 'Location' in ARM Template paramaters' file and replace the value for
        that parameter with 'North Europe'
        Shows detailed output information

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.parameters.json'

    .OUTPUTS
        System.Management.Automation.PSCustomObject.
        Returns object with information if the parameters 
        file has been modified and location to the modified 
        file or the original file.

#>
[CmdletBinding(
    DefaultParameterSetName='DefaultParameterSet',
    SupportsShouldProcess=$true,
    ConfirmImpact='Low'
    )]
[OutputType([pscustomobject])]
param (
        [Parameter(ParameterSetName='DefaultParameterSet',Position=0,Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
        [string]
        $ARMTemplateParameterFile,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=1,Mandatory=$true)]
        [ValidateSet('Location')]
        [string]
        $SetType,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=2,Mandatory=$false)]
        [ValidateSet('Central US', 'East US', 'East US 2', 'US Gov Iowa', 'US Gov Virginia', 'North Central US', 'South Central US', 'West US', 'North Europe', 'West Europe', 'East Asia', 'Southeast Asia', 'Japan East', 'Japan West', 'Brazil South', 'Australia East', 'Australia Southeast', 'Central India', 'South India', 'West India', 'China East', 'China North', 'Canada Central', 'Canada East', 'Germany Central', 'Germany Northeast')]
        [string]$AzureRegion
        )

    #region Initial Setup
    # Set Error Preference	
    $ErrorActionPreference = 'Stop'

    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $SetType is: ' + $SetType
    Write-Verbose `
          -Message $VerboseMessage

    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $ARMTemplateParameterFile is: ' + $ARMTemplateParameterFile
    Write-Verbose `
          -Message $VerboseMessage 

    # Get ARM Template root folder
    $ARMTemplatePath = Split-path `
                        -Path $ARMTemplateParameterFile `
                        -Parent `
                        -ErrorAction Stop
    
    # Get only the name of the file without the extension
    $FileName = (Split-path `
                    -Path $ARMTemplateParameterFile `
                    -Leaf `
                    -ErrorAction Stop).Replace('.json','')

    # Construct new JSON File Path
    $NewARMTemplateParamFilePath = $ARMTemplatePath + '\' + $FileName + '-modified.json'
    
    $ParamFileObjChanged = $false

    # If template parameter cannot be converted it is invalid and just skip it
    Try
    {
    
        # Get Parameter file into object
        $ParamFileObj = Get-Content `
                            -Path $ARMTemplateParameterFile `
                            -Force `
                            -ErrorAction Stop | `
                       ConvertFrom-Json `
                            -ErrorAction Stop

        
        #endregion

        #region SetType Location
        If ($SetType -eq 'Location') 
        {
            Try
            {
                $LocationKeywords = @('location','region')
                $ResourceGroupLocation = $AzureRegion

                # Go trough every keyword
                foreach ($LocationKeyword in $LocationKeywords)
                {
                    $ParameterNames = $ParamFileObj.parameters | `
                                        Get-Member `
                                            -ErrorAction Stop | `
                                        Where-Object MemberType -EQ NoteProperty `
                                            -ErrorAction Stop | `
                                        Select-Object -ExpandProperty Name `
                                            -ErrorAction Stop
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                            Get-Member | `
                                            Where-Object MemberType -EQ NoteProperty | `
                                            Select-Object -ExpandProperty Name
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $ParameterName  is: ' + $ParameterName 
                        Write-Verbose `
                              -Message $VerboseMessage 

                        If ($ParameterName -match $LocationKeyword)
                        {
                            # Check if there are multiple values
                            If ($ParamFileObj.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.($ParameterName).Value)
                                    {
                                        $ParamFileObj.parameters.($ParameterName).Value[$ValueCount] = $ResourceGroupLocation
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    $ParamFileObj.parameters.($ParameterName).Value = $ResourceGroupLocation
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($ParamFileObj.parameters.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.parameters.($ParameterName).Value)
                                    {
                                        $ParamFileObj.parameters.parameters.($ParameterName).Value[$ValueCount] = $ResourceGroupLocation
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    $ParamFileObj.parameters.parameters.($ParameterName).Value = $ResourceGroupLocation
                                    $ParamFileObjChanged = $true
                                }
                            }
                            
                            
                            
                            
                        }
                    }
                }
            }
            Catch
            {
                $ErrorMessage = 'Failed to read file ' + $ARMTemplateParameterFile + ' of type ' + $SetType
                $ErrorMessage += " `n"
                $ErrorMessage += 'Error: '
                $ErrorMessage += $_
                Write-Error `
                    -Message $ErrorMessage `
                    -ErrorAction Stop
            }
            
        
        }
        #endregion
    }
    Catch
    {
        $ParamFileObjChanged = $false
    }

    #region Save File
    If ($ParamFileObjChanged -eq $false)
    {
        $OutputResult = `
                 [pscustomobject]@{'FilePath'    = $ARMTemplateParameterFile;
                                   'FileChanged' = 'No' }
    }
    Else
    {
        Try
        {
            If ($PSCmdlet.ShouldProcess("Saving $NewARMTemplateParamFilePath file.")) 
            {
                # Convert log to JSON and write it into file
                $ParamFileObj | `
                    ConvertTo-Json `
                        -Depth 10 `
                        -ErrorAction Stop | `
                    Out-File `
                        -FilePath $NewARMTemplateParamFilePath `
                        -Encoding unicode `
                        -Force `
                        -ErrorAction Stop
            }
            
            #region Information
            $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - File modified from ' + $ARMTemplateParameterFile + ' to ' + $NewARMTemplateParamFilePath + ' for type ' + $SetType
            Write-Information `
                -MessageData $InformationMessage
            #endregion

            $OutputResult = `
                     [pscustomobject]@{'FilePath'    = $NewARMTemplateParamFilePath;
                                       'FileChanged' = 'Yes' }
        }
        Catch
        {
            $ErrorMessage = 'Failed to convert and save file ' + $NewARMTemplateParamFilePath
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error `
                -Message $ErrorMessage `
                -ErrorAction Stop
        }
        
    }
    #endregion

    return $OutputResult 

}
Function Set-ARMTemplateFile {
<#

    .SYNOPSIS
        Changes location parameter in ARM Template
        json file. Adds it to allowedValues and sets
        it in the defatulValue.

    .DESCRIPTION
        Changes location parameter in ARM Template
        json file. Adds it to allowedValues and sets
        it in the defatulValue. If json file cannot be
        read it will skip everything and output the
        original file.

    .PARAMETER  ARMTemplateFile
        Location to azuredeploy.json file.

    .PARAMETER  SetType
        Type of paramater to be searched and replaced 
        if found. Currently only location is valid
        value.

    .PARAMETER  CreateDefaultValue
        Switch parameter. If the parameter is used and
        there is no defaultValue for the parameter that
        will be modified it will be created for it along
        with value for it.

    .PARAMETER  AzureRegion
        Valid Azure region value. This paramater
        is needed if SetType is location.

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateFile $path -SetType 'Location' -AzureRegion 'North Europe' -CreateDefaultValue
        Description
        -----------
        Find parameter of type 'Location' in ARM Template file, add it to allowedValues and replace/create defaultValue for
        that parameter with 'North Europe'

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.json'
        
    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateFile $path -SetType 'Location' -AzureRegion 'North Europe'
        Description
        -----------
        Find parameter of type 'Location' in ARM Template file, add it to allowedValues and replace defaultValue for
        that parameter with 'North Europe'

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.json'
        
    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateFile $path -SetType 'Location' -AzureRegion 'North Europe' -CreateDefaultValue -InformationAction Continue
        Description
        -----------
        Find parameter of type 'Location' in ARM Template file, add it to allowedValues and replace/create defaultValue for
        that parameter with 'North Europe'
        Shows detailed output information

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.json'
        
    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateFile $path -SetType 'Location' -AzureRegion 'North Europe' -InformationAction Continue
        Description
        -----------
        Find parameter of type 'Location' in ARM Template file, add it to allowedValues and replace defaultValue for
        that parameter with 'North Europe'
        Shows detailed output information

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.json'
        
    .OUTPUTS
        System.Management.Automation.PSCustomObject.
        Returns object with information if the template 
        file has been modified and location to the modified 
        file or the original file.

#>
[CmdletBinding(
    DefaultParameterSetName='DefaultParameterSet',
    SupportsShouldProcess=$true,
    ConfirmImpact='Low'
    )]
[OutputType([pscustomobject])]
param (
        [Parameter(ParameterSetName='DefaultParameterSet',Position=0,Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
        [string]
        $ARMTemplateFile,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=1,Mandatory=$true)]
        [ValidateSet('Location')]
        [string]
        $SetType,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=2,Mandatory=$false)]
        [switch]
        $CreateDefaultValue=$false,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=3,Mandatory=$false)]
        [ValidateSet('Central US', 'East US', 'East US 2', 'US Gov Iowa', 'US Gov Virginia', 'North Central US', 'South Central US', 'West US', 'North Europe', 'West Europe', 'East Asia', 'Southeast Asia', 'Japan East', 'Japan West', 'Brazil South', 'Australia East', 'Australia Southeast', 'Central India', 'South India', 'West India', 'China East', 'China North', 'Canada Central', 'Canada East', 'Germany Central', 'Germany Northeast')]
        [string]$AzureRegion
        )

    #region Initial Setup
    # Set Error Preference	
    $ErrorActionPreference = 'Stop'

    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $SetType is: ' + $SetType
    Write-Verbose `
          -Message $VerboseMessage

    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $ARMTemplateFile is: ' + $ARMTemplateFile
    Write-Verbose `
          -Message $VerboseMessage 

    # Get ARM Template root folder
    $ARMTemplatePath = Split-path `
                        -Path $ARMTemplateFile `
                        -Parent `
                        -ErrorAction Stop
    
    # Get only the name of the file without the extension
    $FileName = (Split-path `
                    -Path $ARMTemplateFile `
                    -Leaf `
                    -ErrorAction Stop).Replace('.json','')

    # Construct new JSON File Path
    $NewARMTemplateFilePath = $ARMTemplatePath + '\' + $FileName + '-modified.json'
    
    $TemplateFileObjChanged = $false

    # If template cannot be converted it is invalid and just skip it
    Try
    {
        # Get Parameter file into object
        $TemplateFileObj = Get-Content `
                            -Path $ARMTemplateFile `
                            -Force `
                            -ErrorAction Stop | `
                           ConvertFrom-Json `
                            -ErrorAction Stop

        
        #endregion

        #region SetType Location
        If ($SetType -eq 'Location') 
        {
            Try
            {
                $LocationKeywords = @('location','region')
                $ResourceGroupLocation = $AzureRegion

                # Go trough every keyword
                foreach ($LocationKeyword in $LocationKeywords)
                {
                    $ParameterNames = $TemplateFileObj.parameters | `
                                        Get-Member `
                                            -ErrorAction Stop | `
                                        Where-Object MemberType -EQ NoteProperty `
                                            -ErrorAction Stop | `
                                        Select-Object -ExpandProperty Name `
                                            -ErrorAction Stop

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $ParameterName  is: ' + $ParameterName 
                        Write-Verbose `
                              -Message $VerboseMessage 

                        If ($ParameterName -match $LocationKeyword)
                        {
                            # Check if there are multiple values
                            If ($TemplateFileObj.parameters.($ParameterName).allowedValues)
                            {
                                If (($TemplateFileObj.parameters.($ParameterName).allowedValues.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    $foundValue = $false
                                    foreach ($PValue in $TemplateFileObj.parameters.($ParameterName).allowedValues)
                                    {
                                        # Find if Value already exists
                                        If ($TemplateFileObj.parameters.($ParameterName).allowedValues[$ValueCount] -eq $ResourceGroupLocation)
                                        {
                                            $foundValue = $true;break;
                                        }
                                        
                                        $ValueCount++
                                    }
                                    # If does not exists add it
                                    If ($foundValue -eq $false)
                                    {
                                        $TemplateFileObj.parameters.($ParameterName).allowedValues += $ResourceGroupLocation
                                        $TemplateFileObjChanged = $true
                                    }
                                }
                                Else
                                {
                                    $TemplateFileObj.parameters.($ParameterName).allowedValues = $ResourceGroupLocation
                                    $TemplateFileObjChanged = $true
                                }
                            }

                            # Check for defaultValue
                            If ($TemplateFileObj.parameters.($ParameterName).defaultValue)
                            {
                                $TemplateFileObj.parameters.($ParameterName).defaultValue = $ResourceGroupLocation
                                $TemplateFileObjChanged = $true
                            }
                            Else
                            {
                                # Create defaultValue
                                If ($CreateDefaultValue -eq $true)
                                {
                                    $TemplateFileObj.parameters.($ParameterName) | Add-Member `
                                                                                    -MemberType NoteProperty `
                                                                                    -Name defaultValue `
                                                                                    -Value $ResourceGroupLocation `
                                                                                    -ErrorAction Stop | Out-Null
                                    $TemplateFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
            }
            Catch
            {
                $ErrorMessage = 'Failed to read file ' + $ARMTemplateFile + ' of type ' + $SetType
                $ErrorMessage += " `n"
                $ErrorMessage += 'Error: '
                $ErrorMessage += $_
                Write-Error `
                    -Message $ErrorMessage `
                    -ErrorAction Stop
            }
            
        
        }
        #endregion
    }
    Catch
    {
        $TemplateFileObjChanged = $false
    }
    
    #region Save File
    If ($TemplateFileObjChanged -eq $false)
    {
        $OutputResult = `
                 [pscustomobject]@{'FilePath'    = $ARMTemplateFile;
                                   'FileChanged' = 'No' }
    }
    Else
    {
        Try
        {
            If ($PSCmdlet.ShouldProcess("Saving $NewARMTemplateFilePath file.")) 
            {
                # Convert log to JSON and write it into file
                $TemplateFileObj | `
                    ConvertTo-Json `
                        -Depth 20 `
                        -ErrorAction Stop | `
                    Out-File `
                        -FilePath $NewARMTemplateFilePath `
                        -Encoding unicode `
                        -Force `
                        -ErrorAction Stop
            }
            
            #region Information
            $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - File modified from ' + $ARMTemplateFile + ' to ' + $NewARMTemplateFilePath + ' for type ' + $SetType
            Write-Information `
                -MessageData $InformationMessage
            #endregion

            $OutputResult = `
                     [pscustomobject]@{'FilePath'    = $NewARMTemplateFilePath;
                                       'FileChanged' = 'Yes' }
        }
        Catch
        {
            $ErrorMessage = 'Failed to convert and save file ' + $NewARMTemplateFilePath
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error `
                -Message $ErrorMessage `
                -ErrorAction Stop
        }
        
    }
    #endregion

    return $OutputResult 

}
Function New-ARMTemplateDeployment {
<#

    .SYNOPSIS
        Deploys ARM Template.

    .DESCRIPTION
        Deploys ARM Template. Finds azuredeploy.json and
        azuredeploy.parameters.json in the template fodler.
        Deploys Azure Resource Group with the name of the 
        ARM Template. Deploys ARM Template from azuredeploy.json 
        and azuredeploy.parameters.json. Writes Success and
        Failed results to log files. Moves the successful
        ARM templates to Successful folder and Failed templates
        to Queued folder. Deletes the Azure Resource Group.

    .PARAMETER  AzureRegion
        Mandatory parameter. Valid name for Azure Region.

    .PARAMETER  ARMTemplatesPath
        Mandatory parameter. Location of the ARM Templates.
        Example: D:\ARMTEST\Downloaded

    .PARAMETER  OutputPath
        Mandatory parameter. Location where Output
        for the cmdlets are.
        Example: D:\ARMTEST\

    .PARAMETER  AzureSubscriptionID
        Mandatory parameter. Valid GUID for Azure 
        Subscribtion ID.

    .PARAMETER  AzureTenantID
        Mandatory parameter. Valid GUID for Azure
        Tenant ID.

    .PARAMETER  AzureCredentials
        Mandatory parameter. Valid credentials
        Azure credentials from Azure AD.

    .PARAMETER  ARMTemplateName
        Optional parameter. ARM Template Name or array of
        ARM Template Names.
        Example 101-application-gateway-create, 
        101-application-gateway-public-ip.

    .EXAMPLE
        New-ARMTemplateDeployment -AzureRegion 'North Europe' -ARMTemplatesPath $ARMTempaltesPath -OutputPath $OutputPath -AzureSubscriptionID $SubID -AzureCredentials $cred
        Description
        -----------
        New ARM Template Deployment by loggin with Subscription ID
        All temlplates from D:\ARMTEST\ will be deployed one by one.

        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $ARMTempaltesPath = 'D:\ARMTEST\Downloaded'
        $OutputPath = 'D:\ARMTEST\'

    .EXAMPLE
        New-ARMTemplateDeployment -AzureRegion 'North Europe' -ARMTemplatesPath $ARMTempaltesPath -OutputPath $OutputPath -AzureSubscriptionID $SubID -AzureCredentials $cred -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip'
        Description
        -----------
        New ARM Template Deployment by loggin with Subscription ID
        Templates '101-application-gateway-create' and '101-application-gateway-public-ip' will be deployed

        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $ARMTempaltesPath = 'D:\ARMTEST\Downloaded'
        $OutputPath = 'D:\ARMTEST\'

    .EXAMPLE
        New-ARMTemplateDeployment -AzureRegion 'North Europe' -ARMTemplatesPath $ARMTempaltesPath -OutputPath $OutputPath -AzureSubscriptionID $SubID -AzureCredentials $cred -ARMTemplateName '101-application-gateway-create'
        Description
        -----------
        New ARM Template Deployment by loggin with Subscription ID
        Template '101-application-gateway-create' will be deployed

        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $ARMTempaltesPath = 'D:\ARMTEST\Downloaded'
        $OutputPath = 'D:\ARMTEST\'

    .EXAMPLE
        New-ARMTemplateDeployment -AzureRegion 'North Europe' -ARMTemplatesPath $ARMTempaltesPath -OutputPath $OutputPath -AzureTenantID $TenID -AzureCredentials $cred
        Description
        -----------
        New ARM Template Deployment by loggin with Tenant ID
        All temlplates from D:\ARMTEST\ will be deployed one by one.

        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential
        $ARMTempaltesPath = 'D:\ARMTEST\Downloaded'
        $OutputPath = 'D:\ARMTEST\'

    .EXAMPLE
        New-ARMTemplateDeployment -AzureRegion 'North Europe' -ARMTemplatesPath $ARMTempaltesPath -OutputPath $OutputPath -AzureTenantID $TenID -AzureCredentials $cred -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip'
        Description
        -----------
        New ARM Template Deployment by loggin with Tenant ID
        Templates '101-application-gateway-create' and '101-application-gateway-public-ip' will be deployed

        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential
        $ARMTempaltesPath = 'D:\ARMTEST\Downloaded'
        $OutputPath = 'D:\ARMTEST\'

    .EXAMPLE
        New-ARMTemplateDeployment -AzureRegion 'North Europe' -ARMTemplatesPath $ARMTempaltesPath -OutputPath $OutputPath -AzureTenantID $TenID -AzureCredentials $cred -ARMTemplateName '101-application-gateway-create'
        Description
        -----------
        New ARM Template Deployment by loggin with Tenant ID
        Template '101-application-gateway-create' will be deployed

        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential
        $ARMTempaltesPath = 'D:\ARMTEST\Downloaded'
        $OutputPath = 'D:\ARMTEST\'

    .EXAMPLE
        New-ARMTemplateDeployment -AzureRegion 'North Europe' -ARMTemplatesPath $ARMTempaltesPath -OutputPath $OutputPath -AzureSubscriptionID $SubID -AzureCredentials $cred -InformationAction Continue
        Description
        -----------
        New ARM Template Deployment by loggin with Subscription ID
        Templates '101-application-gateway-create' and '101-application-gateway-public-ip' will be deployed
        Shows detailed output information

        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $ARMTempaltesPath = 'D:\ARMTEST\Downloaded'
        $OutputPath = 'D:\ARMTEST\'

    .EXAMPLE
        New-ARMTemplateDeployment -AzureRegion 'North Europe' -ARMTemplatesPath $ARMTempaltesPath -OutputPath $OutputPath -AzureSubscriptionID $SubID -AzureCredentials $cred -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -InformationAction Continue
        Description
        -----------
        New ARM Template Deployment by loggin with Subscription ID
        Templates '101-application-gateway-create' and '101-application-gateway-public-ip' will be deployed
        Shows detailed output information

        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $ARMTempaltesPath = 'D:\ARMTEST\Downloaded'
        $OutputPath = 'D:\ARMTEST\'

    .EXAMPLE
        New-ARMTemplateDeployment -AzureRegion 'North Europe' -ARMTemplatesPath $ARMTempaltesPath -OutputPath $OutputPath -AzureSubscriptionID $SubID -AzureCredentials $cred -ARMTemplateName '101-application-gateway-create' -InformationAction Continue
        Description
        -----------
        New ARM Template Deployment by loggin with Subscription ID
        Template '101-application-gateway-create' will be deployed
        Shows detailed output information

        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $ARMTempaltesPath = 'D:\ARMTEST\Downloaded'
        $OutputPath = 'D:\ARMTEST\'

    .EXAMPLE
        New-ARMTemplateDeployment -AzureRegion 'North Europe' -ARMTemplatesPath $ARMTempaltesPath -OutputPath $OutputPath -AzureTenantID $TenID -AzureCredentials $cred -InformationAction Continue
        Description
        -----------
        New ARM Template Deployment by loggin with Tenant ID
        All temlplates from D:\ARMTEST\ will be deployed one by one.
        Shows detailed output information

        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential
        $ARMTempaltesPath = 'D:\ARMTEST\Downloaded'
        $OutputPath = 'D:\ARMTEST\'

    .EXAMPLE
        New-ARMTemplateDeployment -AzureRegion 'North Europe' -ARMTemplatesPath $ARMTempaltesPath -OutputPath $OutputPath -AzureTenantID $TenID -AzureCredentials $cred -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -InformationAction Continue
        Description
        -----------
        New ARM Template Deployment by loggin with Tenant ID
        Templates '101-application-gateway-create' and '101-application-gateway-public-ip' will be deployed
        Shows detailed output information

        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential
        $ARMTempaltesPath = 'D:\ARMTEST\Downloaded'
        $OutputPath = 'D:\ARMTEST\'

    .EXAMPLE
        New-ARMTemplateDeployment -AzureRegion 'North Europe' -ARMTemplatesPath $ARMTempaltesPath -OutputPath $OutputPath -AzureTenantID $TenID -AzureCredentials $cred -ARMTemplateName '101-application-gateway-create' -InformationAction Continue
        Description
        -----------
        New ARM Template Deployment by loggin with Tenant ID
        Template '101-application-gateway-create' will be deployed
        Shows detailed output information

        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential
        $ARMTempaltesPath = 'D:\ARMTEST\Downloaded'
        $OutputPath = 'D:\ARMTEST\'

    .OUTPUTS
        System.Management.Automation.PSCustomObject.
        Returns numbers of failed and succeeded
        ARM Template Deployments.

#>
[CmdletBinding(
    SupportsShouldProcess=$true,
    ConfirmImpact='Low',
    DefaultParameterSetName='LoginBySubscriptionID'
)]
[OutputType([pscustomobject])]
param (
        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=0,Mandatory=$true)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=0,Mandatory=$true)]
        [ValidateSet('Central US', 'East US', 'East US 2', 'US Gov Iowa', 'US Gov Virginia', 'North Central US', 'South Central US', 'West US', 'North Europe', 'West Europe', 'East Asia', 'Southeast Asia', 'Japan East', 'Japan West', 'Brazil South', 'Australia East', 'Australia Southeast', 'Central India', 'South India', 'West India', 'China East', 'China North', 'Canada Central', 'Canada East', 'Germany Central', 'Germany Northeast')]
        [string]$AzureRegion,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=1,Mandatory=$true)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=1,Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Container})] 
        [string]
        $ARMTemplatesPath,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=2,Mandatory=$true)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=2,Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Container})] 
        [string]
        $OutputPath,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=3,Mandatory=$true)]
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

        [Parameter(ParameterSetName='LoginByTenantID',Position=3,Mandatory=$true)]
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

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=4,Mandatory=$true)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=4,Mandatory=$true)]
        [PSCredential]
        $AzureCredentials,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=5,Mandatory=$false)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=5,Mandatory=$false)]
        [string[]]
        $ARMTemplateName
        )
    
    #region Initiial Setup

    # Set Error Preference	
	$ErrorActionPreference = 'Stop'

    # Variables 
    $azuredeployFileName = 'azuredeploy.json'
    $azuredeployParametersFileName = 'azuredeploy.parameters.json'
    $ARMTemplateSuccess = 0
    $ARMTemplateError = 0
    $ARMTemplateInvalid = 0
    $ARMTemplateBadError = 0


    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $azuredeployFileName is: ' + $azuredeployFileName
    Write-Verbose `
         -Message $VerboseMessage 



    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $azuredeployParametersFileName is: ' + $azuredeployParametersFileName
    Write-Verbose `
         -Message $VerboseMessage 

    
    # If $ARMTemplateName parameter is not specified
    If ($null -eq $ARMTemplateName)
    {
        # Get array of names of the templates by using
        # the folder structure
        $ARMTemplateName = Get-ChildItem `
                                -Path $ARMTemplatesPath `
                                -Directory `
                                -ErrorAction Stop | `
                                Select-Object `
                                    -ExpandProperty Name `
                                    -ErrorAction Stop
    }
    #endregion

    #region Loop trough Templates
    # Iterate trough every ARM template name
    foreach ($ARMTemplateFolderName in $ARMTemplateName)
    {
        
       #region Construct variables
       # Construct the full path to the ARM Template
       $ARMTemplateFolder = $ARMTemplatesPath.TrimEnd('\') + '\' + $ARMTemplateFolderName


       $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $ARMTemplateFolder is : ' + $ARMTemplateFolder
       Write-Verbose `
            -Message $VerboseMessage 

       
       # Construct path to azuredeploy.json in the ARM template
       $azuredeployLocation = $ARMTemplateFolder + '\' + $azuredeployFileName 


       $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $azuredeployLocation is : ' + $azuredeployLocation
       Write-Verbose `
            -Message $VerboseMessage 


       # Construct path to azuredeploy.parameters.json in the ARM template
       $azuredeployParametersLocation = $ARMTemplateFolder + '\' + $azuredeployParametersFileName


       $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $azuredeployParametersLocation is : ' + $azuredeployParametersLocation
       Write-Verbose `
            -Message $VerboseMessage 

       #endregion

       #region Check if both azuredeploy.json and azuredeploy.parameters.json exists
       # in the ARM template folder
       If ((Test-Path -Path $azuredeployLocation) -and (Test-Path -Path $azuredeployParametersLocation) -eq $true)
       {

           $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - ' + $azuredeployFileName + ' and ' + $azuredeployParametersFileName + ' are present in ' + $ARMTemplateFolder
           Write-Verbose `
               -Message $VerboseMessage 


           #region Login if needed
           If ([string]::IsNullOrEmpty($AzureTenantID) -eq $false)
           {
               Add-ARMTemplateLogin `
                   -AzureTenantID $AzureTenantID `
                   -AzureCredentials $AzureCredentials `
                   -ErrorAction Stop | Out-Null
           }
           Else
           {
               Add-ARMTemplateLogin `
                   -AzureSubscriptionID $AzureSubscriptionID `
                   -AzureCredentials $AzureCredentials `
                   -ErrorAction Stop | Out-Null
           }
           #endregion
           
           #region Create Azure Resource Group
           Try
           {
               

               $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting Azure Resource Group creation: ' + $ARMTemplateFolderName + ' in region ' + $AzureRegion
               Write-Verbose `
                   -Message $VerboseMessage 


               # Create New Azur Resource Group
               New-AzureRmResourceGroup `
                   -Name $ARMTemplateFolderName `
                   -Location $AzureRegion `
                   -Force `
                   -ErrorAction Stop | Out-Null
               
               #region Information
               $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Created Azure Resource Group: ' + $ARMTemplateFolderName + ' in region ' + $AzureRegion
               Write-Information `
                   -MessageData $InformationMessage
               #endregion


               $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Created Azure Resource Group: ' + $ARMTemplateFolderName + ' in region ' + $AzureRegion + '.'
               Write-Verbose `
                   -Message $VerboseMessage 

           }
           Catch
           {
               $ErrorMessage = 'Failed to create Azure Resource Group.'
               $ErrorMessage += " `n"
               $ErrorMessage += 'Error: '
               $ErrorMessage += $_
               Write-Error `
                   -Message $ErrorMessage `
                   -ErrorAction Stop
           }
           #endregion
           
           #region Change region in parameters file

           $ParamFileChangeResult = Set-ARMTemplateParameterFile `
                                        -ARMTemplateParameterFile $azuredeployParametersLocation `
                                        -SetType Location `
                                        -AzureRegion $AzureRegion `
                                        -ErrorAction Stop
           
           # Change location if file is modified
           If ($ParamFileChangeResult.FileChanged -eq 'Yes')
           {
               $azuredeployParametersLocation = $ParamFileChangeResult.FilePath
           }

           #endregion

           #region Change region in template file

           $TemplateFileChangeResult = Set-ARMTemplateFile `
                                        -ARMTemplateFile $azuredeployLocation `
                                        -SetType Location `
                                        -AzureRegion $AzureRegion `
                                        -CreateDefaultValue `
                                        -ErrorAction Stop
           
           If ($TemplateFileChangeResult.FileChanged -eq 'Yes')
           {
               $azuredeployLocation = $TemplateFileChangeResult.FilePath
           }

           #endregion

           #region Azure Resource Group Deployment
           Try
           {
                   $DeploymentError = $null
                   $AzureDeploymentOutput = $null
                   $DeploymentName = ($ARMTemplateFolderName + '-' + ((Get-Date).ToUniversalTime()).ToString('ddMMyy-HHmmss'))


                   $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $DeploymentName is: ' + $DeploymentName
                   Write-Verbose `
                       -Message $VerboseMessage 



                   $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting Azure Resource Group Deployment: ' + $DeploymentName
                   $VerboseMessage += " `n"
                   $VerboseMessage += 'Deployment Name: ' + $DeploymentName
                   $VerboseMessage += " `n"
                   $VerboseMessage += 'Resource Group Name: ' + $ARMTemplateFolderName
                   $VerboseMessage += " `n"
                   $VerboseMessage += 'Template File: ' + $azuredeployLocation
                   $VerboseMessage += " `n"
                   $VerboseMessage += 'Template Parameter File: ' + $azuredeployParametersLocation
                   Write-Verbose `
                       -Message $VerboseMessage 


                   #region Information
                   $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Starting deployment: ' + $DeploymentName + ' for template ' + $ARMTemplateFolderName
                   Write-Information `
                       -MessageData $InformationMessage
                   #endregion

                   $AzureDeploymentOutput = New-AzureRmResourceGroupDeployment `
                                               -Name  $DeploymentName `
                                               -ResourceGroupName $ARMTemplateFolderName `
                                               -TemplateFile $azuredeployLocation `
                                               -TemplateParameterFile $azuredeployParametersLocation `
                                               -Force `
                                               -ErrorAction SilentlyContinue `
                                               -ErrorVariable DeploymentError

                   #region Deploymnent Failed on start
                   if ($DeploymentError -ne $null -and $null -eq $AzureDeploymentOutput)
                   {

                       $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Deployment ' + $DeploymentName + ' failed'
                       Write-Verbose `
                           -Message $VerboseMessage


                       $PowerShellErrorObj = `
                           [pscustomobject]@{'Exception' = $DeploymentError.Exception.Message}
                       
                       # Wait until logs appear
                       $AzureAuditLogs = $null
                       $EndDate = (Get-Date).AddSeconds(300)
                       
                       do 
                       {
                           Start-Sleep `
                               -Seconds 10
                           
                           $AzureAuditLogs = Get-AzureRmLog `
                                               -ResourceGroup $ARMTemplateFolderName `
                                               -StartTime (Get-Date).AddHours(-1) `
                                               -Status Failed `
                                               -DetailedOutput `
                                               -ErrorAction Stop
                           
                           if ([string]::IsNullOrEmpty($AzureAuditLogs) -eq $false)
                           {
                               break;
                           }
                           
                           $CurrrentDate = Get-Date

                       }while ($CurrrentDate -le $EndDate)

                       
                       
                       # If $AzureAuditLogs is empty write error
                       If ([string]::IsNullOrEmpty($AzureAuditLogs) -eq $true)
                       {
                            # Move template folder to BadError
                            Move-ARMTemplateFolder `
                                -ARMTemplatePath $ARMTemplateFolder `
                                -OutputPath $OutputPath `
                                -ARMTemplateStatus BadError `
                                -ErrorAction Stop | Out-Null
                            
                            $ARMTemplateBadError++
                            
                            $WarningMessage = 'Failed to start Azure Resource Group Deployment.'
                            $WarningMessage += " `n"
                            $WarningMessage = 'No Azure Audit logs were available for writing the error in log.'
                            $WarningMessage += " `n"
                            $WarningMessage += 'Error: '
                            $WarningMessage += $DeploymentError
                            Write-Warning `
                                -Message $WarningMessage
                            
                           #region Information
                           $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Deployment: ' + $DeploymentName + ' failed for template ' + $ARMTemplateFolderName
                           Write-Information `
                               -MessageData $InformationMessage
                           #endregion
                       }
                       # If $AzureAuditLogs has results
                       Else
                       {
                           Write-ARMTemplateLog `
                               -DeploymentLog $PowerShellErrorObj `
                               -ResourcesLogs $AzureAuditLogs `
                               -LogType PowerShellError `
                               -ARMTemplatePath $ARMTemplateFolder `
                               -ErrorAction Stop | Out-Null
                       
                           # Move template folder to Queued
                           Move-ARMTemplateFolder `
                               -ARMTemplatePath $ARMTemplateFolder `
                               -OutputPath $OutputPath `
                               -ARMTemplateStatus Error `
                               -ErrorAction Stop | Out-Null
                           
                           
                           # Increment Failed templates count
                           $ARMTemplateError++
                           
                           #region Information
                           $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Deployment: ' + $DeploymentName + ' failed for template ' + $ARMTemplateFolderName
                           Write-Information `
                               -MessageData $InformationMessage
                           #endregion
                       }
                       
                       
                   }
                   #endregion
                   #region Failed Deployment
                   Elseif ($DeploymentError -ne $null -and $AzureDeploymentOutput.ProvisioningState -eq 'Failed')
                   {

                       $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Deployment ' + $DeploymentName + ' failed'
                       Write-Verbose `
                           -Message $VerboseMessage

                       
                       # Get Resource Group Deployment information
                       $DeploymetnStateObj = Get-AzureRmResourceGroupDeployment `
                                                   -ResourceGroupName $ARMTemplateFolderName `
                                                   -Name $DeploymentName `
                                                   -ErrorAction Stop
                       
                       # Get Resource Group advanced deployment information
                       $FailedOperations = Get-AzureRmResourceGroupDeploymentOperation `
                                               -DeploymentName $DeploymentName `
                                               -ResourceGroupName $ARMTemplateFolderName `
                                               -ErrorAction Stop
                      
                       # Write failure information to log
                       Write-ARMTemplateLog `
                            -DeploymentLog $DeploymetnStateObj `
                            -ResourcesLogs $FailedOperations `
                            -LogType Error `
                            -ARMTemplatePath $ARMTemplateFolder `
                            -ErrorAction Stop | Out-Null
                       
                       # Move template folder to Queued
                       Move-ARMTemplateFolder `
                           -ARMTemplatePath $ARMTemplateFolder `
                           -OutputPath $OutputPath `
                           -ARMTemplateStatus Error `
                           -ErrorAction Stop | Out-Null
                       
                       # Increment Failed templates count
                       $ARMTemplateError++

                       #region Information
                       $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Deployment: ' + $DeploymentName + ' failed for template ' + $ARMTemplateFolderName
                       Write-Information `
                           -MessageData $InformationMessage
                       #endregion
                   }
                   #endregion
                   #region Successful Deployment
                   Elseif ($AzureDeploymentOutput.ProvisioningState -eq 'Succeeded')
                   {

                       $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Deployment ' + $DeploymentName + ' succeeded'
                       Write-Verbose `
                           -Message $VerboseMessage


                       # Get Resource Group Deployment information
                       $DeploymetnStateObj = Get-AzureRmResourceGroupDeployment `
                                                   -ResourceGroupName $ARMTemplateFolderName `
                                                   -Name $DeploymentName `
                                                   -ErrorAction Stop
                       
                       # Get Resource Group Deployment advanced information
                       $SucceededOperations = Get-AzureRmResourceGroupDeploymentOperation `
                                               -DeploymentName $DeploymentName `
                                               -ResourceGroupName $ARMTemplateFolderName `
                                               -ErrorAction Stop 
                       
                       # Write success information to log
                       Write-ARMTemplateLog `
                            -DeploymentLog $DeploymetnStateObj `
                            -ResourcesLogs $SucceededOperations `
                            -LogType Success `
                            -ARMTemplatePath $ARMTemplateFolder `
                            -ErrorAction Stop | Out-Null

                       # Move template folder to Successful
                       Move-ARMTemplateFolder `
                           -ARMTemplatePath $ARMTemplateFolder `
                           -OutputPath $OutputPath `
                           -ARMTemplateStatus Success `
                           -ErrorAction Stop | Out-Null
                       
                       # Increment successfull templates count
                       $ARMTemplateSuccess++

                       #region Information
                       $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Deployment: ' + $DeploymentName + ' succeeded for template ' + $ARMTemplateFolderName
                       Write-Information `
                           -MessageData $InformationMessage
                       #endregion

                   }
                   #endregion
 
               }
           Catch
           {
                   $ErrorMessage = 'Failed to create Azure Resource Group Deployment.'
                   $ErrorMessage += " `n"
                   $ErrorMessage += 'Error: '
                   $ErrorMessage += $_
                   Write-Error `
                       -Message $ErrorMessage `
                       -ErrorAction Stop
               }
           #endregion

           #region Remove Azure Resource Group
           $RemoveRGParams = @{}
           
           If ([string]::IsNullOrEmpty($AzureTenantID) -eq $false)
           {
               $RemoveRGParams.Add('AzureTenantID', $AzureTenantID)
           }
           Else
           {
               $RemoveRGParams.Add('AzureSubscriptionID', $AzureSubscriptionID)
           }
           
           $RemoveRGParams.Add('ARMTemplateName', $ARMTemplateFolderName)
           $RemoveRGParams.Add('AzureCredentials', $AzureCredentials)
           
           Remove-ARMTemplateDeployment `
               -ErrorAction Stop `
               @RemoveRGParams
       
           #endregion
           
       }
       #endregion
       #region Move to Invalid
       Else
       {

           $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - ' + $azuredeployFileName + ' and/or ' + $azuredeployParametersFileName + ' are not present in ' + $ARMTemplateFolder
           Write-Verbose `
               -Message $VerboseMessage 


           # Move folder if does not contain azuredeploy.json and azuredeploy.parameters.json
           If ($PSCmdlet.ShouldProcess("Moving $ARMTemplateFolder to Invalid folder.")) 
           {

                $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting to move folder ' + $ARMTemplateFolder
                Write-Verbose `
                    -Message $VerboseMessage 


                Move-ARMTemplateFolder `
                    -ARMTemplatePath $ARMTemplateFolder `
                    -OutputPath $OutputPath `
                    -ARMTemplateStatus Invalid `
                    -ErrorAction Stop
                
                $ARMTemplateInvalid++

                #region Information
                $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Template is invalid: ' + $ARMTemplateFolderName
                Write-Information `
                    -MessageData $InformationMessage
                #endregion


                $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Moved folder ' + $ARMTemplateFolder
                Write-Verbose `
                    -Message $VerboseMessage 

           }
       }
       #endregion   
    }
    #endregion

    # Output results
    $ARMTemplatesSummary = `
            [pscustomobject]@{'Succeeded' = $ARMTemplateSuccess;
                              'Failed'    = $ARMTemplateError;
                              'Invalid'   = $ARMTemplateInvalid;
                              'BadError'  = $ARMTemplateBadError}

    return $ARMTemplatesSummary
}
Function Get-GitHubRepositoryMasterArchive {
<#

    .SYNOPSIS
        Downloads Master Archive from GitHub Repository.

    .DESCRIPTION
        Downloads Master Archive from GitHub Repository.

    .PARAMETER  GitHubRepositoryURL
        Mandatory parameter. The URL for the Master GitHub
        repository. Example: https://github.com/Azure/azure-quickstart-templates

    .PARAMETER  OutputPath
        Mandatory parameter. Location where the master
        GtiHub repository archive will be saved.
        Example D:\ARMTEST

    .EXAMPLE
        Get-GitHubRepositoryMasterArchive -GitHubRepositoryURL 'https://github.com/Azure/azure-quickstart-templates' -OutputPath D:\ARMTEST
        Description
        -----------
        Downloads GitHub master archive from repository 'https://github.com/Azure/azure-quickstart-templates' and saves it in D:\ARMTEST

    .EXAMPLE
        Get-GitHubRepositoryMasterArchive -GitHubRepositoryURL 'https://github.com/Azure/azure-quickstart-templates' -OutputPath D:\ARMTEST -InformationAction Continue
        Description
        -----------
        Downloads GitHub master archive from repository 'https://github.com/Azure/azure-quickstart-templates' and saves it in D:\ARMTEST
        Shows detailed output information

    .OUTPUTS
        System.String. Returns the location of the
        downloaded GitHub master repistory archive.

#>
[CmdletBinding()]
[OutputType([String])]
param (    
        [Parameter(Mandatory=$true)]
        [ValidateScript({
            If ($_ -match '.github\.com.') 
            {
                $True
            }
            else 
            {
                Throw "$_ is not valid Github.com URL."
            }
        })]
        [String] 
        $GitHubRepositoryURL,

        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Container})] 
        [String] 
        $OutputPath
        )
    
    #region Initial Setup
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'

    # GitHub master archive location
    $MasterArchive = '/archive/master.zip'


    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $MasterArchive is: ' + $MasterArchive
    Write-Verbose `
        -Message $VerboseMessage


    # Trim the last / in the URL if needed
    $GitHubRepositoryURL = $GitHubRepositoryURL.TrimEnd('/')


    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $GitHubRepositoryURL is: ' + $GitHubRepositoryURL
    Write-Verbose `
        -Message $VerboseMessage


    # Get the name of the repository from the URL
    $RepositoryName = $GitHubRepositoryURL.Split('/')[-1]


    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $RepositoryName is: ' + $RepositoryName
    Write-Verbose `
        -Message $VerboseMessage


    # Extension for archive
    $ArchiveExt = '.zip'
    
    # Construct full URI to the Master Archive
    $MasterArchiveFullURI = $GitHubRepositoryURL + $MasterArchive


    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $MasterArchiveFullURI is: ' + $MasterArchiveFullURI
    Write-Verbose `
        -Message $VerboseMessage

    
    # Trim last \ in output location if needed
    $OutputPath = $OutputPath.TrimEnd('\')


    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $OutputPath is: ' + $OutputPath
    Write-Verbose `
        -Message $VerboseMessage

    
    # Construct full output location
    $FullOutputLocation = $OutputPath + '\' + $RepositoryName + $ArchiveExt


    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $FullOutputLocation is: ' + $FullOutputLocation
    Write-Verbose `
        -Message $VerboseMessage

    #endregion

    #region Download
    Try
    {

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting download of ' + $MasterArchiveFullURI + ' to ' + $FullOutputLocation
        Write-Verbose `
            -Message $VerboseMessage


        #region Information
        $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Starting download of ' + $MasterArchiveFullURI
        Write-Information `
            -MessageData $InformationMessage
        #endregion

        # Downlaod with Web request
        $RequestResult = Invoke-WebRequest `
                            -Uri $MasterArchiveFullURI `
                            -OutFile $FullOutputLocation `
                            -UseBasicParsing `
                            -passthru `
                            -ErrorAction Stop
        
        #region Information
        $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Downloaded ' + $MasterArchiveFullURI + ' to ' + $FullOutputLocation
        Write-Information `
            -MessageData $InformationMessage
        #endregion


        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Finished downloading of ' + $MasterArchiveFullURI + ' to ' + $FullOutputLocation
        Write-Verbose `
            -Message $VerboseMessage

    }
    Catch
    {
        $ErrorMessage = 'Failed to download ' + $MasterArchiveFullURI + ' .'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    
    # Check if access to URL was successful
    If ($RequestResult.StatusCode -eq 200)
    {

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - HTTP status code of 200 was returned for downloading GitHub Master Archive'
        Write-Verbose `
            -Message $VerboseMessage


        # Check if file is saved successfully
        If ((Test-Path -Path $FullOutputLocation) -eq $true)
        {

            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - File ' + $FullOutputLocation + ' is present.'
            Write-Verbose `
                -Message $VerboseMessage 


            # Return the archive location locally
            $return = $FullOutputLocation
        }
        Else
        {
            $ErrorMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Failed to save downloaded file to ' + $FullOutputLocation + ' .'
            Write-Error `
                -Message $ErrorMessage `
                -ErrorAction Stop
        }
    }
    Else
    {
        $ErrorMessage = 'Failed to download ' + $MasterArchiveFullURI + ' .'
        $ErrorMessage += " `n"
        $ErrorMessage += 'HTTP Error: '
        $ErrorMessage += $RequestResult
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    #endregion

    return $return
}
Function Expand-GitHubMasterArchive {
<#

    .SYNOPSIS
        Expands archive downlaoded from GitHub master repostiory.

    .DESCRIPTION
        Expands archive downlaoded from GitHub master repostiory.

    .PARAMETER  GitHubMasterArchiveLocation
        Mandatory parameter. Location of the archive for expand
        Example: D:\ARMTEST\azure-quickstart-templates.zip

    .PARAMETER  OutputPath
        Mandatory parameter. Location where the master
        GtiHub repository will be expanded.
        Example D:\ARMTEST

    .PARAMETER  ARMTemplateName
        Optional parameter. ARM Template Name or array of
        ARM Template Names
        Example 101-application-gateway-create, 101-application-gateway-public-ip

    .EXAMPLE
        Expand-GitHubMasterArchive -GitHubMasterArchivePath 'D:\ARMTEST\azure-quickstart-templates.zip' -OutputPath 'D:\ARMTEST'
        Description
        -----------
        Expand GitHub master archive D:\ARMTEST\azure-quickstart-templates.zip to 'D:\ARMTEST'
        Expands all ARM templates in it.

    .EXAMPLE
        Expand-GitHubMasterArchive -GitHubMasterArchivePath 'D:\ARMTEST\azure-quickstart-templates.zip' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create'
        Description
        -----------
        Expand GitHub master archive D:\ARMTEST\azure-quickstart-templates.zip to 'D:\ARMTEST'
        Expands only '101-application-gateway-create' ARM Template

    .EXAMPLE
        Expand-GitHubMasterArchive -GitHubMasterArchivePath 'D:\ARMTEST\azure-quickstart-templates.zip' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip'
        Description
        -----------
        Expand GitHub master archive D:\ARMTEST\azure-quickstart-templates.zip to 'D:\ARMTEST'
        Expands only '101-application-gateway-create' and '101-application-gateway-public-ip' ARM Template

     .EXAMPLE
        Expand-GitHubMasterArchive -GitHubMasterArchivePath 'D:\ARMTEST\azure-quickstart-templates.zip' -OutputPath 'D:\ARMTEST' -InformationAction Continue
        Description
        -----------
        Expand GitHub master archive D:\ARMTEST\azure-quickstart-templates.zip to 'D:\ARMTEST'
        Expands all ARM templates in it.
        Shows detailed output information

    .EXAMPLE
        Expand-GitHubMasterArchive -GitHubMasterArchivePath 'D:\ARMTEST\azure-quickstart-templates.zip' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -InformationAction Continue
        Description
        -----------
        Expand GitHub master archive D:\ARMTEST\azure-quickstart-templates.zip to 'D:\ARMTEST'
        Expands only '101-application-gateway-create' ARM Template
        Shows detailed output information

    .EXAMPLE
        Expand-GitHubMasterArchive -GitHubMasterArchivePath 'D:\ARMTEST\azure-quickstart-templates.zip' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -InformationAction Continue
        Description
        -----------
        Expand GitHub master archive D:\ARMTEST\azure-quickstart-templates.zip to 'D:\ARMTEST'
        Expands only '101-application-gateway-create' and '101-application-gateway-public-ip' ARM Template
        Shows detailed output information

    .OUTPUTS
        System.String. Returns the location where the
        GitHub Master Archive was expanded.

#>
[CmdletBinding(DefaultParameterSetName='DefaultParameterSet')]
[OutputType([String])]
param (    
        [Parameter(ParameterSetName='DefaultParameterSet',Position=0,Mandatory=$true)]
        [ValidatePattern('.\.zip$')]
        [String] 
        $GitHubMasterArchivePath,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=1,Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Container})]
        [String] 
        $OutputPath,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=2,Mandatory=$false)]
        [string[]]
        $ARMTemplateName
        )
    
    #region Initial Setup
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'

    # Downloaded folder
    $DownloadedFolder = 'Downloaded'

    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + 'Variable $DownloadedFolder is: ' + $DownloadedFolder
    Write-Verbose `
        -Message $VerboseMessage

    Try
    {

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting loading System.IO.Compression.FileSystem assembly'
        Write-Verbose `
            -Message $VerboseMessage 


        # Load System.IO.Compression.FileSystem assembly
        [System.Reflection.Assembly]::LoadWithPartialName('System.IO.Compression.FileSystem') | Out-Null
        

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Loaded System.IO.Compression.FileSystem assembly'
        Write-Verbose `
            -Message $VerboseMessage 

    }
    Catch
    {
        $ErrorMessage = 'Failed to load System.IO.Compression.FileSystem assembly.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }

    Try
    {
        # Get the name of the archive by cutting path and extension
        $ArchiveName = $GitHubMasterArchivePath.Split('.')[0].Split('\')[-1]
        

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() +  ' - Variable $ArchiveName is: ' + $ArchiveName
        Write-Verbose `
            -Message $VerboseMessage 



        # Trim \ for OutputFolder if needed
        $OutputPath = $OutputPath.TrimEnd('\') 
        $DownloadedFolderPath = $OutputPath + '\' + $DownloadedFolder

        If ((Test-path -Path $DownloadedFolderPath) -eq $false)
        {
            New-Item `
                -Path $DownloadedFolderPath `
                -ItemType Directory `
                -Force `
                -ErrorAction Stop | Out-Null
        }


        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() +  ' - Variable $OutputPath is: ' + $OutputPath
        Write-Verbose `
            -Message $VerboseMessage 


        # Create location for temporary folder
        $TempFolder = $OutputPath + '\temp'


        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() +  ' - Variable $TempFolder is: ' + $TempFolder 
        Write-Verbose `
            -Message $VerboseMessage 

    }
    Catch
    {
        $ErrorMessage = 'Failed to transform variables.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    
    }
    
    Try
    {
        # Check if temporary folde exists
        If ((Test-path -Path $TempFolder) -eq $true)
        {

            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting removal of folder: ' + $TempFolder
            Write-Verbose `
                -Message $VerboseMessage 


            # Delete if temporary folder exists
            Remove-Item `
                -Path $TempFolder `
                -Recurse `
                -Force `
                -ErrorAction Stop


            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Removed folder: ' + $TempFolder
            Write-Verbose `
                -Message $VerboseMessage 

        }
    }
    Catch
    {
        $ErrorMessage = 'Failed to delete ' + $TempFolder + ' folder.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    #endregion
    
    #region Extract    
    Try
    {

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting extraction of ' + $GitHubMasterArchivePath + ' to ' + $TempFolder
        Write-Verbose `
             -Message $VerboseMessage 


        # Extract archive to temporary folder
        [System.IO.Compression.ZipFile]::ExtractToDirectory($GitHubMasterArchivePath, $TempFolder)
        

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Extracted ' + $GitHubMasterArchivePath + ' to ' + $TempFolder + ' .'
        Write-Verbose `
             -Message $VerboseMessage 

    }
    Catch
    {
        $ErrorMessage = 'Failed to expand archive: ' + $GitHubMasterArchivePath
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    
    Try
    {
        # The GitHUb master archive has one top folder
        # We get the name of that folder Example: azure-quickstart-templates-master
        $MainFolderName = Get-ChildItem `
                            -Path $TempFolder `
                            -ErrorAction Stop | `
                            where-object `
                                -Property Name `
                                -Match $ArchiveName `
                                -ErrorAction Stop | `
                            Select-object `
                                -ExpandProperty Name `
                                -ErrorAction Stop
        

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $MainFolderName is: ' + $MainFolderName
        Write-Verbose `
            -Message $VerboseMessage 

    }
    Catch
    {
        $ErrorMessage = 'Failed to find the expanded files in : ' + $TempFolder
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    
    # If single ARM Template or Array of templates needs to be extracted
    If ($null -ne $ARMTemplateName)
    {

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Single template or array of templates will be extracted.'
        Write-Verbose `
            -Message $VerboseMessage 


        foreach ($ARMTemplatesFolderName in $ARMTemplateName)
        {
            # Construct the location where the template is temporary extracted
            $TemplatesFolder = $TempFolder + '\' + $MainFolderName + '\' + $ARMTemplatesFolderName


            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $TemplatesFolder is : ' + $TemplatesFolder
            Write-Verbose `
                -Message $VerboseMessage 

        
            Try
            {

                $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting copying files from ' + $TemplatesFolder + ' to ' + $OutputPath + ' .'
                Write-Verbose `
                    -Message $VerboseMessage 


                # Copy templates from temporary folder to OutputFolder.
                # Overwrite existing
                Copy-Item `
                    -Path $TemplatesFolder `
                    -Destination $DownloadedFolderPath `
                    -Force `
                    -Recurse `
                    -ErrorAction Stop
                
                #region Information
                $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Extracted template ' + $ARMTemplatesFolderName + ' to ' + $DownloadedFolderPath
                Write-Information `
                    -MessageData $InformationMessage
                #endregion


                $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Copied files from ' + $TemplatesFolder + ' to ' + $OutputPath
                Write-Verbose `
                    -Message $VerboseMessage 

            }
            Catch
            {
                $ErrorMessage = 'Failed to copy files from ' + $TemplatesFolder + ' to ' + $OutputPath + ' .'
                $ErrorMessage += " `n"
                $ErrorMessage += 'Error: '
                $ErrorMessage += $_
                Write-Error `
                    -Message $ErrorMessage `
                    -ErrorAction Stop
            } 
        }
        
    }
    # If all templates are extracted
    Else
    {

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - All templates will be extracted'
        Write-Verbose `
            -Message $VerboseMessage 


        # Construct the location where templates are temporary extracted
        $TemplatesFolder = $TempFolder + '\' + $MainFolderName + '\*'

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $TemplatesFolder is : ' + $TemplatesFolder
        Write-Verbose `
            -Message $VerboseMessage 

        
        Try
        {
            

            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting removal of files in top folder ' + $TemplatesFolder
            Write-Verbose `
                 -Message $VerboseMessage 


            Get-childItem `
                -Path $TemplatesFolder `
                -File `
                -ErrorAction Stop | `
                Remove-Item `
                    -Force `
                    -ErrorAction Stop


            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Finished removal of files in top folder ' + $TemplatesFolder
            Write-Verbose `
                 -Message $VerboseMessage 



            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting copying files from ' + $TemplatesFolder + ' to ' + $OutputPath
            Write-Verbose `
                 -Message $VerboseMessage 


            # Copy templates from temporary folder to OutputFolder.
            # Overwrite existing
            Copy-Item `
                -Path $TemplatesFolder `
                -Destination $DownloadedFolderPath `
                -Force `
                -Recurse `
                -ErrorAction Stop
            
            #region Information
            $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Extracted all templates to ' + $DownloadedFolderPath
            Write-Information `
                -MessageData $InformationMessage
            #endregion


            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Copied files from ' + $TemplatesFolder + ' to ' + $OutputPath
            Write-Verbose `
                 -Message $VerboseMessage 

        }
        Catch
        {
            $ErrorMessage = 'Failed to copy files from ' + $TemplatesFolder + ' to ' + $OutputPath + ' .'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error `
                -Message $ErrorMessage `
                -ErrorAction Stop
        }
    }
    #endregion

    #region delete Temp folder
    Try
    {

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting removal of folder ' + $TempFolder
        Write-Verbose `
              -Message $VerboseMessage 


        # Remove temporary folder
        Remove-Item `
            -Path $TempFolder `
            -Recurse `
            -Force

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Folder ' + $TempFolder + ' was removed'
        Write-Verbose `
              -Message $VerboseMessage 

    }
    Catch
    {
        $ErrorMessage = 'Failed to remove folder ' + $TempFolder 
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    #endregion

    return $DownloadedFolderPath
}
Function Merge-ARMTemplateLog {
<#

    .SYNOPSIS
        Merges Error or Success logs from all templates 
        into one master log.

    .DESCRIPTION
        Merges Error or Success logs from all templates 
        into one master log.

    .PARAMETER  OutputPath
        Mandatory parameter. Location where Output
        for the cmdlets are.
        Example: D:\ARMTEST\

    .PARAMETER  LogType
        Mandatory parameter.Acceptable values
        are Error and Success. The value designates
        what type of log will be merged.

    .EXAMPLE
        Merge-ARMTemplateLog -OutputPath 'D:\ARMTEST\' -LogType 'Error'
        Description
        -----------
        Merges error logs from all Queued templates into one log.
        Saves the log in 'D:\ARMTEST\'

    .EXAMPLE
        Merge-ARMTemplateLog -OutputPath 'D:\ARMTEST\' -LogType 'Success'
        Description
        -----------
        Merges success logs from all Successfull templates into one log.
        Saves the log in 'D:\ARMTEST\'

    .EXAMPLE
        Merge-ARMTemplateLog -OutputPath 'D:\ARMTEST\' -LogType 'Success' -InformationAction Continue
        Description
        -----------
        Merges error logs from all Queued templates into one log.
        Saves the log in 'D:\ARMTEST\'
        Shows detailed output information

    .EXAMPLE
        Merge-ARMTemplateLog -OutputPath 'D:\ARMTEST\' -LogType 'Error' -InformationAction Continue
        Description
        -----------
        Merges success logs from all Successfull templates into one log.
        Saves the log in 'D:\ARMTEST\'
        Shows detailed output information

    .OUTPUTS
        System.Management.Automation.PSCustomObject.
        Returns object with the path to the merged logged.
        If log was not merged because it didn't
        existed returns None.

#>
[CmdletBinding(DefaultParameterSetName='DefaultParameterSet')]
[OutputType([pscustomobject])]
param (
        [Parameter(ParameterSetName='DefaultParameterSet',Position=0,Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Container})]
        [string]
        $OutputPath,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=1,Mandatory=$true)]
        [ValidateSet('Error','Success')]
        [string]
        $LogType
        )
    
    #region Initial Setup
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'


    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting merging: ' + $LogType + ' log'
    Write-Verbose `
        -Message $VerboseMessage 


    # Set variables
    $MergedLogName = 'Full'
    $FullLogObj = @()
    
    # If Error log is merged
    If ($LogType -eq 'Error')
    {
        $ResultFolder = 'Queued'
        $LogName = 'ErrorLog.json'
    }
    # If Success log is merged
    Elseif ($LogType -eq 'Success')
    {
        $ResultFolder = 'Successful'
        $LogName = 'SuccessLog.json'
    }


    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $ResultFolder is: ' + $ResultFolder
    Write-Verbose `
        -Message $VerboseMessage 



    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $LogName is: ' + $LogName
    Write-Verbose `
        -Message $VerboseMessage 

    
    $LogTempaltesFolder = $OutputPath.TrimEnd('\') + '\' + $ResultFolder


    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $LogTempaltesFolder is: ' + $LogTempaltesFolder
    Write-Verbose `
        -Message $VerboseMessage 

    #endregion
    
    #region Merge log
    # Check if such folder exists
    If ((Test-Path -Path $LogTempaltesFolder) -eq $true)
    {
        # Get array of names of the templates by using
        # the folder structure for Queued or Successful
        $ARMTemplatesArray = Get-ChildItem `
                                -Path $LogTempaltesFolder `
                                -Directory `
                                -ErrorAction Stop | `
                                Select-Object `
                                    -ExpandProperty Name `
                                    -ErrorAction Stop

        # Iterate trough every ARM template name
        foreach ($ARMTemplateFolderName in $ARMTemplatesArray)
        {
            Try
            {
                $ARMLogPath = $LogTempaltesFolder + '\' + $ARMTemplateFolderName + '\' + $LogName
                

                $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting to read log : ' + $ARMLogPath
                Write-Verbose `
                    -Message $VerboseMessage 


                # Read and add log into array
                $FullLogObj += Get-Content `
                                -Path $ARMLogPath `
                                -Force `
                                -ErrorAction Stop | `
                                ConvertFrom-Json `
                                -ErrorAction Stop


                $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Finished reading log : ' + $ARMLogPath
                Write-Verbose `
                    -Message $VerboseMessage 

            }
            Catch
            {
                $ErrorMessage = 'Failed to read log ' + $ARMLogPath
                $ErrorMessage += " `n"
                $ErrorMessage += 'Error: '
                $ErrorMessage += $_
                Write-Error `
                    -Message $ErrorMessage `
                    -ErrorAction Stop
            }    
        
        }

        $FullLogPath = $OutputPath.TrimEnd('\') + '\' + $MergedLogName + $LogName
    
        # Convert log to JSON and write it into file
        Try
        {

            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Starting to save log  : ' + $FullLogPath
            Write-Verbose `
                -Message $VerboseMessage 


            # Convert and save log
            $FullLogObj | `
                ConvertTo-Json `
                    -Depth 20 `
                    -ErrorAction Stop | `
                Out-File `
                    -FilePath $FullLogPath `
                    -Encoding unicode `
                    -Force `
                    -ErrorAction Stop
            
            #region Information
            $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Merged ' + $LogType + ' log. ' + $LogType + ' summarized log location: ' + $FullLogPath
            Write-Information `
                -MessageData $InformationMessage
            #endregion
            

            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Finished saving log  : ' + $FullLogPath
            Write-Verbose `
                -Message $VerboseMessage 

            
            $OutputResult = `
                [pscustomobject]@{'LogPath' = $FullLogPath}
        }
        Catch
        {
            $ErrorMessage = 'Failed to save log ' + $FullLogPath
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error `
                -Message $ErrorMessage `
                -ErrorAction Stop
        }
        
    }
    Else
    {

        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Folder does not exists: ' + $LogTempaltesFolder
        Write-Verbose `
            -Message $VerboseMessage 


        $OutputResult = `
                [pscustomobject]@{'LogPath' = 'None'}
    }
    #endregion

    return $OutputResult
    
}
Function Export-ARMTemplateLogToCSV {
<#

    .SYNOPSIS
        Formats and exports the most important data 
        of Error log to CSV report in table format.

    .DESCRIPTION
        Formats and exports the most important data 
        of Error log to CSV report in table format.

    .PARAMETER  FullLogPath
        Mandatory parameter. The JSON log is located.
        Example: D:\ARMTEST\FullErrorLog.json

    .PARAMETER  OutputPath
        Mandatory parameter. The output path
        where the report will be created.

    .PARAMETER  LogType
        Mandatory parameter.Acceptable value
        is Error. The value designates
        what type of log will be formated
        and exported.

    .EXAMPLE
        Export-ARMTemplateLogToCSV -FullLogPath 'D:\ARMTEST\FullErrorLog.json' -OutputPath 'D:\ARMTEST\' -LogType Error
        Description
        -----------
        Reads the json error log and generates CSV report on it so it will represent the most important data into table format.
        Saves the log in 'D:\ARMTEST\'

    .OUTPUTS
        System.Management.Automation.PSCustomObject.
        Returns object with the path to the report.

#>
[CmdletBinding(DefaultParameterSetName='DefaultParameterSet')]
[OutputType([pscustomobject])]
param (
        [Parameter(ParameterSetName='DefaultParameterSet',Position=0,Mandatory=$true)]
        [string]
        $FullLogPath,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=1,Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Container})]
        [string]
        $OutputPath,

        [Parameter(ParameterSetName='DefaultParameterSet',Position=2,Mandatory=$true)]
        [ValidateSet('Error')]
        [string]
        $LogType
        )

    #region Initial Setup
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'
    
    $CSVLogs = @()

    $OutputPath = $OutputPath.TrimEnd('\')

    $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Variable $LogType is: ' + $LogType
    Write-Verbose `
          -Message $VerboseMessage 
    #endregion

    #region Check File existance
    If ((Test-Path -Path $FullLogPath) -eq $true)
    {
        #region Read JSON
        Try
        {
            $Logsobj = Get-Content `
                            -Path $FullLogPath `
                            -Force -ErrorAction Stop | `
                            ConvertFrom-Json `
                                -ErrorAction Stop
        }
        Catch
        {
            $ErrorMessage = 'Failed to read json file ' + $FullLogPath
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error `
                -Message $ErrorMessage `
                -ErrorAction Stop
        }
        #endregion

        #region LogType Error
        if ($LogType -eq 'Error') 
        {
            Try 
            {
                $LogName = 'ErrorReport.csv'
                Foreach ($log in $Logsobj) 
                {
                    foreach ($FailedResource in $log.'Failed Resources')
                    {
                        If ([string]::IsNullOrEmpty($FailedResource.'Status Code') -eq $false)
                        {
                            $StatusCode = $FailedResource.'Status Code'.ToString()
                        }
                        Else
                        {
                            $StatusCode= 'N/A'
                        }

                        If ([string]::IsNullOrEmpty($FailedResource.'Error Code') -eq $false)
                        {
                            $ErrorCode = $FailedResource.'Error Code'.ToString()
                        }
                        Else
                        {
                            $ErrorCode = 'N/A'
                        }

                        If ([string]::IsNullOrEmpty($FailedResource.'Error Message') -eq $false)
                        {
                            $ErrorMessage = $FailedResource.'Error Message'.Tostring().replace("`n",' ').replace("`r",' ')
                        }
                        Else
                        {
                            $ErrorMessage = 'N/A'
                        }

                        If ([string]::IsNullOrEmpty($FailedResource.'Target Resource Type') -eq $false)
                        {
                            $TargetResourceType = $FailedResource.'Target Resource Type'.ToString()
                        }
                        Else
                        {
                            $TargetResourceType = 'N/A'
                        }
                        
                        $CSVLog = `
                            [pscustomobject]@{'Resource Group Name'  = $log.'Resource Group Name';
                                              'Provisioning State'   = $FailedResource.'Provisioning State';
                                              'Status Code'          = $StatusCode;
                                              'Error Code'           = $ErrorCode;
                                              'Error Message'        = $ErrorMessage ;
                                              'Target Resource Type' = $TargetResourceType}
                        
                        $CSVLogs+= $CSVLog
                    }
                }
            }
            Catch
            {
                $ErrorMessage = 'Failed to format Error log.'
                $ErrorMessage += " `n"
                $ErrorMessage += 'Error: '
                $ErrorMessage += $_
                Write-Error `
                    -Message $ErrorMessage `
                    -ErrorAction Stop
            }
        }
        #endregion

        #region Export to CSV
        Try
        {
            $CSVFullPath = $OutputPath + '\' + $LogName
            $CSVLogs | Export-Csv `
                        -NoTypeInformation `
                        -Path $CSVFullPath `
                        -Delimiter '|' `
                        -Encoding Unicode `
                        -Force `
                        -ErrorAction Stop
        }
        Catch
        {
            $ErrorMessage = 'Failed to export file ' + $CSVFullPath
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error `
                -Message $ErrorMessage `
                -ErrorAction Stop
        }
        #endregion

        #region Output
        $ReportOutput = `
             [pscustomobject]@{'Report Path' = $CSVFullPath}

        #endregion
    }
    Else
    {
        $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - File does not exists: ' + $FullLogPath
        Write-Verbose `
            -Message $VerboseMessage 


        $ReportOutput = `
                [pscustomobject]@{'Report Path' = 'None'}
    }
    #endregion
    

    return $ReportOutput

}
Function Test-ARMTemplate {
<#

    .SYNOPSIS
        Tests ARM Template.

    .DESCRIPTION
        Tests ARM Template. Downloads master archive with
        ARM Templates from GitHub repository and expands it 
        or takes local path with ARM templates. Templates in
        both location needs to be organized in folders where
        every folder is a name for ARM template. Every ARM 
        Template folder must contain azuredeploy.json and
        azuredeploy.parameters.json files. Logins to Azure
        with user credentials either by Azure Subscribtion ID
        or Azure Tenant ID. Creates Azure Resource Group 
        with the name of the ARM Template. Finds paramaters
        in azuredeploy.json and azuredeploy.parameters.json'
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

    .PARAMETER  ARMTemplateName
        Optional parameter. ARM Template Name or array of
        ARM Template Names.
        Example 101-application-gateway-create, 
        101-application-gateway-public-ip.

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST'
        Description
        -----------
        Login by Subscription ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds the ARM templates from GitHub Master repository
        Deploys all ARM Templates in the repository to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST'
        Description
        -----------
        Login by Subscription ID.
        Deploys all ARM Templates located in 'D:\ARMTEST\Downloaded' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create'
        Description
        -----------
        Login by Subscription ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds ARM template '101-application-gateway-create' from GitHub Master repository
        Deploys ARM Template '101-application-gateway-create' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create'
        Description
        -----------
        Login by Subscription ID.
        Deploys ARM Template '101-application-gateway-create' from 'D:\ARMTEST\Downloaded' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip'
        Description
        -----------
        Login by Subscription ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds ARM template '101-application-gateway-create' and '101-application-gateway-public-ip' from GitHub Master repository
        Deploys ARM Template '101-application-gateway-create' and '101-application-gateway-public-ip' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip'
        Description
        -----------
        Login by Subscription ID.
        Deploys ARM Template '101-application-gateway-create' and '101-application-gateway-public-ip' from 'D:\ARMTEST\Downloaded' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST'
        Description
        -----------
        Login by Tenant ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds the ARM templates from GitHub Master repository
        Deploys all ARM Templates in the repository to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST'
        Description
        -----------
        Login by Tenant ID.
        Deploys all ARM Templates located in 'D:\ARMTEST\Downloaded' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create'
        Description
        -----------
        Login by Tenant ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds ARM template '101-application-gateway-create' from GitHub Master repository
        Deploys ARM Template '101-application-gateway-create' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create'
        Description
        -----------
        Login by Tenant ID.
        Deploys ARM Template '101-application-gateway-create' from 'D:\ARMTEST\Downloaded' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip'
        Description
        -----------
        Login by Tenant ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds ARM template '101-application-gateway-create' and '101-application-gateway-public-ip' from GitHub Master repository
        Deploys ARM Template '101-application-gateway-create' and '101-application-gateway-public-ip' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip'
        Description
        -----------
        Login by Tenant ID.
        Deploys ARM Template '101-application-gateway-create' and '101-application-gateway-public-ip' from 'D:\ARMTEST\Downloaded' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -InformationAction Continue
        Description
        -----------
        Login by Subscription ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds the ARM templates from GitHub Master repository
        Deploys all ARM Templates in the repository to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Shows detailed output information
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -InformationAction Continue
        Description
        -----------
        Login by Subscription ID.
        Deploys all ARM Templates located in 'D:\ARMTEST\Downloaded' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Shows detailed output information
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -InformationAction Continue
        Description
        -----------
        Login by Subscription ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds ARM template '101-application-gateway-create' from GitHub Master repository
        Deploys ARM Template '101-application-gateway-create' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Shows detailed output information
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -InformationAction Continue
        Description
        -----------
        Login by Subscription ID.
        Deploys ARM Template '101-application-gateway-create' from 'D:\ARMTEST\Downloaded' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Shows detailed output information
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -InformationAction Continue
        Description
        -----------
        Login by Subscription ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds ARM template '101-application-gateway-create' and '101-application-gateway-public-ip' from GitHub Master repository
        Deploys ARM Template '101-application-gateway-create' and '101-application-gateway-public-ip' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Shows detailed output information
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -InformationAction Continue
        Description
        -----------
        Login by Subscription ID.
        Deploys ARM Template '101-application-gateway-create' and '101-application-gateway-public-ip' from 'D:\ARMTEST\Downloaded' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Shows detailed output information
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -InformationAction Continue
        Description
        -----------
        Login by Tenant ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds the ARM templates from GitHub Master repository
        Deploys all ARM Templates in the repository to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Shows detailed output information
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -InformationAction Continue
        Description
        -----------
        Login by Tenant ID.
        Deploys all ARM Templates located in 'D:\ARMTEST\Downloaded'
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Shows detailed output information
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -InformationAction Continue
        Description
        -----------
        Login by Tenant ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds ARM template '101-application-gateway-create' from GitHub Master repository
        Deploys ARM Template '101-application-gateway-create' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Shows detailed output information
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -InformationAction Continue
        Description
        -----------
        Login by Tenant ID.
        Deploys ARM Template '101-application-gateway-create' from 'D:\ARMTEST\Downloaded' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Shows detailed output information
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -InformationAction Continue
        Description
        -----------
        Login by Tenant ID.
        Downloads ARM Templates from GitHub Master Repository
        Exapnds ARM template '101-application-gateway-create' and '101-application-gateway-public-ip' from GitHub Master repository
        Deploys ARM Template '101-application-gateway-create' and '101-application-gateway-public-ip' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Shows detailed output information
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -InformationAction Continue
        Description
        -----------
        Login by Tenant ID.
        Deploys ARM Template '101-application-gateway-create' and '101-application-gateway-public-ip' from 'D:\ARMTEST\Downloaded' to 'North Europe' region
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        Shows detailed output information
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential

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
        [string[]]
        $ARMTemplateName
        )
    
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'
    
    #region Login
    If ([string]::IsNullOrEmpty($AzureTenantID) -eq $false)
    {
        Add-ARMTemplateLogin `
            -AzureTenantID $AzureTenantID `
            -AzureCredentials $AzureCredentials `
            -ErrorAction Stop | Out-Null
    }
    Else
    {
        Add-ARMTemplateLogin `
            -AzureSubscriptionID $AzureSubscriptionID `
            -AzureCredentials $AzureCredentials `
            -ErrorAction Stop | Out-Null
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
        $GitHubArchiveParms.Add('ARMTemplateName', $ARMTemplateName)
    }
    #endregion
    
    #region If there is no GitHub Repository do not perform extraction
    If ([string]::IsNullOrEmpty($GitHubRepositoryURL) -eq $false)
    {
        # Expand ARM Template or array of ARM Templates from GitHub master repository
        $GitHubArchiveParms.Add('OutputPath', $OutputPath)
        $GitHubArchiveParms.Add('GitHubMasterArchivePath', $OutputArchiveFile)

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
        $ARMTemplateName = Get-ChildItem `
                                -Path $ExtractLocation `
                                -Directory `
                                -ErrorAction Stop | `
                                Select-Object `
                                    -ExpandProperty Name `
                                    -ErrorAction Stop
    }
    #endregion
    
    # Null some counters
    $ARMTSucceeded = 0
    $ARMTFailed = 0
    $ARMTInvalid = 0
    $ARMTBadError = 0

    # Iterate trough every ARM template name
    foreach ($ARMTemplateFolderName in $ARMTemplateName)
    {
        #region Deploy ARM Template
        
        $ARMTemplateDeploymentParams = @{}
        If ([string]::IsNullOrEmpty($AzureTenantID) -eq $false)
        {
            $ARMTemplateDeploymentParams.Add('AzureTenantID', $AzureTenantID)
        }
        Else
        {
            $ARMTemplateDeploymentParams.Add('AzureSubscriptionID', $AzureSubscriptionID)
        }
        
        $ARMTemplateDeploymentParams.Add('ARMTemplateName', $ARMTemplateFolderName)
        $ARMTemplateDeploymentParams.Add('AzureRegion', $AzureRegion)
        $ARMTemplateDeploymentParams.Add('ARMTemplatesPath', $ExtractLocation)
        $ARMTemplateDeploymentParams.Add('OutputPath', $OutputPath)
        $ARMTemplateDeploymentParams.Add('AzureCredentials', $AzureCredentials)

        $ARMTemplateDeploymentResults = New-ARMTemplateDeployment `
                                        -ErrorAction Stop `
                                        @ARMTemplateDeploymentParams
        # Increment
        $ARMTSucceeded += $ARMTemplateDeploymentResults.Succeeded
        $ARMTFailed    += $ARMTemplateDeploymentResults.Failed
        $ARMTInvalid   += $ARMTemplateDeploymentResults.Invalid
        $ARMTBadError  += $ARMTemplateDeploymentResults.BadError

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
Export-ModuleMember -Function Remove-ARMTemplateDeployment,Write-ARMTemplateLog,Move-ARMTemplateFolder,New-ARMTemplateDeployment,Get-GitHubRepositoryMasterArchive,Expand-GitHubMasterArchive,Merge-ARMTemplateLog,Test-ARMTemplate,Add-ARMTemplateLogin,Set-ARMTemplateParameterFile,Set-ARMTemplateFile,Export-ARMTemplateLogToCSV