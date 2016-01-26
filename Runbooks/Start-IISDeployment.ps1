	param (
        [Parameter(Mandatory=$false)]
        [object] 
        $WebhookData
   
    )	
    
    #region Initial Setup

    # Set Error Preference	
	$ErrorActionPreference = 'Stop'

    # Get Credentials for the Azure VM
    $ServerCreds = Get-AutomationPSCredential `
                        -Name 'ServerCredentials'	

    # Get Azure Credentials
    $AzureCreds = Get-AutomationPSCredential `
                        -Name 'AzureCredentials'
    
    # Get Azure Subscription ID                    
    $AzureSubscriptionID = Get-AutomationVariable `
                              -Name 'AzureSubscriptionID'

    # Get Server Name
    $ServerName = Get-AutomationVariable `
                              -Name 'ServerName'

    # Get Server Resource Group
    $ServerRG = Get-AutomationVariable `
                              -Name 'ServerResourceGroup'
    #endregion

    #region WebHookData
    Try
    {
        $GitHubData = $WebhookData.RequestBody | ConvertFrom-Json -ErrorAction Stop 

        $branch = $GitHubData.repository.default_branch
        $repositoryURL = $GitHubData.repository.html_url
        $RepositoryName = $GitHubData.repository.name
    }
    Catch
    {
        $ErrorMessage = 'Failed to convert json.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    #endregion

    #region Azure Login
    Try
    {
        # Authenticate
	    Add-AzureRmAccount `
            -Credential $AzureCreds `
            -SubscriptionId $AzureSubscriptionID | Out-Null
    }
    Catch
    {
        $ErrorMessage = 'Login to Azure failed.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
        -Message $ErrorMessage `
        -ErrorAction Stop
    }
    #endregion		

    #region Azure VM
    Try
    {
        # Get Azure VM Properties
        $Vm= Get-AzureRmVM `
                -ResourceGroupName $ServerRG `
                -Name $ServerName
    }
    Catch
    {
        $ErrorMessage = 'Could not get Azure VM.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    #endregion

    #region Network Interface
    Try
    {
        $VMNetworkInterfaceName = $vm.NetworkInterfaceIDs[0].Split('/')[-1]
        $VMNetworkInterfaceObj = Get-AzureRmNetworkInterface `
                                    -ResourceGroupName $ServerRG `
                                    -Name $VMNetworkInterfaceName
    }
    Catch
    {
        $ErrorMessage = 'Could not get Azure VM Network Interface.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    #endregion
    
    #region Public IP Address Name
    Try
    {
        $IPConfigurations = $VMNetworkInterfaceObj.IpConfigurations
        foreach ($IPConfiguration in $IPConfigurations)
        {
                If ($IPConfiguration.PublicIpAddress.ID -ne $null) 
                {
                    $PublicIPName = $IPConfiguration.PublicIpAddress.Id.Split('/')[-1]
                }
                Else
                {
                    Write-Error `
                        -Message 'There is no public IP Configured for VM.' `
                        -ErrorAction Stop
                }
        }
    }
    Catch
    {
        $ErrorMessage = 'Could not get Azure VM Public IP Address.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    #endregion

    #region Public DNS FQDN
    Try
    {
        $PublicIPObj = Get-AzureRmPublicIpAddress `
                            -Name $PublicIPName `
                            -ResourceGroupName $ServerRG

        If ($PublicIPObj.DnsSettings.Fqdn -ne $null)
        {
            $PublicDNSFQDN = $PublicIPObj.DnsSettings.Fqdn
            Write-Output -InputObject 'Found Azure VM public DNS.'
        }
        Else
        {
            Write-Error `
                -Message 'There is not public DNS FQDN for the VM.' `
                -ErrorAction Stop
        }
    }
    Catch
    {
        $ErrorMessage = 'Could not get Azure VM Public DNS FQDN.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    #endregion

    #region PS Session
    Try
    {
        $PSSessionOptionParms = @{}
        $PSSessionOptionParms.Add('SkipCACheck', $true)
        $PSSessionOptionParms.Add('SkipCNCheck', $true)
        $PSSessionOptionParms.Add('SkipRevocationCheck', $true)
        
        $PSession = New-PSSession `
                        -ComputerName $PublicDNSFQDN `
                        -Credential $ServerCreds `
                        -UseSSL `
                        -SessionOption (New-PSSessionOption @PSSessionOptionParms)
        
        Write-Output -InputObject 'Logged to Azure VM.'
    }
    Catch
    {
        $ErrorMessage = 'Could not create PS Session to Azure VM.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    #endregion

    #region Invoke command
    Try
    {
        Invoke-Command `
                -Session $PSession `
                -ScriptBlock {

                 #region Initial Setup
                 $ArchiveFolderName = $Args[0] + '-' + $Args[1]

                 $ArchiveURL = $Args[2] + '/archive/' + $Args[1] + '.zip'

                 $DeploymentPath = 'C:\Deployment'

                 If ((Test-path -Path $DeploymentPath) -eq $false)
                 {
                     New-Item `
                         -Path $DeploymentPath `
                         -ItemType Directory `
                         -Force `
                         -ErrorAction Stop | Out-Null
                 }

                 $FullDownloadPath = $DeploymentPath + '\' + $Args[1] + '.zip'
                 #endregion

                 #region Download
                 $RequestResult = Invoke-WebRequest `
                                     -Uri $ArchiveURL `
                                     -OutFile $FullDownloadPath `
                                     -UseBasicParsing `
                                     -passthru `
                                     -ErrorAction Stop
                 #endregion

                 #region Check Successful Download
                 If ($RequestResult.StatusCode -eq 200)
                 {
                     # Check if file is saved successfully
                     If ((Test-Path -Path $FullDownloadPath) -eq $true)
                     {
                         Write-Output -InputObject 'Downloaded file from GitHub Repository.'
                     }
                     Else
                     {
                         $ErrorMessage = (Get-Date -Format HH:mm:ss).ToString() + ' - Failed to save downloaded file to ' + $FullDownloadPath + ' .'
                         Write-Error `
                             -Message $ErrorMessage `
                             -ErrorAction Stop
                     }
                 }
                 Else
                 {
                     $ErrorMessage = 'Failed to download ' + $ArchiveURL + ' .'
                     $ErrorMessage += " `n"
                     $ErrorMessage += 'HTTP Error: '
                     $ErrorMessage += $RequestResult
                     Write-Error `
                         -Message $ErrorMessage `
                         -ErrorAction Stop
                 }
                 #endregion

                 #region Load System.IO.Compression.FileSystem assembly
                 Try
                 {
                    
                    [System.Reflection.Assembly]::LoadWithPartialName('System.IO.Compression.FileSystem') | Out-Null
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
                 #endregion

                 #region Remove Temp if exists
                 $TempFolder = 'C:\temp'
                 # Check if temporary folde exists
                 If ((Test-path -Path $TempFolder) -eq $true)
                 {

                     # Delete if temporary folder exists
                     Remove-Item `
                         -Path $TempFolder `
                         -Recurse `
                         -Force `
                         -ErrorAction Stop
                 }
                 #endregion

                 #region Extract
                 Try
                 {
                    [System.IO.Compression.ZipFile]::ExtractToDirectory($FullDownloadPath, $TempFolder)
                 }
                 Catch
                 {
                    $ErrorMessage = 'Failed to extract ' + $FullDownloadPath
                    $ErrorMessage += " `n"
                    $ErrorMessage += 'Error: '
                    $ErrorMessage += $_
                    Write-Error `
                        -Message $ErrorMessage `
                        -ErrorAction Stop
                 }
                 #endregion
                 
                 #region Stop IIS
                 iisreset /stop | Out-Null
                 Write-Output -InputObject 'Stopped IIS service.'
                 #endregion

                 #region Deploy IIS
                 Try
                 {
                    $ExpandedFolder = $TempFolder + '\' + $ArchiveFolderName + '\*'

                    $IISFolder = 'C:\inetpub\wwwroot'
                 
                    Copy-Item `
                            -Path $ExpandedFolder  `
                            -Destination $IISFolder `
                            -Force `
                            -Recurse `
                            -ErrorAction Stop
                    Write-Output -InputObject 'Replaced IIS files.'
                 }
                 Catch
                 {
                    $ErrorMessage = 'Failed to replace IIS files in ' + $IISFolder
                    $ErrorMessage += " `n"
                    $ErrorMessage += 'Error: '
                    $ErrorMessage += $_
                    Write-Error `
                        -Message $ErrorMessage `
                        -ErrorAction Stop
                 
                 }
                 #endregion

                 #region Start IIS
                 iisreset /start | Out-Null
                 Write-Output -InputObject 'Started IIS Service.'
                 #endregion

                 #region Delete Temp
                 Remove-Item `
                   -Path $TempFolder `
                   -Recurse `
                   -Force `
                   -ErrorAction Stop
                #endregion

                }  -Args $RepositoryName, $branch, $repositoryURL
    }
    Catch
    {
        $ErrorMessage = 'Could not invoke command on Azure VM.'
        $ErrorMessage += " `n"
        $ErrorMessage += 'Error: '
        $ErrorMessage += $_
        Write-Error `
            -Message $ErrorMessage `
            -ErrorAction Stop
    }
    #endregion