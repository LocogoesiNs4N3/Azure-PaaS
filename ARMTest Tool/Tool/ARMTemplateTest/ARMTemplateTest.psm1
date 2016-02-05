function Get-ARMTemplateRandomAppName {
<#

    .SYNOPSIS
        Generates random App name.

    .DESCRIPTION
        Generates random App name.

    .PARAMETER  Length
        Mandatory parameter. Specify how many
        characters the returned string should
        contain.

    .EXAMPLE
        Get-ARMTemplateRandomAppName -Length 10
        Description
        -----------
        Generates random App name with 10 characters

    .OUTPUTS
        System.String.
        Returns string of small letters.

#>
[CmdletBinding(DefaultParameterSetName='DefaultParameterSet')]
[OutputType([string])]
param (
        [Parameter(ParameterSetName='DefaultParameterSet',Position=0,Mandatory=$true)]
        [int]
        $Length
    )
    
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'

    $charSetLetters = 'abcdefghijklmnopqrstuvwxyz'.ToCharArray()
    $FirstLetter= [String]::Join('', (1..$Length | % { $charSetLetters | Get-Random -ErrorAction Stop }))
    $AllString = $FirstLetter

    return $AllString
}
function Get-ARMTemplateRandomUserName {
<#

    .SYNOPSIS
        Generates random User name.

    .DESCRIPTION
        Generates random User name.

    .PARAMETER  Length
        Mandatory parameter. Specify how many
        characters the returned string should
        contain.

    .EXAMPLE
        Get-ARMTemplateRandomUserName -Length 10
        Description
        -----------
        Generates random DNS Label with 10 characters

    .OUTPUTS
        System.String.
        Returns string of small numbers and letters.

#>
[CmdletBinding(DefaultParameterSetName='DefaultParameterSet')]
[OutputType([string])]
param (
        [Parameter(ParameterSetName='DefaultParameterSet',Position=0,Mandatory=$true)]
        [int]
        $Length
    )
    
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'

    $Length =$Length-4
    $charSet = 'abcdefghijklmnopqrstuvwxyz'.ToCharArray()
    $RandomString=[String]::Join('', (1..$Length | % { $charSet | Get-Random -ErrorAction Stop }))
    $AllString = 'user' + $RandomString

    return $AllString
}
function Get-ARMTemplateRandomVMName {
<#

    .SYNOPSIS
        Generates random VM name.

    .DESCRIPTION
        Generates random VM name.

    .PARAMETER  Length
        Mandatory parameter. Specify how many
        characters the returned string should
        contain.

    .EXAMPLE
        Get-ARMTemplateRandomVMName -Length 8
        Description
        -----------
        Generates random VMName with 8 characters

    .OUTPUTS
        System.String.
        Returns string of small letters.

#>
[CmdletBinding(DefaultParameterSetName='DefaultParameterSet')]
[OutputType([string])]
param (
        [Parameter(ParameterSetName='DefaultParameterSet',Position=0,Mandatory=$true)]
        [int]
        $Length
    )
    
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'

    $charSetLetters = 'abcdefghijklmnopqrstuvwxyz'.ToCharArray()
    $FirstLetter= [String]::Join('', (1..$Length | % { $charSetLetters | Get-Random -ErrorAction Stop }))
    $AllString = $FirstLetter

    return $AllString
}
function Get-ARMTemplateSSHPublicKeyData {
<#

    .SYNOPSIS
        Gets valid SSH Public Key string.

    .DESCRIPTION
        Gets valid SSH Public Key string.

    .EXAMPLE
        Get-ARMTemplateSSHPublicKeyData
        Description
        -----------
        Gets valid SSH Public Key string.

    .OUTPUTS
        System.String.
        Returns string of valid sshk public key.

#>
[CmdletBinding()]
[OutputType([string])]
param (
    )    
    
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'
    $PublicKeyFilePath = Join-Path $PSScriptRoot 'id_rsa.pub'

    $SSHKeyData = (Get-Content -Path $PublicKeyFilePath -Encoding UTF8 -ErrorAction Stop).ToString()

    return $SSHKeyData

}
function Get-ARMTemplateRandomStorageAccountName {
<#

    .SYNOPSIS
        Generates random Storage Account Name.

    .DESCRIPTION
        Generates random Storage Account Name.

    .PARAMETER  Length
        Mandatory parameter. SPecify how many
        characters the returned string should
        contain.

    .EXAMPLE
        Get-ARMTemplateRandomStorageAccountName -Length 10
        Description
        -----------
        Generates random account name with 10 characters

    .OUTPUTS
        System.String.
        Returns string of small numbers and letters.

#>
[CmdletBinding(DefaultParameterSetName='DefaultParameterSet')]
[OutputType([string])]
param (
        [Parameter(ParameterSetName='DefaultParameterSet',Position=0,Mandatory=$true)]
        [int]
        $Length
    )
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'

    $Length =$Length-1
    $charSet = 'abcdefghijklmnopqrstuvwxyz0123456789'.ToCharArray()
    $charSetLetters = 'abcdefghijklmnopqrstuvwxyz'.ToCharArray()
    $RandomString=[String]::Join('', (1..$Length | % { $charSet | Get-Random -ErrorAction Stop }))
    $FirstLetter= [String]::Join('', (1..1 | % { $charSetLetters | Get-Random -ErrorAction Stop }))
    $AllString = $FirstLetter + $RandomString

    return $AllString 

}
function Get-ARMTemplateRandomDNSLabel {
<#

    .SYNOPSIS
        Generates random DNS Label name.

    .DESCRIPTION
        Generates random DNS Label name.

    .PARAMETER  Length
        Mandatory parameter. SPecify how many
        characters the returned string should
        contain.

    .EXAMPLE
        Get-ARMTemplateRandomDNSLabel -Length 10
        Description
        -----------
        Generates random DNS Label with 10 characters

    .OUTPUTS
        System.String.
        Returns string of small numbers and letters.

#>
[CmdletBinding(DefaultParameterSetName='DefaultParameterSet')]
[OutputType([string])]
param (
        [Parameter(ParameterSetName='DefaultParameterSet',Position=0,Mandatory=$true)]
        [int]
        $Length
    )
    
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'

    $Length =$Length-1
    $charSet = 'abcdefghijklmnopqrstuvwxyz0123456789'.ToCharArray()
    $charSetLetters = 'abcdefghijklmnopqrstuvwxyz'.ToCharArray()
    $RandomString=[String]::Join('', (1..$Length | % { $charSet | Get-Random -ErrorAction Stop }))
    $FirstLetter= [String]::Join('', (1..1 | % { $charSetLetters | Get-Random -ErrorAction Stop }))
    $AllString = $FirstLetter + $RandomString

    return $AllString
}
function Get-ARMTemplateRandomPassword {
<#

    .SYNOPSIS
        Generates random complex password.

    .DESCRIPTION
        Generates random complex password.

    .PARAMETER  Length
        Mandatory parameter. Specify how many
        characters the returned string should
        contain. Minimum is 8.

    .EXAMPLE
        Get-ARMTemplateRandomPassword -Length 10
        Description
        -----------
        Generates random complex password with 10 characters

    .OUTPUTS
        System.String.
        Returns string of small numbers and letters.

#>
[CmdletBinding(DefaultParameterSetName='DefaultParameterSet')]
[OutputType([string])]
param (
        [Parameter(ParameterSetName='DefaultParameterSet',Position=0,Mandatory=$true)]
        [ValidateRange(8,20)]
        [int]
        $Length
    )

    # Set Error Preference	
	$ErrorActionPreference = 'Stop'
    function Get-RandomPassword {
	    param(
		        $length = 10,
		        $characters = 
                    'abcdefghkmnprstuvwxyzABCDEFGHKLMNPRSTUVWXYZ123456789!"§$%&/()=?*+#_'
	        )
	    # Set Error Preference	
	    $ErrorActionPreference = 'Stop'
        $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length }
	    $private:ofs=''
	    [String]$characters[$random]
    }
    function Get-RandomText {
	    param(
		        $text
	        )
	    
        # Set Error Preference	
	    $ErrorActionPreference = 'Stop'
        $textlenght = $text.length-1
	    $indizes = Get-Random -InputObject (0..$textlenght) -Count $textlenght 
	
	    $private:ofs=''
	    [String]$text[$indizes]
    }
    
    $cLength = $Length-5
    
    $pass = Get-RandomPassword -length $cLength -characters 'abcdefghiklmnprstuvwxyz'
	$pass += Get-RandomPassword -length 2 -characters '!_$#*+)'
	$pass += Get-RandomPassword -length 2 -characters '0123456789'
	$pass += Get-RandomPassword -length 2 -characters 'ABCDEFGHKLMNPRSTUVWXYZ'
	
	$complexPassword = Get-RandomText $pass

    return $complexPassword
}
Function Add-ARMTemplateLogin {
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
        Changes Location, StorageAccountName,
        StorageAccountNamePrefix, DNSLabel,
        Password, SSHKeyData, VMName, UserName, AppName
        parameter in ARM Template json parameters file.

    .DESCRIPTION
        Changes Location, StorageAccountName,
        StorageAccountNamePrefix, DNSLabel,
        Password, SSHKeyData, VMName, UserName, AppName
        parameter in ARM Template json parameters file.

    .PARAMETER  ARMTemplateParameterFile
        Location to azuredeploy.parameters.json file.

    .PARAMETER  SetType
        Type of paramater to be searched and replaced 
        if found. Valid values are Location, 
        StorageAccountName, StorageAccountNamePrefix,
        DNSLabel or Password.
        If value Location is chosen the function will
        search parameters with names that match the words
        'location' or 'region'. When found the value for those
        paramaters will be replaced with the value from 
        AzureRegion.
        If value StorageAccountName is chosen the function
        searchs paramteres with names that match the word
        'StorageAccountName'. Will also search for exact
        parameters named 'storageAccount', 'newStorageAccount'
        and 'storageName'. When found the value for those
        paramaters will be replace with random string
        for Storage Account Name.
        If value StorageAccountNamePrefix is chosen 
        the function searchs paramteres with names 
        that match the word 'StorageAccountNamePrefix'.
        Will also search for exact parameters named 
        'storageAccountPrefix' and'AccountPrefix'.
        When found the value for those paramaters 
        will be replace with random string of 5
        characters.
        If value DNSLabel is chosen  the function 
        searchs paramteres with names that match 
        the words 'dnsLabel', 'dnsName', 'DnsPrefix'
        or 'PublicIPName'. Will also search for exact 
        parameter named 'publicIPAddressName' or
        'endpointName'. When found the value for 
        those paramaters will be replace with random 
        string of 12 characters.
        If value Password is chosen  the function 
        searchs paramteres with names that match 
        the word 'Password'. When found the value 
        for those paramaters will be replace with 
        random complex password of 10 characters.
        If value SSHKeyData is chosen  the function 
        searchs paramteres with names that match 
        the exact words 'sshPublicKey' and 'sshKeyData'. 
        When found the value for those paramaters will 
        be replace with valid SSH RSA Public Key string.
        If value VMName is chosen  the function 
        searchs paramteres with names that match 
        the words 'vmName', 'clusterName', 'ServerName'
        and 'vmssName'. When found the value 
        for those paramaters will be replace with 
        random string of 8 characters that are only
        small letters.
        If value UserName is chosen  the function 
        searchs paramteres with names that match 
        the word 'Username' or 'databaseAccountName'. 
        Will also search for parameter exactly named 
        'administratorLogin'. When found the value 
        for those paramaters will be replace with 
        random string of 8 characters that starts 
        with user prefix.
        If value AppName is chosen  the function 
        searchs paramteres with names that match 
        the word 'AppName' or 'PlanName'. When 
        found the value for those paramaters will 
        be replace with random string of 8 characters.

    .PARAMETER  AzureRegion
        Valid Azure region value. This paramater
        is needed if SetType is location.

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateParameterFile $path -SetType 'StorageAccountName'
        Description
        -----------
        Find parameter of type 'StorageAccountName' in ARM Template paramaters' file and replace the value for
        that parameter with random string

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.parameters.json'

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateParameterFile $path -SetType 'VMName'
        Description
        -----------
        Find parameter of type 'VMName' in ARM Template paramaters' file and replace the value for
        that parameter with random string of 8 characters

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.parameters.json'

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateParameterFile $path -SetType 'AppName'
        Description
        -----------
        Find parameter of type 'AppName' in ARM Template paramaters' file and replace the value for
        that parameter with random string of 8 characters

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.parameters.json'

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateParameterFile $path -SetType 'UserName'
        Description
        -----------
        Find parameter of type 'UserName' in ARM Template paramaters' file and replace the value for
        that parameter with random string of 8 characters that starts with user prefix.

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.parameters.json'

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateParameterFile $path -SetType 'SSHKeyData'
        Description
        -----------
        Find parameter of type 'SSHKeyData' in ARM Template paramaters' file and replace the value for
        that parameter with valid SSH public key.

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.parameters.json'

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateParameterFile $path -SetType 'Password'
        Description
        -----------
        Find parameter of type 'Password' in ARM Template paramaters' file and replace the value for
        that parameter with random complex password

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.parameters.json'

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateParameterFile $path -SetType 'StorageAccountNamePrefix'
        Description
        -----------
        Find parameter of type 'StorageAccountNamePrefix' in ARM Template paramaters' file and replace the value for
        that parameter with random string

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.parameters.json'

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateParameterFile $path -SetType 'DNSLabel'
        Description
        -----------
        Find parameter of type 'DNSLabel' in ARM Template paramaters' file and replace the value for
        that parameter with random string

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.parameters.json'

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
        [ValidateSet('Location','StorageAccountName','StorageAccountNamePrefix','DNSLabel','Password','SSHKeyData','VMName','UserName','AppName')]
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
    #endregion

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

        
        #region SetType Location
        If ($SetType -eq 'Location') 
        {
            Try
            {
                #region Location Keywords
                $LocationKeywords = @('location','region')
                $ResourceGroupLocation = $AzureRegion

                # Go trough every keyword
                foreach ($LocationKeyword in $LocationKeywords)
                {
                    If ($ParamFileObj.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    Else
                    {
                        $ParameterNames = $ParamFileObj | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                                Get-Member `
                                                    -ErrorAction Stop | `
                                                Where-Object MemberType -EQ NoteProperty `
                                                    -ErrorAction Stop | `
                                                Select-Object -ExpandProperty Name `
                                                    -ErrorAction Stop
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        If ($ParameterName -match $LocationKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $LocationKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.($ParameterName).Value)
                            {
                                If (($ParamFileObj.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.($ParameterName).Value)
                                    {
                                        $ParamFileObj.($ParameterName).Value[$ValueCount] = $ResourceGroupLocation
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    $ParamFileObj.($ParameterName).Value = $ResourceGroupLocation
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.($ParameterName).Value)
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
                            If ($null -ne $ParamFileObj.parameters.parameters.($ParameterName).Value)
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
                #endregion
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

        #region SetType StorageAccountName
        If ($SetType -eq 'StorageAccountName') 
        {
            Try
            {
                #region Storage Account Name Keywords
                $StorageAccountNameKeywords = @('StorageAccountName')

                # Go trough every keyword
                foreach ($StorageAccountNameKeyword in $StorageAccountNameKeywords)
                {
                    If ($ParamFileObj.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters | `
                                                Get-Member `
                                                    -ErrorAction Stop | `
                                                Where-Object MemberType -EQ NoteProperty `
                                                    -ErrorAction Stop | `
                                                Select-Object -ExpandProperty Name `
                                                    -ErrorAction Stop
                    }
                    Else
                    {
                        $ParameterNames = $ParamFileObj | `
                                                Get-Member `
                                                    -ErrorAction Stop | `
                                                Where-Object MemberType -EQ NoteProperty `
                                                    -ErrorAction Stop | `
                                                Select-Object -ExpandProperty Name `
                                                    -ErrorAction Stop
                    }
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                            Get-Member  `
                                                -ErrorAction Stop| `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        If ($ParameterName -match $StorageAccountNameKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $StorageAccountNameKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.($ParameterName).Value)
                            {
                                If (($ParamFileObj.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                                -Length 10 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.($ParameterName).Value[$ValueCount] = $StorageAccountName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 10 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.($ParameterName).Value = $StorageAccountName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                                -Length 10 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.($ParameterName).Value[$ValueCount] = $StorageAccountName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 10 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.($ParameterName).Value = $StorageAccountName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                                -Length 10 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.parameters.($ParameterName).Value[$ValueCount] = $StorageAccountName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 10 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.parameters.($ParameterName).Value = $StorageAccountName
                                    $ParamFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion

                #region Exact Storage Account Name Keywords
                $ExactStorageAccountNameKeywords = @('storageName','newStorageAccount','storageAccount')
                
                # Go trough every keyword 
                foreach ($ExactStorageAccountNameKeyword in $ExactStorageAccountNameKeywords)
                {
                    If ($ParamFileObj.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    Else
                    {
                        $ParameterNames = $ParamFileObj | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    
                    }
                    
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        If ($ParameterName -eq $ExactStorageAccountNameKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword exact match: ' + $ExactStorageAccountNameKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.($ParameterName).Value)
                            {
                                If (($ParamFileObj.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                                -Length 10 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.($ParameterName).Value[$ValueCount] = $StorageAccountName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 10 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.($ParameterName).Value = $StorageAccountName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                                -Length 10 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.($ParameterName).Value[$ValueCount] = $StorageAccountName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 10 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.($ParameterName).Value = $StorageAccountName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                                -Length 10 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.parameters.($ParameterName).Value[$ValueCount] = $StorageAccountName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 10 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.parameters.($ParameterName).Value = $StorageAccountName
                                    $ParamFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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

        #region SetType StorageAccountNamePrefix
        If ($SetType -eq 'StorageAccountNamePrefix') 
        {
            Try
            {
                #region Storage Account Name Prefix Keywords
                $StorageAccountNamePrefixKeywords = @('StorageAccountNamePrefix')

                # Go trough every keyword
                foreach ($StorageAccountNamePrefixKeyword in $StorageAccountNamePrefixKeywords)
                {
                    If ($ParamFileObj.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    Else
                    {
                        $ParameterNames = $ParamFileObj | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        If ($ParameterName -match $StorageAccountNamePrefixKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $StorageAccountNamePrefixKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.($ParameterName).Value)
                            {
                                If (($ParamFileObj.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                                -Length 5 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.($ParameterName).Value[$ValueCount] = $StorageAccountName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 5 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.($ParameterName).Value = $StorageAccountName
                                    $ParamFileObjChanged = $true
                                }
                            }
                            
                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                                -Length 5 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.($ParameterName).Value[$ValueCount] = $StorageAccountName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 5 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.($ParameterName).Value = $StorageAccountName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                                -Length 5 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.parameters.($ParameterName).Value[$ValueCount] = $StorageAccountName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 5 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.parameters.($ParameterName).Value = $StorageAccountName
                                    $ParamFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion

                #region Exact Storage Account Name Prefix Keywords
                $ExactStorageAccountNamePrefixKeywords = @('storageAccountPrefix','accountPrefix')

                # Go trough every keyword
                foreach ($ExactStorageAccountNamePrefixKeyword in $ExactStorageAccountNamePrefixKeywords)
                {
                    If ($ParamFileObj.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    Else
                    {
                        $ParameterNames = $ParamFileObj | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        If ($ParameterName -eq $ExactStorageAccountNamePrefixKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword exact match: ' + $ExactStorageAccountNamePrefixKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage
                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.($ParameterName).Value)
                            {
                                If (($ParamFileObj.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                                -Length 5 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.($ParameterName).Value[$ValueCount] = $StorageAccountName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 5 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.($ParameterName).Value = $StorageAccountName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                                -Length 5 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.($ParameterName).Value[$ValueCount] = $StorageAccountName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 5 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.($ParameterName).Value = $StorageAccountName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                                -Length 5 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.parameters.($ParameterName).Value[$ValueCount] = $StorageAccountName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 5 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.parameters.($ParameterName).Value = $StorageAccountName
                                    $ParamFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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
        
        #region SetType DNSLabel
        If ($SetType -eq 'DNSLabel') 
        {
            Try
            {
                #region DNS Label Keywords
                $DNSLabelKeywords = @('dnsLabel','dnsName','dnsPrefix','PublicIPName')

                # Go trough every keyword
                foreach ($DNSLabelKeyword in $DNSLabelKeywords)
                {
                    If ($ParamFileObj.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    Else
                    {
                        $ParameterNames = $ParamFileObj | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        If ($ParameterName -match $DNSLabelKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $DNSLabelKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage
                            
                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.($ParameterName).Value)
                            {
                                If (($ParamFileObj.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                                -Length 12 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.($ParameterName).Value[$ValueCount] = $DNSLabelName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                            -Length 12 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.($ParameterName).Value = $DNSLabelName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                                -Length 12 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.($ParameterName).Value[$ValueCount] = $DNSLabelName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                            -Length 12 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.($ParameterName).Value = $DNSLabelName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                                -Length 12 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.parameters.($ParameterName).Value[$ValueCount] = $DNSLabelName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                            -Length 12 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.parameters.($ParameterName).Value = $DNSLabelName
                                    $ParamFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion

                #region Exact DNS Label Keywords
                $ExactDNSLabelKeywords = @('publicIPAddressName','endpointName')

                # Go trough every keyword
                foreach ($ExactDNSLabelKeyword in $ExactDNSLabelKeywords)
                {
                    If ($ParamFileObj.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    Else
                    {
                        $ParameterNames = $ParamFileObj | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        If ($ParameterName -eq $ExactDNSLabelKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword exact match: ' + $ExactDNSLabelKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.($ParameterName).Value)
                            {
                                If (($ParamFileObj.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                                -Length 12 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.($ParameterName).Value[$ValueCount] = $DNSLabelName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                            -Length 12 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.($ParameterName).Value = $DNSLabelName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                                -Length 12 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.($ParameterName).Value[$ValueCount] = $DNSLabelName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                            -Length 12 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.($ParameterName).Value = $DNSLabelName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                                -Length 12 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.parameters.($ParameterName).Value[$ValueCount] = $DNSLabelName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                            -Length 12 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.parameters.($ParameterName).Value = $DNSLabelName
                                    $ParamFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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

        #region SetType Password
        If ($SetType -eq 'Password') 
        {
            Try
            {
                #region DNS Label Keywords
                $PasswordKeywords = @('Password')

                # Go trough every keyword
                foreach ($PasswordKeyword in $PasswordKeywords)
                {
                    If ($ParamFileObj.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    Else
                    {
                        $ParameterNames = $ParamFileObj | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        If ($ParameterName -match $PasswordKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $PasswordKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.($ParameterName).Value)
                            {
                                If (($ParamFileObj.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $PasswordString = Get-ARMTemplateRandomPassword `
                                                                -Length 10 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.($ParameterName).Value[$ValueCount] = $PasswordString
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    
                                    # Set Value
                                    $PasswordString = Get-ARMTemplateRandomPassword `
                                                            -Length 10 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.($ParameterName).Value = $PasswordString
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $PasswordString = Get-ARMTemplateRandomPassword `
                                                                -Length 10 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.($ParameterName).Value[$ValueCount] = $PasswordString
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    
                                    # Set Value
                                    $PasswordString = Get-ARMTemplateRandomPassword `
                                                            -Length 10 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.($ParameterName).Value = $PasswordString
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $PasswordString = Get-ARMTemplateRandomPassword `
                                                                -Length 10 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.parameters.($ParameterName).Value[$ValueCount] = $PasswordString
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $PasswordString = Get-ARMTemplateRandomPassword `
                                                            -Length 10 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.parameters.($ParameterName).Value = $PasswordString
                                    $ParamFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion

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

        #region SetType SSHKeyData
        If ($SetType -eq 'SSHKeyData') 
        {
            Try
            {
                #region Exact SSH Key Data Keywords
                $ExactSSHKeyDataKeywords = @('sshKeyData','sshPublicKey')

                # Go trough every keyword
                foreach ($ExactSSHKeyDataKeyword in $ExactSSHKeyDataKeywords)
                {
                    If ($ParamFileObj.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    Else
                    {
                        $ParameterNames = $ParamFileObj | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        If ($ParameterName -eq $ExactSSHKeyDataKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword exact match: ' + $ExactSSHKeyDataKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage
                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.($ParameterName).Value)
                            {
                                If (($ParamFileObj.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $SSHPublicKeyString = Get-ARMTemplateSSHPublicKeyData `
                                                                -ErrorAction Stop
                                        $ParamFileObj.($ParameterName).Value[$ValueCount] = $SSHPublicKeyString
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $SSHPublicKeyString = Get-ARMTemplateSSHPublicKeyData `
                                                            -ErrorAction Stop
                                    $ParamFileObj.($ParameterName).Value = $SSHPublicKeyString
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $SSHPublicKeyString = Get-ARMTemplateSSHPublicKeyData `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.($ParameterName).Value[$ValueCount] = $SSHPublicKeyString
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $SSHPublicKeyString = Get-ARMTemplateSSHPublicKeyData `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.($ParameterName).Value = $SSHPublicKeyString
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $SSHPublicKeyString = Get-ARMTemplateSSHPublicKeyData `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.parameters.($ParameterName).Value[$ValueCount] = $SSHPublicKeyString
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $SSHPublicKeyString = Get-ARMTemplateSSHPublicKeyData `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.parameters.($ParameterName).Value = $SSHPublicKeyString
                                    $ParamFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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

        #region SetType VMName
        If ($SetType -eq 'VMName') 
        {
            Try
            {
                #region VM Name Keywords
                $VMNameKeywords = @('vmName','clusterName','vmssName','Servername')

                # Go trough every keyword
                foreach ($VMNameKeyword in $VMNameKeywords)
                {
                    If ($ParamFileObj.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    Else
                    {
                        $ParameterNames = $ParamFileObj | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        If ($ParameterName -match $VMNameKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $VMNameKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.($ParameterName).Value)
                            {
                                If (($ParamFileObj.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $VMName = Get-ARMTemplateRandomVMName `
                                                                -Length 8 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.($ParameterName).Value[$ValueCount] = $VMName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $VMName = Get-ARMTemplateRandomVMName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.($ParameterName).Value = $VMName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $VMName = Get-ARMTemplateRandomVMName `
                                                                -Length 8 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.($ParameterName).Value[$ValueCount] = $VMName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $VMName = Get-ARMTemplateRandomVMName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.($ParameterName).Value = $VMName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $VMName = Get-ARMTemplateRandomVMName `
                                                                -Length 8 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.parameters.($ParameterName).Value[$ValueCount] = $VMName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $VMName = Get-ARMTemplateRandomVMName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.parameters.($ParameterName).Value = $VMName
                                    $ParamFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion

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

        #region SetType UserName
        If ($SetType -eq 'UserName') 
        {
            Try
            {
                #region User Name Keywords
                $UserNameKeywords = @('Username','databaseAccountName')

                # Go trough every keyword
                foreach ($UserNameKeyword in $UserNameKeywords)
                {
                    If ($ParamFileObj.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    Else
                    {
                        $ParameterNames = $ParamFileObj | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        If ($ParameterName -match $UserNameKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $UserNameKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.($ParameterName).Value)
                            {
                                If (($ParamFileObj.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $RandomUserName = Get-ARMTemplateRandomUserName `
                                                                -Length 8 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.($ParameterName).Value[$ValueCount] = $RandomUserName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $RandomUserName = Get-ARMTemplateRandomUserName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.($ParameterName).Value = $RandomUserName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $RandomUserName = Get-ARMTemplateRandomUserName `
                                                                -Length 8 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.($ParameterName).Value[$ValueCount] = $RandomUserName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $RandomUserName = Get-ARMTemplateRandomUserName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.($ParameterName).Value = $RandomUserName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $RandomUserName = Get-ARMTemplateRandomUserName `
                                                                -Length 8 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.parameters.($ParameterName).Value[$ValueCount] = $RandomUserName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $RandomUserName = Get-ARMTemplateRandomUserName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.parameters.($ParameterName).Value = $RandomUserName
                                    $ParamFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion

                #region Exact User Name Keywords
                $ExactUserNameKeywords = @('administratorLogin')

                # Go trough every keyword
                foreach ($ExactUserNameKeyword in $ExactUserNameKeywords)
                {
                    If ($ParamFileObj.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    Else
                    {
                        $ParameterNames = $ParamFileObj | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        If ($ParameterName -eq $ExactUserNameKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword exact match: ' + $ExactUserNameKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.($ParameterName).Value)
                            {
                                If (($ParamFileObj.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $RandomUserName = Get-ARMTemplateRandomUserName `
                                                                -Length 8 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.($ParameterName).Value[$ValueCount] = $RandomUserName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $RandomUserName = Get-ARMTemplateRandomUserName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.($ParameterName).Value = $RandomUserName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $RandomUserName = Get-ARMTemplateRandomUserName `
                                                                -Length 8 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.($ParameterName).Value[$ValueCount] = $RandomUserName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $RandomUserName = Get-ARMTemplateRandomUserName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.($ParameterName).Value = $RandomUserName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $RandomUserName = Get-ARMTemplateRandomUserName `
                                                                -Length 8 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.parameters.($ParameterName).Value[$ValueCount] = $RandomUserName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $RandomUserName = Get-ARMTemplateRandomUserName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.parameters.($ParameterName).Value = $RandomUserName
                                    $ParamFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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

        #region SetType AppName
        If ($SetType -eq 'AppName') 
        {
            Try
            {
                #region App Name Keywords
                $AppNameKeywords = @('AppName','PlanName')

                # Go trough every keyword
                foreach ($AppNameKeyword in $AppNameKeywords)
                {
                    If ($ParamFileObj.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    Else
                    {
                        $ParameterNames = $ParamFileObj | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }
                    
                    
                    # Check for double parameters
                    If ($ParamFileObj.parameters.parameters)
                    {
                        $ParameterNames = $ParamFileObj.parameters.parameters | `
                                            Get-Member `
                                                -ErrorAction Stop | `
                                            Where-Object MemberType -EQ NoteProperty `
                                                -ErrorAction Stop | `
                                            Select-Object -ExpandProperty Name `
                                                -ErrorAction Stop
                    }

                    # Go trough every Parameter Name
                    foreach ($ParameterName in $ParameterNames)
                    {
                        If ($ParameterName -match $AppNameKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $AppNameKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.($ParameterName).Value)
                            {
                                If (($ParamFileObj.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $RandomAppName = Get-ARMTemplateRandomAppName `
                                                                -Length 8 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.($ParameterName).Value[$ValueCount] = $RandomAppName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $RandomAppName = Get-ARMTemplateRandomAppName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.($ParameterName).Value = $RandomAppName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $RandomAppName = Get-ARMTemplateRandomAppName `
                                                                -Length 8 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.($ParameterName).Value[$ValueCount] = $RandomAppName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $RandomAppName = Get-ARMTemplateRandomAppName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.($ParameterName).Value = $RandomAppName
                                    $ParamFileObjChanged = $true
                                }
                            }

                            # Check if there are multiple values
                            If ($null -ne $ParamFileObj.parameters.parameters.($ParameterName).Value)
                            {
                                If (($ParamFileObj.parameters.parameters.($ParameterName).Value.GetType() | Select-Object -ExpandProperty Name) -eq 'Object[]')
                                {
                                    $ValueCount = 0
                                    foreach ($PValue in $ParamFileObj.parameters.parameters.($ParameterName).Value)
                                    {
                                        # Set Value
                                        $RandomAppName = Get-ARMTemplateRandomAppName `
                                                                -Length 8 `
                                                                -ErrorAction Stop
                                        $ParamFileObj.parameters.parameters.($ParameterName).Value[$ValueCount] = $RandomAppName
                                        $ParamFileObjChanged = $true
                                        $ValueCount++
                                    }
                                }
                                Else
                                {
                                    # Set Value
                                    $RandomAppName = Get-ARMTemplateRandomAppName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $ParamFileObj.parameters.parameters.($ParameterName).Value = $RandomAppName
                                    $ParamFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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
            If ($ARMTemplateParameterFile -match 'modified')
            {
                $NewARMTemplateParamFilePath = $ARMTemplateParameterFile
            }
            If ($PSCmdlet.ShouldProcess("Saving $NewARMTemplateParamFilePath file.")) 
            {
                # Convert log to JSON and write it into file
                $ParamFileObj | `
                    ConvertTo-Json `
                        -Depth 10 `
                        -ErrorAction Stop | `
                    Out-File `
                        -FilePath $NewARMTemplateParamFilePath `
                        -Encoding utf8 `
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
        Changes location, StorageAccountName,
        StorageAccountNamePrefix, DNSLabel,
        Password, SSHKeyData, VMName, UserName or AppName
        parameter in ARM Template json file. Adds it to 
        allowedValues and sets it in  the defatulValue.

    .DESCRIPTION
        Changes location, StorageAccountName,
        StorageAccountNamePrefix, DNSLabel,
        Password, SSHKeyData, VMName, UserName or AppName
        parameter in ARM Template json file. Adds it to 
        allowedValues and sets it in  the defatulValue.

    .PARAMETER  ARMTemplateFile
        Location to azuredeploy.json file.

    .PARAMETER  SetType
         Type of paramater to be searched and replaced 
        if found. Valid values are Location, 
        StorageAccountName, StorageAccountNamePrefix,
        DNSLabel or Password.
        If value Location is chosen the function will
        search parameters with names that match the words
        'location' or 'region'. When found the value for those
        paramaters will be replaced with the value from 
        AzureRegion.
        If value StorageAccountName is chosen the function
        searchs paramteres with names that match the word
        'StorageAccountName'. Will also search for exact
        parameters named 'storageAccount', 'newStorageAccount'
        and 'storageName'. When found the value for those
        paramaters will be replace with random string
        for Storage Account Name.
        If value StorageAccountNamePrefix is chosen 
        the function searchs paramteres with names 
        that match the word 'StorageAccountNamePrefix'.
        Will also search for exact parameters named 
        'storageAccountPrefix' and'AccountPrefix'.
        When found the value for those paramaters 
        will be replace with random string of 5
        characters.
        If value DNSLabel is chosen  the function 
        searchs paramteres with names that match 
        the words 'dnsLabel', 'dnsName', 'DnsPrefix'
        or 'PublicIPName'. Will also search for exact 
        parameter named 'publicIPAddressName' or
        'endpointName'. When found the value for 
        those paramaters will be replace with random 
        string of 12 characters.
        If value Password is chosen  the function 
        searchs paramteres with names that match 
        the word 'Password'. When found the value 
        for those paramaters will be replace with 
        random complex password of 10 characters.
        If value SSHKeyData is chosen  the function 
        searchs paramteres with names that match 
        the exact words 'sshPublicKey' and 'sshKeyData'. 
        When found the value for those paramaters will 
        be replace with valid SSH RSA Public Key string.
        If value VMName is chosen  the function 
        searchs paramteres with names that match 
        the words 'vmName', 'clusterName', 'ServerName'
        and 'vmssName'. When found the value 
        for those paramaters will be replace with 
        random string of 8 characters that are only
        small letters.
        If value UserName is chosen  the function 
        searchs paramteres with names that match 
        the word 'Username' or 'databaseAccountName'. 
        Will also search for parameter exactly named 
        'administratorLogin'. When found the value 
        for those paramaters will be replace with 
        random string of 8 characters that starts 
        with user prefix.
        If value AppName is chosen  the function 
        searchs paramteres with names that match 
        the word 'AppName' or 'PlanName'. When 
        found the value for those paramaters will 
        be replace with random string of 8 characters.

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
        Set-ARMTemplateParameterFile -ARMTemplateFile $path -SetType 'SSHKeyData' -CreateDefaultValue
        Description
        -----------
        Find parameter of type 'SSHKeyData' in ARM Template file, add it to allowedValues and replace/create defaultValue for
        that parameter with valid SSH Public Key

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.json'

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateFile $path -SetType 'AppName' -CreateDefaultValue
        Description
        -----------
        Find parameter of type 'AppName' in ARM Template file, add it to allowedValues and replace/create defaultValue for
        that parameter with 8 character string

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.json'
    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateFile $path -SetType 'UserName' -CreateDefaultValue
        Description
        -----------
        Find parameter of type 'UserName' in ARM Template file, add it to allowedValues and replace/create defaultValue for
        that parameter with random 8 character string that starts with user prefix.

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.json'

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateFile $path -SetType 'VMName' -CreateDefaultValue
        Description
        -----------
        Find parameter of type 'VMName' in ARM Template file, add it to allowedValues and replace/create defaultValue for
        that parameter with 8 character string of small letters

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.json'

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateFile $path -SetType 'StorageAccountName' -CreateDefaultValue
        Description
        -----------
        Find parameter of type 'StorageAccountName' in ARM Template file, add it to allowedValues and replace/create defaultValue for
        that parameter with random generated storage name

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.json'

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateFile $path -SetType 'Password' -CreateDefaultValue
        Description
        -----------
        Find parameter of type 'Password' in ARM Template file, add it to allowedValues and replace/create defaultValue for
        that parameter with random complex password

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.json'

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateFile $path -SetType 'StorageAccountNamePrefix' -CreateDefaultValue
        Description
        -----------
        Find parameter of type 'StorageAccountNamePrefix' in ARM Template file, add it to allowedValues and replace/create defaultValue for
        that parameter with random generated 5 character string

        Example Variables
        -----------------
        $path = 'D:\ARMTEST\Downloaded\101-application-gateway-create\azuredeploy.json'

    .EXAMPLE
        Set-ARMTemplateParameterFile -ARMTemplateFile $path -SetType 'DNSLabel' -CreateDefaultValue
        Description
        -----------
        Find parameter of type 'DNSLabel' in ARM Template file, add it to allowedValues and replace/create defaultValue for
        that parameter with random generated 12 character string

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
        [ValidateSet('Location','StorageAccountName','StorageAccountNamePrefix','DNSLabel','Password','SSHKeyData','VMName','UserName','AppName')]
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
    #endregion

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

        #region SetType Location
        If ($SetType -eq 'Location') 
        {
            Try
            {
                #region Location Keywords
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
                        If ($ParameterName -match $LocationKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $LocationKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

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
                #endregion
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

        #region SetType StorageAccountName
        If ($SetType -eq 'StorageAccountName') 
        {
            Try
            {
                #region Storage Account Name Keywords
                $StorageAccountNameKeywords = @('StorageAccountName')

                # Go trough every keyword
                foreach ($StorageAccountNameKeyword in $StorageAccountNameKeywords)
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
                        If ($ParameterName -match $StorageAccountNameKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $StorageAccountNameKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check for defaultValue
                            If ($TemplateFileObj.parameters.($ParameterName).defaultValue)
                            {
                                # Set Value
                                $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                        -Length 10 `
                                                        -ErrorAction Stop
                                $TemplateFileObj.parameters.($ParameterName).defaultValue = $StorageAccountName
                                $TemplateFileObjChanged = $true
                            }
                            Else
                            {
                                # Create defaultValue
                                If ($CreateDefaultValue -eq $true)
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 10 `
                                                            -ErrorAction Stop
                                    $TemplateFileObj.parameters.($ParameterName) | Add-Member `
                                                                                    -MemberType NoteProperty `
                                                                                    -Name defaultValue `
                                                                                    -Value $StorageAccountName `
                                                                                    -ErrorAction Stop | Out-Null
                                    $TemplateFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion

                #region Exact Storage Account Name Keywords
                $ExactStorageAccountNameKeywords = @('storageName','newStorageAccount','storageAccount')

                # Go trough every keyword
                foreach ($ExactStorageAccountNameKeyword in $ExactStorageAccountNameKeywords)
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
                        If ($ParameterName -eq $ExactStorageAccountNameKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword exact match: ' + $ExactStorageAccountNameKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check for defaultValue
                            If ($TemplateFileObj.parameters.($ParameterName).defaultValue)
                            {
                                # Set Value
                                $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                        -Length 10 `
                                                        -ErrorAction Stop
                                $TemplateFileObj.parameters.($ParameterName).defaultValue = $StorageAccountName
                                $TemplateFileObjChanged = $true
                            }
                            Else
                            {
                                # Create defaultValue
                                If ($CreateDefaultValue -eq $true)
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 10 `
                                                            -ErrorAction Stop
                                    $TemplateFileObj.parameters.($ParameterName) | Add-Member `
                                                                                    -MemberType NoteProperty `
                                                                                    -Name defaultValue `
                                                                                    -Value $StorageAccountName `
                                                                                    -ErrorAction Stop | Out-Null
                                    $TemplateFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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

        #region SetType StorageAccountNamePrefix
        If ($SetType -eq 'StorageAccountNamePrefix') 
        {
            Try
            {
                #region Storage Account Name Prefix Keywords
                $StorageAccountNamePrefixKeywords = @('StorageAccountNamePrefix')

                # Go trough every keyword
                foreach ($StorageAccountNamePrefixKeyword in $StorageAccountNamePrefixKeywords)
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
                        If ($ParameterName -match $StorageAccountNamePrefixKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $StorageAccountNamePrefixKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check for defaultValue
                            If ($TemplateFileObj.parameters.($ParameterName).defaultValue)
                            {
                                # Set Value
                                $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                        -Length 5 `
                                                        -ErrorAction Stop
                                $TemplateFileObj.parameters.($ParameterName).defaultValue = $StorageAccountName
                                $TemplateFileObjChanged = $true
                            }
                            Else
                            {
                                # Create defaultValue
                                If ($CreateDefaultValue -eq $true)
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 5 `
                                                            -ErrorAction Stop
                                    $TemplateFileObj.parameters.($ParameterName) | Add-Member `
                                                                                    -MemberType NoteProperty `
                                                                                    -Name defaultValue `
                                                                                    -Value $StorageAccountName `
                                                                                    -ErrorAction Stop | Out-Null
                                    $TemplateFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion

                #region Exact Storage Account Name Prefix Keywords
                $ExactStorageAccountNamePrefixKeywords = @('storageAccountPrefix','accountPrefix')

                # Go trough every keyword
                foreach ($ExactStorageAccountNamePrefixKeyword in $ExactStorageAccountNamePrefixKeywords)
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
                        If ($ParameterName -eq $ExactStorageAccountNamePrefixKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword exact match: ' + $ExactStorageAccountNamePrefixKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check for defaultValue
                            If ($TemplateFileObj.parameters.($ParameterName).defaultValue)
                            {
                                # Set Value
                                $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                        -Length 5 `
                                                        -ErrorAction Stop
                                $TemplateFileObj.parameters.($ParameterName).defaultValue = $StorageAccountName
                                $TemplateFileObjChanged = $true
                            }
                            Else
                            {
                                # Create defaultValue
                                If ($CreateDefaultValue -eq $true)
                                {
                                    # Set Value
                                    $StorageAccountName = Get-ARMTemplateRandomStorageAccountName `
                                                            -Length 5 `
                                                            -ErrorAction Stop
                                    $TemplateFileObj.parameters.($ParameterName) | Add-Member `
                                                                                    -MemberType NoteProperty `
                                                                                    -Name defaultValue `
                                                                                    -Value $StorageAccountName `
                                                                                    -ErrorAction Stop | Out-Null
                                    $TemplateFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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

        #region SetType DNSLabel
        If ($SetType -eq 'DNSLabel') 
        {
            Try
            {
                #region DNS Label Keywords
                $DNSLabelKeywords = @('dnsLabel','dnsName','DnsPrefix','PublicIPName')

                # Go trough every keyword
                foreach ($DNSLabelKeyword in $DNSLabelKeywords)
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
                        If ($ParameterName -match $DNSLabelKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $DNSLabelKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check for defaultValue
                            If ($TemplateFileObj.parameters.($ParameterName).defaultValue)
                            {
                                # Set Value
                                $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                        -Length 12 `
                                                        -ErrorAction Stop
                                $TemplateFileObj.parameters.($ParameterName).defaultValue = $DNSLabelName
                                $TemplateFileObjChanged = $true
                            }
                            Else
                            {
                                # Create defaultValue
                                If ($CreateDefaultValue -eq $true)
                                {
                                    # Set Value
                                    $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                            -Length 12 `
                                                            -ErrorAction Stop
                                    $TemplateFileObj.parameters.($ParameterName) | Add-Member `
                                                                                    -MemberType NoteProperty `
                                                                                    -Name defaultValue `
                                                                                    -Value $DNSLabelName `
                                                                                    -ErrorAction Stop | Out-Null
                                    $TemplateFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion

                #region Exact DNS Label Keywords
                $ExactDNSLabelKeywords = @('publicIPAddressName','endpointName')

                # Go trough every keyword
                foreach ($ExactDNSLabelKeyword in $ExactDNSLabelKeywords)
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
                        If ($ParameterName -eq $ExactDNSLabelKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword exact match: ' + $ExactDNSLabelKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check for defaultValue
                            If ($TemplateFileObj.parameters.($ParameterName).defaultValue)
                            {
                                # Set Value
                                $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                        -Length 12 `
                                                        -ErrorAction Stop
                                $TemplateFileObj.parameters.($ParameterName).defaultValue = $DNSLabelName
                                $TemplateFileObjChanged = $true
                            }
                            Else
                            {
                                # Create defaultValue
                                If ($CreateDefaultValue -eq $true)
                                {
                                    # Set Value
                                    $DNSLabelName = Get-ARMTemplateRandomDNSLabel `
                                                            -Length 12 `
                                                            -ErrorAction Stop
                                    $TemplateFileObj.parameters.($ParameterName) | Add-Member `
                                                                                    -MemberType NoteProperty `
                                                                                    -Name defaultValue `
                                                                                    -Value $DNSLabelName `
                                                                                    -ErrorAction Stop | Out-Null
                                    $TemplateFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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

        #region SetType Password
        If ($SetType -eq 'Password') 
        {
            Try
            {
                #region DNS Label Keywords
                $PasswordKeywords = @('Password')

                # Go trough every keyword
                foreach ($PasswordKeyword in $PasswordKeywords)
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
                        If ($ParameterName -match $PasswordKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $PasswordKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check for defaultValue
                            If ($TemplateFileObj.parameters.($ParameterName).defaultValue)
                            {
                                # Set Value
                                $PasswordString = Get-ARMTemplateRandomPassword `
                                                        -Length 10 `
                                                        -ErrorAction Stop
                                $TemplateFileObj.parameters.($ParameterName).defaultValue = $PasswordString
                                $TemplateFileObjChanged = $true
                            }
                            Else
                            {
                                # Create defaultValue
                                If ($CreateDefaultValue -eq $true)
                                {
                                    # Set Value
                                    $PasswordString = Get-ARMTemplateRandomPassword `
                                                            -Length 10 `
                                                            -ErrorAction Stop
                                    $TemplateFileObj.parameters.($ParameterName) | Add-Member `
                                                                                    -MemberType NoteProperty `
                                                                                    -Name defaultValue `
                                                                                    -Value $PasswordString `
                                                                                    -ErrorAction Stop | Out-Null
                                    $TemplateFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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

        #region SetType SSHKeyData
        If ($SetType -eq 'SSHKeyData') 
        {
            Try
            {
                #region Exact SSH Key Data Keywords
                $ExactSSHKeyDataKeywords = @('sshKeyData','sshPublicKey')

                # Go trough every keyword
                foreach ($ExactSSHKeyDataKeyword in $ExactSSHKeyDataKeywords)
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
                        If ($ParameterName -eq $ExactSSHKeyDataKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword exact match: ' + $ExactSSHKeyDataKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check for defaultValue
                            If ($TemplateFileObj.parameters.($ParameterName).defaultValue)
                            {
                                # Set Value
                                $SSHKeyDataString = Get-ARMTemplateSSHPublicKeyData `
                                                        -ErrorAction Stop
                                $TemplateFileObj.parameters.($ParameterName).defaultValue = $SSHKeyDataString
                                $TemplateFileObjChanged = $true
                            }
                            Else
                            {
                                # Create defaultValue
                                If ($CreateDefaultValue -eq $true)
                                {
                                    # Set Value
                                    $SSHKeyDataString = Get-ARMTemplateSSHPublicKeyData `
                                                            -ErrorAction Stop
                                    $TemplateFileObj.parameters.($ParameterName) | Add-Member `
                                                                                    -MemberType NoteProperty `
                                                                                    -Name defaultValue `
                                                                                    -Value $SSHKeyDataString `
                                                                                    -ErrorAction Stop | Out-Null
                                    $TemplateFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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

        #region SetType VMName
        If ($SetType -eq 'VMName') 
        {
            Try
            {
                #region VM Name Keywords
                $VMNameKeywords = @('vmName','clusterName','vmssName','Servername')

                # Go trough every keyword
                foreach ($VMNameKeyword in $VMNameKeywords)
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
                        If ($ParameterName -match $VMNameKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $VMNameKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check for defaultValue
                            If ($TemplateFileObj.parameters.($ParameterName).defaultValue)
                            {
                                # Set Value
                                $VMName = Get-ARMTemplateRandomVMName  `
                                                        -Length 8 `
                                                        -ErrorAction Stop
                                $TemplateFileObj.parameters.($ParameterName).defaultValue = $VMName
                                $TemplateFileObjChanged = $true
                            }
                            Else
                            {
                                # Create defaultValue
                                If ($CreateDefaultValue -eq $true)
                                {
                                    # Set Value
                                    $VMName = Get-ARMTemplateRandomVMName  `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $TemplateFileObj.parameters.($ParameterName) | Add-Member `
                                                                                    -MemberType NoteProperty `
                                                                                    -Name defaultValue `
                                                                                    -Value $VMName `
                                                                                    -ErrorAction Stop | Out-Null
                                    $TemplateFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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

        #region SetType UserName
        If ($SetType -eq 'UserName') 
        {
            Try
            {
                #region User Name Keywords
                $UserNameKeywords = @('Username','databaseAccountName')

                # Go trough every keyword
                foreach ($UserNameKeyword in $UserNameKeywords)
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
                        If ($ParameterName -match $UserNameKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $UserNameKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check for defaultValue
                            If ($TemplateFileObj.parameters.($ParameterName).defaultValue)
                            {
                                # Set Value
                                $RandomUserName = Get-ARMTemplateRandomUserName `
                                                        -Length 8 `
                                                        -ErrorAction Stop
                                $TemplateFileObj.parameters.($ParameterName).defaultValue = $RandomUserName
                                $TemplateFileObjChanged = $true
                            }
                            Else
                            {
                                # Create defaultValue
                                If ($CreateDefaultValue -eq $true)
                                {
                                    # Set Value
                                    $RandomUserName = Get-ARMTemplateRandomUserName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $TemplateFileObj.parameters.($ParameterName) | Add-Member `
                                                                                    -MemberType NoteProperty `
                                                                                    -Name defaultValue `
                                                                                    -Value $RandomUserName `
                                                                                    -ErrorAction Stop | Out-Null
                                    $TemplateFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion

                #region Exact User Name Keywords
                $ExactUserNameKeywords = @('administratorLogin')

                # Go trough every keyword
                foreach ($ExactUserNameKeyword in $ExactUserNameKeywords)
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
                        If ($ParameterName -eq $ExactUserNameKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword exact match: ' + $ExactUserNameKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check for defaultValue
                            If ($TemplateFileObj.parameters.($ParameterName).defaultValue)
                            {
                                # Set Value
                                $RandomUserName = Get-ARMTemplateRandomUserName  `
                                                        -Length 8 `
                                                        -ErrorAction Stop
                                $TemplateFileObj.parameters.($ParameterName).defaultValue = $RandomUserName
                                $TemplateFileObjChanged = $true
                            }
                            Else
                            {
                                # Create defaultValue
                                If ($CreateDefaultValue -eq $true)
                                {
                                    # Set Value
                                    $RandomUserName = Get-ARMTemplateRandomUserName  `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $TemplateFileObj.parameters.($ParameterName) | Add-Member `
                                                                                    -MemberType NoteProperty `
                                                                                    -Name defaultValue `
                                                                                    -Value $RandomUserName `
                                                                                    -ErrorAction Stop | Out-Null
                                    $TemplateFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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

        #region SetType AppName
        If ($SetType -eq 'AppName') 
        {
            Try
            {
                #region App Name Keywords
                $AppNameKeywords = @('AppName','PlanName')

                # Go trough every keyword
                foreach ($AppNameKeyword in $AppNameKeywords)
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
                        If ($ParameterName -match $AppNameKeyword)
                        {
                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Keyword match: ' + $AppNameKeyword
                            Write-Verbose `
                                  -Message $VerboseMessage 

                            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Parameter Name: ' + $ParameterName
                            Write-Verbose `
                                  -Message $VerboseMessage

                            # Check for defaultValue
                            If ($TemplateFileObj.parameters.($ParameterName).defaultValue)
                            {
                                # Set Value
                                $RandomAppName = Get-ARMTemplateRandomAppName `
                                                        -Length 8 `
                                                        -ErrorAction Stop
                                $TemplateFileObj.parameters.($ParameterName).defaultValue = $RandomAppName
                                $TemplateFileObjChanged = $true
                            }
                            Else
                            {
                                # Create defaultValue
                                If ($CreateDefaultValue -eq $true)
                                {
                                    # Set Value
                                    $RandomAppName = Get-ARMTemplateRandomAppName `
                                                            -Length 8 `
                                                            -ErrorAction Stop
                                    $TemplateFileObj.parameters.($ParameterName) | Add-Member `
                                                                                    -MemberType NoteProperty `
                                                                                    -Name defaultValue `
                                                                                    -Value $RandomAppName `
                                                                                    -ErrorAction Stop | Out-Null
                                    $TemplateFileObjChanged = $true
                                }
                            }
                        }
                    }
                }
                #endregion
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
            If ($ARMTemplateFile -match 'modified')
            {
                $NewARMTemplateFilePath = $ARMTemplateFile
            }
            If ($PSCmdlet.ShouldProcess("Saving $NewARMTemplateFilePath file.")) 
            {
                
                # Convert log to JSON and write it into file
                $TemplateFileObj | `
                    ConvertTo-Json `
                        -Depth 20 `
                        -ErrorAction Stop | `
                    Out-File `
                        -FilePath $NewARMTemplateFilePath `
                        -Encoding utf8 `
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
        Failed results to log files. Outputs results

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
        New-ARMTemplateDeployment -AzureRegion 'North Europe' -ARMTemplatesPath $ARMTempaltesPath -OutputPath $OutputPath -AzureSubscriptionID $SubID -AzureCredentials $cred -ChangeLocationParameterValue -ChangeStorageAccountNameParameterValue -ChangeStorageAccountNamePrefixParameterValue -ChangeDNSLabelParameterValue -ChangePasswordParameterValue -ChangeSSHKeyDataParameterValue -ChangeVMNameParameterValue -ChangeUsrNameParameterValue -ChangeAppNameParameterValue
        Description
        -----------
        New ARM Template Deployment by loggin with Subscription ID
        Changes Location parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes Storage Account Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes Storage Account Name Prefix parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes DNS Label parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes Password parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes SSH Key Data parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes VM Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes User Name parameter in azuredeploy.json and azuredeploy.parameters.json files
        Changes App Name parameter in azuredeploy.json and azuredeploy.parameters.json files
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
        $ARMTemplateName,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=6,Mandatory=$false)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=6,Mandatory=$false)]
        [switch]
        $ChangeLocationParameterValue=$false,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=7,Mandatory=$false)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=7,Mandatory=$false)]
        [switch]
        $ChangeStorageAccountNameParameterValue=$false,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=8,Mandatory=$false)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=8,Mandatory=$false)]
        [switch]
        $ChangeStorageAccountNamePrefixParameterValue=$false,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=9,Mandatory=$false)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=9,Mandatory=$false)]
        [switch]
        $ChangeDNSLabelParameterValue=$false,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=10,Mandatory=$false)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=10,Mandatory=$false)]
        [switch]
        $ChangePasswordParameterValue=$false,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=11,Mandatory=$false)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=11,Mandatory=$false)]
        [switch]
        $ChangeSSHKeyDataParameterValue=$false,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=12,Mandatory=$false)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=12,Mandatory=$false)]
        [switch]
        $ChangeVMNameParameterValue=$false,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=13,Mandatory=$false)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=13,Mandatory=$false)]
        [switch]
        $ChangeUsrNameParameterValue=$false,

        [Parameter(ParameterSetName='LoginBySubscriptionID',Position=14,Mandatory=$false)]
        [Parameter(ParameterSetName='LoginByTenantID',Position=14,Mandatory=$false)]
        [switch]
        $ChangeAppNameParameterValue=$false
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
                If ($PSCmdlet.ShouldProcess("Creating Azure Resource Group: $ARMTemplateFolderName .")) 
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
           
            #region Change Location in parameters file
            If ($ChangeLocationParameterValue -eq $true)
            {
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
            }
            #endregion
            
            #region Change Storage Account Name in parameters file
            If ($ChangeStorageAccountNameParameterValue -eq $true)
            {
                $ParamFileChangeResult = Set-ARMTemplateParameterFile `
                                             -ARMTemplateParameterFile $azuredeployParametersLocation `
                                             -SetType StorageAccountName `
                                             -ErrorAction Stop
            
                # Change location if file is modified
                If ($ParamFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployParametersLocation = $ParamFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change Storage Account Name Prefix in parameters file
            If ($ChangeStorageAccountNamePrefixParameterValue -eq $true)
            {
                $ParamFileChangeResult = Set-ARMTemplateParameterFile `
                                             -ARMTemplateParameterFile $azuredeployParametersLocation `
                                             -SetType StorageAccountNamePrefix `
                                             -ErrorAction Stop
            
                # Change location if file is modified
                If ($ParamFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployParametersLocation = $ParamFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change DNS Label in parameters file
            If ($ChangeDNSLabelParameterValue -eq $true)
            {
                $ParamFileChangeResult = Set-ARMTemplateParameterFile `
                                             -ARMTemplateParameterFile $azuredeployParametersLocation `
                                             -SetType DNSLabel `
                                             -ErrorAction Stop
            
                # Change location if file is modified
                If ($ParamFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployParametersLocation = $ParamFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change Password in parameters file
            If ($ChangePasswordParameterValue -eq $true)
            {
                $ParamFileChangeResult = Set-ARMTemplateParameterFile `
                                             -ARMTemplateParameterFile $azuredeployParametersLocation `
                                             -SetType Password `
                                             -ErrorAction Stop
            
                # Change location if file is modified
                If ($ParamFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployParametersLocation = $ParamFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change SSH Key Data in parameters file
            If ($ChangeSSHKeyDataParameterValue -eq $true)
            {
                $ParamFileChangeResult = Set-ARMTemplateParameterFile `
                                             -ARMTemplateParameterFile $azuredeployParametersLocation `
                                             -SetType SSHKeyData `
                                             -ErrorAction Stop
            
                # Change location if file is modified
                If ($ParamFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployParametersLocation = $ParamFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change VM Name in parameters file
            If ($ChangeVMNameParameterValue -eq $true)
            {
                $ParamFileChangeResult = Set-ARMTemplateParameterFile `
                                             -ARMTemplateParameterFile $azuredeployParametersLocation `
                                             -SetType VMName `
                                             -ErrorAction Stop
            
                # Change location if file is modified
                If ($ParamFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployParametersLocation = $ParamFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change User Name in parameters file
            If ($ChangeUsrNameParameterValue -eq $true)
            {
                $ParamFileChangeResult = Set-ARMTemplateParameterFile `
                                             -ARMTemplateParameterFile $azuredeployParametersLocation `
                                             -SetType UserName `
                                             -ErrorAction Stop
            
                # Change location if file is modified
                If ($ParamFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployParametersLocation = $ParamFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change App Name in parameters file
            If ($ChangeAppNameParameterValue -eq $true)
            {
                $ParamFileChangeResult = Set-ARMTemplateParameterFile `
                                             -ARMTemplateParameterFile $azuredeployParametersLocation `
                                             -SetType AppName `
                                             -ErrorAction Stop
            
                # Change location if file is modified
                If ($ParamFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployParametersLocation = $ParamFileChangeResult.FilePath
                }
            }
            #endregion
            
            
            #region Change Location in template file
            If ($ChangeLocationParameterValue -eq $true)
            {
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
            }
            #endregion
            
            #region Change Storage Account Name in template file
            If ($ChangeStorageAccountNameParameterValue -eq $true)
            {
                $TemplateFileChangeResult = Set-ARMTemplateFile `
                                                 -ARMTemplateFile $azuredeployLocation `
                                                 -SetType StorageAccountName `
                                                 -CreateDefaultValue `
                                                 -ErrorAction Stop
            
                If ($TemplateFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployLocation = $TemplateFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change Storage Account Name Prefix in template file
            If ($ChangeStorageAccountNamePrefixParameterValue -eq $true)
            {
                $TemplateFileChangeResult = Set-ARMTemplateFile `
                                                 -ARMTemplateFile $azuredeployLocation `
                                                 -SetType StorageAccountNamePrefix `
                                                 -CreateDefaultValue `
                                                 -ErrorAction Stop
            
                If ($TemplateFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployLocation = $TemplateFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change DNS Label in template file
            If ($ChangeDNSLabelParameterValue -eq $true)
            {
                $TemplateFileChangeResult = Set-ARMTemplateFile `
                                                 -ARMTemplateFile $azuredeployLocation `
                                                 -SetType DNSLabel `
                                                 -CreateDefaultValue `
                                                 -ErrorAction Stop
            
                If ($TemplateFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployLocation = $TemplateFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change Password in template file
            If ($ChangePasswordParameterValue -eq $true)
            {
                $TemplateFileChangeResult = Set-ARMTemplateFile `
                                                 -ARMTemplateFile $azuredeployLocation `
                                                 -SetType Password `
                                                 -CreateDefaultValue `
                                                 -ErrorAction Stop
            
                If ($TemplateFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployLocation = $TemplateFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change SSH Key Data in template file
            If ($ChangeSSHKeyDataParameterValue -eq $true)
            {
                $TemplateFileChangeResult = Set-ARMTemplateFile `
                                                 -ARMTemplateFile $azuredeployLocation `
                                                 -SetType SSHKeyData `
                                                 -CreateDefaultValue `
                                                 -ErrorAction Stop
            
                If ($TemplateFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployLocation = $TemplateFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change VM Name in template file
            If ($ChangeVMNameParameterValue -eq $true)
            {
                $TemplateFileChangeResult = Set-ARMTemplateFile `
                                                 -ARMTemplateFile $azuredeployLocation `
                                                 -SetType VMName `
                                                 -CreateDefaultValue `
                                                 -ErrorAction Stop
            
                If ($TemplateFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployLocation = $TemplateFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change User Name in template file
            If ($ChangeUsrNameParameterValue -eq $true)
            {
                $TemplateFileChangeResult = Set-ARMTemplateFile `
                                                 -ARMTemplateFile $azuredeployLocation `
                                                 -SetType UserName `
                                                 -CreateDefaultValue `
                                                 -ErrorAction Stop
            
                If ($TemplateFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployLocation = $TemplateFileChangeResult.FilePath
                }
            }
            #endregion
            
            #region Change App Name in template file
            If ($ChangeAppNameParameterValue -eq $true)
            {
                $TemplateFileChangeResult = Set-ARMTemplateFile `
                                                 -ARMTemplateFile $azuredeployLocation `
                                                 -SetType AppName `
                                                 -CreateDefaultValue `
                                                 -ErrorAction Stop
            
                If ($TemplateFileChangeResult.FileChanged -eq 'Yes')
                {
                    $azuredeployLocation = $TemplateFileChangeResult.FilePath
                }
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
                            -Seconds 10 `
                            -ErrorAction Stop
                        
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
                        # Increment BadError count
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
        }
        #endregion
        #region Invalid Template
        Else
        {
            $VerboseMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - ' + $azuredeployFileName + ' and/or ' + $azuredeployParametersFileName + ' are not present in ' + $ARMTemplateFolder
            Write-Verbose `
                -Message $VerboseMessage 
        
            $ARMTemplateInvalid++
        
            #region Information
            $InformationMessage = 'INFO: ' + (Get-Date -Format HH:mm:ss).ToString() + ' - Template is invalid: ' + $ARMTemplateFolderName
            Write-Information `
                -MessageData $InformationMessage
            #endregion
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
        matching different keywords and replaces their values
        with the other values. Adds '-modified' to the file 
        names of changed. Deploys  ARM Template from 
        azuredeploy.json/azuredeploy-modified.json 
        and azuredeploy.parameters.json/azuredeploy.parameters-modified.json. 
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
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ChangeLocationParameterValue -ChangeStorageAccountNameParameterValue -ChangeStorageAccountNamePrefixParameterValue -ChangeDNSLabelParameterValue -ChangePasswordParameterValue -ChangeSSHKeyDataParameterValue -ChangeVMNameParameterValue -ChangeUsrNameParameterValue -ChangeAppNameParameterValue
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
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ChangeLocationParameterValue -ChangeStorageAccountNameParameterValue -ChangeStorageAccountNamePrefixParameterValue -ChangeDNSLabelParameterValue -ChangePasswordParameterValue -ChangeSSHKeyDataParameterValue -ChangeVMNameParameterValue -ChangeUsrNameParameterValue -ChangeAppNameParameterValue
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
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -ChangeLocationParameterValue
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
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -ChangeLocationParameterValue
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
        Deploys ARM Template '101-application-gateway-create' and '101-application-gateway-public-ip'
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $SubID = '4f20465d-3857-49a5-ac16-23db4b38b3ea'
        $cred = Get-Credential
        $RepURL = 'https://github.com/Azure/azure-quickstart-templates'

    .EXAMPLE
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -ChangeLocationParameterValue
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
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ChangeLocationParameterValue
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
        Deploys all ARM Templates located in 'D:\ARMTEST\Downloaded'
        Logs deployment results
        All data is written in 'D:\ARMTEST'
        
        Example Variables
        -----------------
        $TenID = 'e046c6c9-3575-4e39-8f1c-173b2ea01ea9'
        $cred = Get-Credential

    .EXAMPLE
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -ChangeLocationParameterValue
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
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -ChangeLocationParameterValue
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
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -ChangeLocationParameterValue
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
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -ChangeLocationParameterValue
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
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ChangeLocationParameterValue -InformationAction Continue
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
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ChangeLocationParameterValue -InformationAction Continue
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
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -ChangeLocationParameterValue -InformationAction Continue
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
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -ChangeLocationParameterValue -InformationAction Continue
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
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -ChangeLocationParameterValue -InformationAction Continue
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
        Test-ARMTemplate -AzureSubscriptionID $SubID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -ChangeLocationParameterValue -InformationAction Continue
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
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ChangeLocationParameterValue -InformationAction Continue
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
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ChangeLocationParameterValue -InformationAction Continue
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
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -ChangeLocationParameterValue -InformationAction Continue
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
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create' -ChangeLocationParameterValue -InformationAction Continue
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
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -GitHubRepositoryURL $RepURL -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -ChangeLocationParameterValue -InformationAction Continue
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
        Test-ARMTemplate -AzureTenantID $TenID -AzureCredentials $cred -AzureRegion 'North Europe' -ARMTemplatesPath 'D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST' -ARMTemplateName '101-application-gateway-create','101-application-gateway-public-ip' -ChangeLocationParameterValue -InformationAction Continue
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
        $ARMTemplateName,

        [Parameter(Position=6,Mandatory=$false)]
        [switch]
        $ChangeLocationParameterValue=$false,

        [Parameter(Position=7,Mandatory=$false)]
        [switch]
        $ChangeStorageAccountNameParameterValue=$false,

        [Parameter(Position=8,Mandatory=$false)]
        [switch]
        $ChangeStorageAccountNamePrefixParameterValue=$false,

        [Parameter(Position=9,Mandatory=$false)]
        [switch]
        $ChangeDNSLabelParameterValue=$false,

        [Parameter(Position=10,Mandatory=$false)]
        [switch]
        $ChangePasswordParameterValue=$false,

        [Parameter(Position=11,Mandatory=$false)]
        [switch]
        $ChangeSSHKeyDataParameterValue=$false,

        [Parameter(Position=12,Mandatory=$false)]
        [switch]
        $ChangeVMNameParameterValue=$false,

        [Parameter(Position=13,Mandatory=$false)]
        [switch]
        $ChangeUsrNameParameterValue=$false,

        [Parameter(Position=14,Mandatory=$false)]
        [switch]
        $ChangeAppNameParameterValue=$false
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
        
        If ($ChangeLocationParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams.Add('ChangeLocationParameterValue', $true)
        }
        
        If ($ChangeStorageAccountNameParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams.Add('ChangeStorageAccountNameParameterValue', $true)
        }

        If ($ChangeStorageAccountNamePrefixParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams.Add('ChangeStorageAccountNamePrefixParameterValue', $true)
        }

        If ($ChangeDNSLabelParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams.Add('ChangeDNSLabelParameterValue', $true)
        }

        If ($ChangePasswordParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams.Add('ChangePasswordParameterValue', $true)
        }

        If ($ChangeSSHKeyDataParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams.Add('ChangeSSHKeyDataParameterValue', $true)
        }

        If ($ChangeVMNameParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams.Add('ChangeVMNameParameterValue', $true)
        }

        If ($ChangeUsrNameParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams.Add('ChangeUsrNameParameterValue', $true)
        }

        If ($ChangeAppNameParameterValue -eq $true)
        {
            $ARMTemplateDeploymentParams.Add('ChangeAppNameParameterValue', $true)
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
            -ErrorAction Stop | Out-Null
        #endregion

        #region Remove Azure Resource Group
        If ($ARMTemplateDeploymentResults.Invalid -eq 0)
        {
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
Export-ModuleMember -Function Remove-ARMTemplateDeployment,Write-ARMTemplateLog,Move-ARMTemplateFolder,New-ARMTemplateDeployment,Get-GitHubRepositoryMasterArchive,Expand-GitHubMasterArchive,Merge-ARMTemplateLog,Test-ARMTemplate,Add-ARMTemplateLogin,Set-ARMTemplateParameterFile,Set-ARMTemplateFile,Export-ARMTemplateLogToCSV,Get-ARMTemplateRandomStorageAccountName,Get-ARMTemplateRandomPassword,Get-ARMTemplateSSHPublicKeyData,Get-ARMTemplateRandomVMName,Get-ARMTemplateRandomAppName,Get-ARMTemplateRandomUserName,Get-ARMTemplateRandomDNSLabel