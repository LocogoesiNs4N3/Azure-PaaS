# Create Service Fabric Cluster in Azure

New-AzureRmResourceGroupDeployment -Name preview -ResourceGroupName (New-AzureRmResourceGroup -Name SF10US -Location "west us").ResourceGroupName -TemplateFile 'https://raw.githubusercontent.com/Lumagate/Azure-PaaS/master/05%20-%20Azure%20Service%20Fabric%20and%20Containers/ARM%20Templates/azuredeploy.json' -clusterLocation 'west us' -clusterName knsfcl01 -adminUserName knadmin -storageAccountType Standard_LRS -Verbose

# Show Service Fabric cluster in Azure

$rg = Get-AzureRmResourceGroup -Name SF10us
$sf = Get-AzureRmResource -ResourceGroupName $rg.ResourceGroupName -ResourceName knsfcl01 -ResourceType Microsoft.ServiceFabric/Clusters
$sf.Properties.ManagementEndpoint

$vm = Get-AzureRmVM -ResourceGroupName $rg.ResourceGroupName -Name sfcnode1

$vm.Extensions

$vm.ExtensionsText

Get-AzureRmResource -ResourceType Microsoft.ServiceFabric/clusters -ResourceName knsfcl01 -ResourceGroupName $rg.ResourceGroupName

# Connect to Service Fabric Cluster in Azure

$sfcluster = Connect-ServiceFabricCluster -ConnectionEndpoint knsfcl01.westus.cloudapp.azure.com:19000 -Verbose

# Connect to Service Fabric local cluster

Connect-ServiceFabricCluster localhost:19000

# Import PSModule

Import-Module "$ENV:ProgramFiles\Microsoft SDKs\Service Fabric\Tools\PSModule\ServiceFabricSDK\ServiceFabricSDK.psm1"

# Download the sample application

mkdir -Path c:\appdemo\

Invoke-WebRequest -Uri "http://aka.ms/servicefabric-wordcountapp" -OutFile "C:\appdemo\WordCountV1.sfpkg"

# Deploy a sample application to the local service fabric cluster

Publish-NewServiceFabricApplication -ApplicationPackagePath C:\appdemo\WordCountV1.sfpkg -ApplicationName "fabric:/WordCount" -Verbose

# Verify the application and service

Start-Process http://knsfcl01.westus.cloudapp.azure.com:19080

Get-ServiceFabricApplication -ApplicationName 'fabric:/WordCount'

Get-ServiceFabricService -ApplicationName 'fabric:/WordCount'

Get-ServiceFabricPartition 'fabric:/WordCount/WordCountService'

Get-ServiceFabricPartition 'fabric:/WordCount/WordCountWebService'

# Update the application

# Download upgraded app

mkdir c:\appupdate

Invoke-WebRequest "http://aka.ms/servicefabric-wordcountappv2" -OutFile "c:\appupdate\WordCountv2.sfpkg"

Publish-UpgradedServiceFabricApplication -ApplicationPackagePath C:\appupdate\WordCountv2.sfpkg -ApplicationName "fabric:/WordCount" -UpgradeParameters @{"FailureAction"="Rollback"; "UpgradeReplicaSetCheckTimeout"=1; "Monitored"=$true; "Force"=$true}


