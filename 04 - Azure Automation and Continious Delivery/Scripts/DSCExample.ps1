
# Variables to set
$AzureSubscriptionID = '3c1d65g1-4064-4522-94e4-e0378165922e'
$AutomationAccountResourceGroupName = 'Contoso'
$AutomationAccountName = 'Contoso4'
$DomainJoinConfigPath = 'C:\CSP\WorkgroupToDomain.ps1'
$VM = 'ContosoVM02'
$DomainName = 'contoso.com'

# Static Variables
$DomainJoinConfigName = 'WorkgroupToDomain'


# Login to Azure
Add-AzureRmAccount `
 -Credential (Get-Credential) `
 -SubscriptionId $AzureSubscriptionID `

# Import DSC Configuration
Import-AzureRmAutomationDscConfiguration `
    -SourcePath $DomainJoinConfigPath `
    -Description 'Configuration for Domain Join' `
    -ResourceGroupName $AutomationAccountResourceGroupName `
    -AutomationAccountName $AutomationAccountName `
    -Published `
    -force

# Configuration Data
$ConfigData = @{
    AllNodes = @(
         @{
            NodeName = '*'
            PSDscAllowPlainTextPassword = $True
        },

        @{
            NodeName = $VM
            DomainName = $DomainName
        }
    )
} 

# Compile DSC Configuration to Node Configuration
$CompilationJob = Start-AzureRmAutomationDscCompilationJob `
                    -ResourceGroupName $AutomationAccountResourceGroupName `
                    -AutomationAccountName $AutomationAccountName `
                    -ConfigurationName $DomainJoinConfigName `
                    -ConfigurationData $ConfigData

# Wait for Complication to finish
 while($CompilationJob.EndTime –eq $null -and $CompilationJob.Exception –eq $null)           
{$CompilationJob = $CompilationJob | Get-AzureRmAutomationDscCompilationJob
    Start-Sleep -Seconds 3

}

# Compliation job output
$CompilationJob | Get-AzureRmAutomationDscCompilationJobOutput –Stream Any 

# Get Azure Automation DSC Node
$NodeObj = Get-AzureRmAutomationDscNode `
    -Name $VM `
    -ResourceGroupName $AutomationAccountResourceGroupName `
    -AutomationAccountName $AutomationAccountName

# Get Azure Automation Node Configuration
$ConfigurationObj = Get-AzureRmAutomationDscNodeConfiguration `
    -ConfigurationName $DomainJoinConfigName `
    -ResourceGroupName  $AutomationAccountResourceGroupName `
    -AutomationAccountName $AutomationAccountName

# Apply DSC node Configuration to DSC Node
Set-AzureRmAutomationDscNode `
    -NodeConfigurationName $ConfigurationObj.Name `
    -Id  $NodeObj.Id `
    -ResourceGroupName $AutomationAccountResourceGroupName `
    -AutomationAccountName $AutomationAccountName `
    -Force 

# Execute locally on the machine
Update-DscConfiguration -Wait -Verbose

# Verify Compliance 
Get-AzureRmAutomationDscNode `
    -Id $NodeObj.Id `
    -ResourceGroupName $AutomationAccountResourceGroupName `
    -AutomationAccountName $AutomationAccountName