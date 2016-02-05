#ARM Template Test Solution

##Requirements
* PowerShelll version 5
* AzureRM.profile PowerShell module
* AzureRM.Resources PowerShell Module

##Folders and Files
1. **ARMTemplateTest** folder
  1. **ARMTemplateTest.psd1** - PowerShell Module Manifest File
  2. **ARMTemplateTest.psm1** - PowerShell Script Module
  3. **id_rsa** - File needed for SSH Key used during testing
  4. **id_rsa.pub** - File needed for SSH Key used during testing
2. **Test-ARMTemplateInParallel.ps1** - Script containing PowerShell Workflow that can be used for executing ARM Template Tests in parallel
3. **Format ErrorReport Guide.docx** - Guide on formatting the error report
4. **ARM Template Test Workflow.vsdx** - Visio diagram representing the Test-ARMTemplate cmdlet

##Importing ARM Template Test PowerShell Module
1. Copy folder **ARMTemplateTest** and its content to %ProgramFiles%\WindowsPowerShell\Modules

##Using PowerShell Help
* Execute the following command to get all cmdlets in ARMTemplateTest module

```Get-Command -Module ARMTemplateTest```

* Execute the following command to get basic help for particular cmdlet

```Get-Help -Name Test-ARMTemplate```

* Execute the following command to get examples for particular cmdlet

```Get-Help -Name Test-ARMTemplate -Examples```

* Execute the following command to get full help for particular cmdlet

```Get-Help -Name Test-ARMTemplate -Full```

* Execute the following command to get help for particular parameter from particular cmdlet

```Get-Help -Name Test-ARMTemplate -Parameter ChangeLocationParameterValue```

* Execute the following command to get help for particular cmdlet into Window

```Get-Help -Name Test-ARMTemplate -ShowWindow```

##Using ARM Template Test PowerShell Module
The module has 19 cmdlets but the most important one is Test-ARMTemplate. All other cmdlets help for the execution of Test-ARMTemplate.

Test-ARMTemplate allows you to login via Azure Tenant ID or Azure Subscription ID by using parameters ```-AzureTenantID``` or ```-AzureTenantSubscripton```.

Test-ARMTemplate allows you to test ARM Templates from GitHub Master Repository or from folder by using parameters ```-GitHubRepositoryURL 'https://github.com/Azure/azure-quickstart-templates'``` or ```-ARMTemplatesPath 'D:\ARMTEST\Downloaded'```.

Test-ARMTemplate allows you to change values for some parameters in ARM Template and ARM Template Parameters files by using one of the following parameters  ```-ChangeLocationParameterValue```,  ```-ChangeStorageAccountNameParameterValue```,  ```-ChangeStorageAccountNamePrefixParameterValue```,  ```-ChangeDNSLabelParameterValue```,  ```-ChangePasswordParameterValue```,  ```-ChangeSSHKeyDataParameterValue```,  ```-ChangeVMNameParameterValue```,  ```-ChangeUsrNameParameterValue```,  ```-ChangeAppNameParameterValue```.

By default Test-ARMTemplate outputs only the summary of all ARM Templates at the end. To get more detailed information during execution add parameter ```-InformationAction Continue```.

Test-ARMTemplate expects ARM templates located on GitHub repository to be located in the master repository. The link provided must be to the root of the master repository. Templates must be organized in folders. The name of the folder will be used as Azure Resource Group name during testing. Inside the each folder ARM Template and ARM Template Paramaters files must be present with the following names **azuredeploy.json** and **azuredeploy.parameters.json**.

Test-ARMTemplate expects ARM templates to be organized in folders when local location is used. The name of the folder will be used as Azure Resource Group name during testing. Inside the each folder ARM Template and ARM Template Paramaters files must be present with the following names **azuredeploy.json** and **azuredeploy.parameters.json**. They must be located in folder named 'Downloaded' inside the Output folder. Example when using the cmdlet : ```-ARMTemplatesPath D:\ARMTEST\Downloaded' -OutputPath 'D:\ARMTEST'```.

