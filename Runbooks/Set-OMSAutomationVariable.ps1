	param (     
    )

    #region Initial Setup
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'

    # Get Variables and Credentials
	$AzureSubscriptionID          = Get-AutomationVariable -Name 'AzureSubscriptionID'
	$AzureCreds                   = Get-AutomationPSCredential -Name 'AzureCredentials'
    $OMSAutomationRG              = Get-AutomationVariable -Name 'OMSAutomationAccountResourceGroup'
    $OMSAutomationAccountName     = Get-AutomationVariable -Name 'OMSAutomationAccountName'
    $OMSLogAnalyticsRG            = Get-AutomationVariable -Name 'OMSLogAnalyticsWorkspaceResourceGroup'
    $OMSLogAnalyticsWorkspaceName = Get-AutomationVariable -Name 'OMSLogAnalyticsWorkspaceName'
    #endregion

    #region Azure login
    Try
    {
        # Connect to Azure
        Add-AzureRmAccount `
           -Credential $AzureCreds `
           -SubscriptionId $AzureSubscriptionID `
           -ErrorAction Stop | Out-Null
        Write-Output `
            -InputObject 'Successfuly connected to Azure.'
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
    #endregion

    #region OMS Automation Key
    Try
    {
        # Get OMS Automation Keys
        $OMSAUtomationRegistrationInfo = Get-AzureRmAutomationRegistrationInfo `
                                            -ResourceGroupName $OMSAutomationRG  `
                                            -AutomationAccountName $OMSAutomationAccountName `
                                            -ErrorAction Stop
        Write-Output `
            -InputObject 'Retrieved OMS Automation Keys.'
    }
    Catch
    {
        $ErrorMessage = 'Failed to get OMS Automation Keys.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error -Message $ErrorMessage `
                    -ErrorAction Stop
    }
    
    Try
    {
        Get-AzureRmAutomationVariable `
            -Name 'OMSAutomationAccountPrimaryKey' `
            -ResourceGroupName $OMSAutomationRG `
            -AutomationAccountName $OMSAutomationAccountName `
            -ErrorAction Stop | Out-Null
        
        Set-AzureRmAutomationVariable `
            -Name 'OMSAutomationAccountPrimaryKey' `
            -ResourceGroupName $OMSAutomationRG `
            -AutomationAccountName $OMSAutomationAccountName `
            -Encrypted $true `
            -Value $OMSAUtomationRegistrationInfo.PrimaryKey `
            -ErrorAction Stop | Out-Null
        
        Write-Output `
                -InputObject 'Set OMSAutomationAccountPrimaryKey variable.'

    }
    Catch
    {
        Try
        {
            New-AzureRmAutomationVariable `
                -Name 'OMSAutomationAccountPrimaryKey' `
                -ResourceGroupName $OMSAutomationRG `
                -AutomationAccountName $OMSAutomationAccountName `
                -Encrypted $true `
                -Value $OMSAUtomationRegistrationInfo.PrimaryKey `
                -Description  'OMS Automation Account Primary Access Key.' `
                -ErrorAction Stop | Out-Null
            
            Write-Output `
                -InputObject 'Created OMSAutomationAccountPrimaryKey variable.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to create OMS Automation variable OMSAutomationAccountPrimaryKey.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        

    }
    #endregion

    #region OMS Log Analytics Workspace Key
	Try
    {
        # Get OMS Log Analytics Keys
        $OMSLogAnalyticsSharedKeys = Get-AzureRmOperationalInsightsWorkspaceSharedKeys `
                                        -ResourceGroupName $OMSLogAnalyticsRG `
                                        -Name $OMSLogAnalyticsWorkspaceName `
                                        -ErrorAction Stop
        Write-Output `
            -InputObject 'Retrieved OMS Log Analytics Keys.'
    }
    Catch
    {
        $ErrorMessage = 'Failed to get OMS Log Analytics Keys.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error -Message $ErrorMessage `
                    -ErrorAction Stop
    }

    Try
    {
        Get-AzureRmAutomationVariable `
            -Name 'OMSLogAnalyticsWorkspacePrimaryKey' `
            -ResourceGroupName $OMSAutomationRG `
            -AutomationAccountName $OMSAutomationAccountName `
            -ErrorAction Stop | Out-Null
        
        Set-AzureRmAutomationVariable `
            -Name 'OMSLogAnalyticsWorkspacePrimaryKey' `
            -ResourceGroupName $OMSAutomationRG `
            -AutomationAccountName $OMSAutomationAccountName `
            -Encrypted $true `
            -Value $OMSLogAnalyticsSharedKeys.PrimarySharedKey `
            -ErrorAction Stop | Out-Null
        
        Write-Output `
           -InputObject 'Set OMSLogAnalyticsWorkspacePrimaryKey variable.'

    }
    Catch
    {
        Try
        {
            New-AzureRmAutomationVariable `
                -Name 'OMSLogAnalyticsWorkspacePrimaryKey' `
                -ResourceGroupName $OMSAutomationRG `
                -AutomationAccountName $OMSAutomationAccountName `
                -Encrypted $true `
                -Value $OMSLogAnalyticsSharedKeys.PrimarySharedKey `
                -Description  'OMS Log Analytics Workspace Primary Access Key.' `
                -ErrorAction Stop | Out-Null
            
            Write-Output `
                -InputObject 'Created OMSLogAnalyticsWorkspacePrimaryKey variable.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to create OMS Automation variable OMSLogAnalyticsWorkspacePrimaryKey.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
    }
    #endregion