Configuration IISWebSite
{
    param(
        [string] $WebsitePath = "C:\inetpub\wwwroot",
        [string] $WebAppName = "Default Web Site",
        [int32] $WebsitePort = 80,
        [string] $WebDeployURI = "https://github.com/Lumagate/Azure-PaaS/raw/master/04%20-%20Azure%20Automation%20and%20Continious%20Delivery/IISExamplePage/WebDeploy_amd64_en-US.msi",
        [string] $WebPackageURI = "https://github.com/Lumagate/Azure-PaaS/raw/master/04%20-%20Azure%20Automation%20and%20Continious%20Delivery/IISExamplePage/IISPackage.zip",
        [string] $WebPackagePath = "C:\data\IISPackage.zip"
    )

    Import-DSCResource -Module xWebAdministration
    Import-DSCResource -Module xWebDeploy
    Import-DSCResource -Module xNetworking
    Import-DscResource -module xPSDesiredStateConfiguration

    #Configure IIS 
    Node IIS
    {
        # Install IIS and  Web Management Tools
        WindowsFeature InstallWebServer
        {
            Name = "Web-server"
            Ensure = "Present"
            IncludeAllSubFeature = $true
         }

        WindowsFeature InstallIISManagementTools
        {
            Name = "Web-Mgmt-Tools"
            Ensure = "Present"
            IncludeAllSubFeature = $true
         }

        File WebsiteDirectory
        {
            Ensure ="Present"
            Type = "Directory"
            DestinationPath = $WebsitePath
        }

        # IIS server prep. Enabling site remote access
        xWebSite DefaultSite
        {
            Ensure = "Present"
            Name = $WebAppName
            PhysicalPath = $WebsitePath
            State = "Started"
            BindingInfo = MSFT_xWebBindingInformation
                          {
                            Protocol = "HTTP"
                            Port = $WebsitePort
                          }
        }
        
        xFireWall EnableRemoteIISAccess
        {
            Name = "IIS_Port"
            Ensure = "Present"
            Access = "Allow"
            State ="Enabled"
            Protocol = "TCP"
            Direction = "Inbound"
            LocalPort = "$WebsitePort"
            Profile = "Any"
        }

        #Deploys  in IIS
        Package InstallWebDeployTool
        {
            Ensure = "Present"
            Path  = $WebDeployURI
            ProductId = "{1A81DA24-AF0B-4406-970E-54400D6EC118}"
            Name = "Microsoft Web Deploy 3.5"
            Arguments = "/quiet"
        }  
        
        xRemoteFile IISSource
        {
            Uri = $WebPackageURI
            DestinationPath = $WebPackagePath
        }

        xWebPackageDeploy DeployWebPackage
        {
            Ensure = "Present"
            SourcePath = $WebPackagePath
            Destination = $WebAppName
        }
   }
}