###ARM Template Paramaters replacement
Parameters in ARM Template and ARM Template Paramaters can be used by using different switches in Test-ARMTemplate. When those switches are used **azuredeploy.json** and **azuredeploy.parameters.json** files will be read. 
After being read the function will go trough the names of every parameter and will try to match it to certain keywords. When there is match the value for that parameter will be replaced. 
Changes are stored in new files respectively **azuredeploy-modified.json** and **azuredeploy.parameters-modified.json**. The modified files are used as ARM Template and ARM Template parameter files for testing deployment.
There are two types of keywords. Keywords that contains particular keyword in the name of the parameter is the first type. 
For example if the keyword is 'location' parameters with names like 'newLocationAzure', 'location', 'newLocation' will be matched and their value will be replaced. For example if the keyword is 'location' parameters with names like 'newLocAzure', 'newLoc' and 'loc' will not be matched and the parameters values will not be replaced. The second type is when the keyword must match exactly the name of the parameter.
For example if keyword is 'publicIPAddressName' the name of the parameter must be exactly 'publicIPAddressName' otherwise it will not be matched. Small and capital letters differences are irrelevant.
The table below represnets what keywords are used and with what values are being replaced.

|cmdlet Parameter                             |Keywords                                        |Exact Keywords                                     |Replaced Value                                                                                             |
| --------------------------------------------|------------------------------------------------|---------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
|ChangeLocationParameterValue                 |'location','region'                             |N/A                                                |value from ```-AzureRegion``` parameter                                                                    |
|ChangeStorageAccountNameParameterValue       |'StorageAccountName'                            |'storageName','newStorageAccount','storageAccount' |10 characters string consisting of small letters and numbers and always starts with letter                 |
|ChangeStorageAccountNamePrefixParameterValue |'StorageAccountNamePrefix'                      |'storageAccountPrefix','accountPrefix'             |5 characters string consisting of small letters and numbers and always starts with letter                  |
|ChangeDNSLabelParameterValue                 |'dnsLabel','dnsName','dnsPrefix','PublicIPName' |'publicIPAddressName','endpointName'               |12 characters string consisting of small letters and numbers and always starts with letter                 |
|ChangePasswordParameterValue                 |'Password'                                      |N/A                                                |10 character complex password consisting of small letters, capital letters, numbers and special characters |
|ChangeSSHKeyDataParameterValue               |N/A                                             |'sshKeyData','sshPublicKey'                        |Valid SSH key take from id_rsa.pub file                                                                    |
|ChangeVMNameParameterValue                   |'vmName','clusterName','vmssName','Servername'  |N/A                                                |8 characters string consisting of small letters                                                            |
|ChangeUsrNameParameterValue                  |'Username','databaseAccountName'                |'administratorLogin'                               |8 characters string consisting of small letters. First letters are always 'user'                           |
|ChangeAppNameParameterValue                  |'AppName','PlanName'                            |N/A                                                |8 characters string consisting of small letters                                                            |

#Using Test-ARMTemplateInParallel PowerShell Workflow
PowerShell Workflow is similiar to PowerShell Script. Workflows allows you in easy way to execute tasks in parallel. 
Test-ARMTemplateInParallel is more or less the same code as Test-ARMTemplate cmdlet but allows you to test ARM Templates in parallel. 
You can specify number of parallel operations which will allow you to test that number of ARM Templates at the same time. For example you have 100 ARM Templates to test. 
You can test those templates with Test-ARMTemplate cmdlet one by one or use Test-ARMTemplateInParallel workflow to test them in batches of 5 meaning during excution there will be always 5 ARM templates that
are tested at the same time. Test-ARMTemplateInParallel workflow has the same paremeters as Test-ARMTemplate cmdlet plus one additional parameter ```-ParallelTests```.
When you use that parameter you can specify integer number of parallel tests. For example ```-ParallelTests 4``` will test 4 templates at the same time. The default value is 3 and if you do not include that parameter
3 ARM Templates will be tested at the same time.

**Note**: Parallel testing is good but be careful to not specify too big number as during testing you might hit some of the limitations of Azure like cores or storage accounts which influence the results of the tests.

To use Test-ARMTemplateInParallel workflow:
1. Open Test-ARMTemplateInParallel.ps1 in PowerShell ISE.
2. Execute the code in Test-ARMTemplateInParallel.ps1 either by pressing F5 or selecting all the code and pressing F8.
3. In the console type ```Test-ARMTemplateInParallel``` and add all the parameters for your case.
4. Execute the command with your parameters. 

**Note**: Because of the nature of PowerShell workflow if parameter is missing from ARM Template parameters file 
but is present in the ARM Template file this will result into error unlike with Test-ARMTemplate cmdlet where you will be asked in the console to enter the value for that parameter. 
The error from the workflow will be shown in the console as warning, the process for other ARM templates will continue. The Resource Group will be deleted and the template will be moved to BadError folder.