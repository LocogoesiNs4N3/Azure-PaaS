param (  
        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string] 
        $EnableCapacity='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string]  
        $EnableSecurity='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string]  
        $EnableUpdates='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string] 
        $EnableAntiMalware='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string] 
        $EnableLogManagement='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string] 
        $EnableChangeTracking='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string]  
        $EnableSQLAssessment='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string]  
        $EnableADAssessment='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string] 
        $EnableAlertManagement='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string] 
        $EnableAzureAutomation='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string]  
        $EnableWireData='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string] 
        $EnableSiteRecovery='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string] 
        $EnableBackup='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string]  
        $EnableSurfaceHub='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string]  
        $EnableContainers='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string]  
        $EnableAzureNetworking='False',

        [Parameter(Mandatory=$false)]
        [ValidateSet('True','False')]
        [string]  
        $EnableADReplication='False'
    )

    #region Initial Setup
    # Set Error Preference	
	$ErrorActionPreference = 'Stop'

    # Get Variables and Credentials
	$AzureSubscriptionID          = Get-AutomationVariable -Name 'AzureSubscriptionID'
	$AzureCreds                   = Get-AutomationPSCredential -Name 'AzureCredentials'
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

    #region Enable Capacity Solution
    if ($EnableCapacity -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName Capacity `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled Capacity Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable Capacity Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable Security and Audit Solution
    if ($EnableSecurity -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName Security `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled Security and Audit Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable Security and Audit Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable System Update Assessment Solution
    if ($EnableUpdates -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName Updates `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled System Update Assessment Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable System Update Assessment Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable Antimalware Assessment Solution
    if ($EnableAntiMalware -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName AntiMalware `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled Antimalware Assessment Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable Antimalware Assessment Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable Log Management Solution
    if ($EnableLogManagement -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName LogManagement `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled Log Management Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable Log Management Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable Change Tracking Solution
    if ($EnableChangeTracking -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName ChangeTracking `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled Change Tracking Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable Change Tracking Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable SQL Assessment Solution
    if ($EnableSQLAssessment -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName SQLAssessment `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled SQL Assessment Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable SQL Assessment Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable AD Assessment Solution
    if ($EnableADAssessment -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName ADAssessment `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled AD Assessment Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable AD Assessment Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable Alert Management Solution
    if ($EnableAlertManagement -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName AlertManagement `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled Alert Management Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable Alert Management Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable Automation Solution
    if ($EnableAzureAutomation -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName AzureAutomation `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled Automationt Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable Automation Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable Wire Data Solution
    if ($EnableWireData -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName WireData `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled Wire Data Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable Wire Data Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable Site Recovery Solution
    if ($EnableSiteRecovery -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName SiteRecovery `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled Site Recovery Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable Site Recovery Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable Backup Solution
    if ($EnableBackup -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName Backup `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled Backup Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable Backup Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable Surface Hub Solution
    if ($EnableSurfaceHub -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName SurfaceHub `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled Surface Hub Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable Surface Hub Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable Containers Solution
    if ($EnableContainers -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName Containers `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled Containers Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable Containers Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable Azure Networking Analytics Solution
    if ($EnableAzureNetworking -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName AzureNetworking `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled Azure Networking Analytics Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable Azure Networking Analytics Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

    #region Enable AD Replication Solution
    if ($EnableADReplication -eq 'True')
    {
        Try
        {
            Set-AzureRmOperationalInsightsIntelligencePack `
                -ResourceGroupName $OMSLogAnalyticsRG `
                -WorkspaceName $OMSLogAnalyticsWorkspaceName `
                -IntelligencePackName ADReplication `
                -Enabled $true `
                -ErrorAction Stop | Out-Null

            Write-Output `
                -InputObject 'Enabled AD Replication Solution.'
        }
        Catch
        {
            $ErrorMessage = 'Failed to enable AD Replication Solution.'
            $ErrorMessage += " `n"
            $ErrorMessage += 'Error: '
            $ErrorMessage += $_
            Write-Error -Message $ErrorMessage `
                        -ErrorAction Stop
        }
        
    }
    #endregion

