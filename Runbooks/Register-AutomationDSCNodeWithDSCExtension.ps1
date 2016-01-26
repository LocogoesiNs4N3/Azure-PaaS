workflow Register-AutomationDSCNodeWithDSCExtension
{
    param (

                   
    )

    # Set Error Preference	
	$ErrorActionPreference = "Stop"

    
    # Get Server Name
    $VMName = Get-AutomationVariable `
                              -Name 'ServerName'

    # Get Server Resource Group
    $VMResourceGroup = Get-AutomationVariable `
                              -Name 'ServerResourceGroup'


    $AzureSubscriptionID = Get-AutomationVariable `
                               -Name 'AzureSubscriptionID'

    $AutomationAccountName = Get-AutomationVariable `
                                 -Name 'AutomationAccountName'

    $AutomationAccountResourceGroup = Get-AutomationVariable `
                                          -Name 'AutomationAccountResourceGroup'

    
    # Get Credentials to Azure Subscription
    $AzureCreds = Get-AutomationPSCredential `
                  -Name 'AzureCredentials'
    inlinescript
    {
        Try
        {
            # Connect to Azure
            $AzureAccount = Add-AzureRmAccount `
                            -Credential $Using:AzureCreds `
                            -SubscriptionId $Using:AzureSubscriptionID `
                            -ErrorAction Stop
            Write-Output -InputObject 'Successfuly connected to Azure.'
        }
        Catch
        {
            $ErrorMessage = 'Login to Azure failed.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }





        # Node Configuration Name
        $NodeConfigName = $Using:VMName

        Try
        {
            # get Azure Automation DSC registration info
            $Account = Get-AzureRmAutomationAccount `
                       -ResourceGroupName $Using:AutomationAccountResourceGroup `
                       -Name $Using:AutomationAccountName `
                       -ErrorAction Stop
            $RegistrationInfo = $Account | `
                                Get-AzureRmAutomationRegistrationInfo `
                                -ErrorAction Stop
            Write-Output -InputObject 'Automation Account information was successfully retrieved.'
    
        }
        Catch
        {
            $ErrorMessage = 'Failed to get Automation Account information.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
    
        }
    
        Try
        {
            # use the DSC extension to onboard the VM for management with Azure Automation DSC
            $VM = Get-AzureRmVM `
                  -Name $Using:VMName `
                  -ResourceGroupName $Using:VMResourceGroup `
                  -ErrorAction Stop
            Write-Output -InputObject 'Successfully found Azure VM to apply DSC Extension.'
    
        }
        Catch
        {
            $ErrorMessage = 'Failed to find Azure v2 VM.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
    

        $PublicConfiguration = @{
          SasToken = ""
          ModulesUrl = "https://eus2oaasibizamarketprod1.blob.core.windows.net/automationdscpreview/RegistrationMetaConfigV2.zip"
          ConfigurationFunction = "RegistrationMetaConfigV2.ps1\RegistrationMetaConfigV2"

        # update these DSC agent Local Configuration Manager defaults if they do not match your use case.
        Properties = @{
           RegistrationKey = @{
             UserName = 'notused'
             Password = 'PrivateSettingsRef:RegistrationKey'
        }
          RegistrationUrl = $RegistrationInfo.Endpoint
          NodeConfigurationName = $NodeConfigName
          ConfigurationMode = "ApplyAndMonitor"
          ConfigurationModeFrequencyMins = 15
          RefreshFrequencyMins = 30
          RebootNodeIfNeeded = $True
          ActionAfterReboot = "ContinueConfiguration"
          AllowModuleOverwrite = $False
          }
        }

        $PrivateConfiguration =  @{
          Items = @{
             RegistrationKey = $RegistrationInfo.PrimaryKey
          }
        }


        Try
        {
            $VmExtension = Set-AzureRmVMExtension `
                           -VMName $Using:VMName `
                           -ResourceGroupName $Using:VMResourceGroup `
                           -Publisher Microsoft.Powershell `
                           -Name DSC `
                           -ExtensionType DSC `
                           -TypeHandlerVersion 2.7 `
                           -Settings $PublicConfiguration `
                           -ProtectedSettings $PrivateConfiguration `
                           -Location $VM.Location
    
            If ($VmExtension.Status -eq 'Succeeded')
            {
                Write-Output -InputObject 'Successfully installed and configured DSC Extension.'
                Write-Output -InputObject 'Check Automation account to see if node is connected successfully to Automation DSC.'
            }
            Else
            {
                $ErrorMessage = 'DSC Extension is with status '
                $ErrorMessage += $VmExtension.Status
                $ErrorMessage += '.'
                $ErrorMessage += " `n"
                $ErrorMessage += 'DSC Extension Error Details: '
                $ErrorMessage += $VmExtension.Error
                Write-Error -Message $ErrorMessage `
                            -ErrorAction Stop
            }
    
        }
        Catch
        {
            $ErrorMessage = 'Failed to install DSC Extension.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
    
        }
    }
    
    

}