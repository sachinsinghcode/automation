if ($null -eq $env:System_HostType)
{
    ### when working from local 
    $AZURE_SUBSCRIPTION_ID_DEV = '06cfa029-270f-4e02-a9b2-79ef2c3b7155' #"e96ed8d4-2224-445d-a27b-d1523a78bfe6"             # stage
    $AZURE_TENANT_ID = 'fbd88c40-d25c-40f9-978f-1a689d61685e' #'5a20405e-b9ea-44f4-9a30-2332cdf8b41b'                       # release
  #  $AzSubscName = 'AIS Dev/UAT' #"MBS-AZUREUK-DEV-02"                                  # stage

    $AZURE_LA_RESOURCE_GROUP_DEV = 'ais-dev-rg-services'          # release

  #  $APIM_RG = 'ais-dev-rg-services' #"AIS_Project1"                                                       # stage
  #  $apimName = 'ais-dev-apim-services' # "AISProject1APIM"                                                # stage
  #  $apimUrl = 'https://test.api.kaisservices.co.uk'                               # stage

    $ProjectName = "FoundTest-Test"                                                 # release
    $CustomerName = "ais"                                                           # release

  #  $SecretRetentionPeriod = 90                                                    # release
    
    $integrationAccountName = 'ais-dev-ia-services'
    $mapFilesArtefactPath = "/_KPMG-UK_ewt-ais-emp-la_IA/Maps"
    $IDD_API_Name = "Blob"                                                          # release
    
    $secondsToWaitForSecret = 20

    $APIM_API_Name = "Prj-$($ProjectName)-API-$($IDD_API_Name)"                     # calculated
    $LA_NAME_list =  @('ftst-la-blob-create', 'ftst-la-blob-read', 'ftst-la-blob-update', 'ftst-la-blob-delete')                                           # release
    $LA_Method_List = @('Post', 'Get', 'Put', 'Delete') # release
                                                         
    $LA_Params_list = @( '{params:["filename", "dariustestblob.json"]}','{params:["filename", "dariustestblob.json"]}', '{params:["filename", "dariustestblob.json"]}', '{params:["filename", "dariustestblob.json"]}' )   # release
    $LA_Body_list = @( '{  "Name": "Frank"}', '{}', '{"Name": "Darius"}','{}' )
    $LA_NAME_APIM_Path_List = @('FoundTest-Test-ais-Blob/Create', 'FoundTest-Test-ais-Blob/Get', 'FoundTest-Test-ais-Blob/Update', 'FoundTest-Test-ais-Blob/Delete' )           # release FoundationTesting/BlobStorageMI/Create

    # release
  #  $LA_NAME_list_paths = @('_GitHub-ewt-ais-application/ewt-ais-application-code/Foundation/Keyvault/KeyvaultRead/Workflow.json', '_GitHub-ewt-ais-application/ewt-ais-application-code/Foundation/Blob/BlobCreate/Workflow.json', '_GitHub-ewt-ais-application/ewt-ais-application-code/Foundation/Blob/BlobDelete/Workflow.json', '_GitHub-ewt-ais-application/ewt-ais-application-code/Foundation/Blob/BlobRead/Workflow.json', '_GitHub-ewt-ais-application/ewt-ais-application-code/Foundation/Blob/BlobUpdate/Workflow.json')

    Write-Host "I'm here on laptop."
   # connect-azaccount -Tenant $AZURE_TENANT_ID -Subscription $AZURE_SUBSCRIPTION_ID_DEV
}
else { 
    Write-Output "I'm here in ADO."
    Write-Output "Setup script's variables values from the ADO release variables"
    ### devops variables
    # $AZURE_SUBSCRIPTION_ID_DEV = $env:subscriptionId    #"06cfa029-270f-4e02-a9b2-79ef2c3b7155"
    # $AZURE_TENANT_ID = $env:AZURE_TENANT_ID             #'5a20405e-b9ea-44f4-9a30-2332cdf8b41b'
    # $AzSubscName = $env:Subsciption_Name                #"MBS-AZUREUK-DEV-02"

    $AZURE_LA_RESOURCE_GROUP_DEV = $env:projectResourceGroupName 

    # $APIM_RG = $env:platformResourceGroupName
    # $apimName = $env:APIM_Name                          #"ais-dev-apim"
    # $apimUrl = $env:APIM_Url

    # $ProjectName = $env:Project_Name                    #"AisProject"
    # $CustomerName = $env:Customer_Name

    # $SecretRetentionPeriod = $env:Secret_Retention_Period
    
    $integrationAccountName =  $env:integrationAccountName
    $mapFilesArtefactPath = $env:mapFilesArtefactPath

    # $IDD_API_Name = $env:IDD_API_Name
    # $secondsToWaitForSecret = $env:secondsToWaitForSecret
    # $APIM_API_Name = "Prj-$($ProjectName)-API-$($IDD_API_Name)" 
    # $LA_NAME_list =  __LA_NAME_list__ 
    # $LA_Method_List = __LA_NAME_APIM_Method_List__ 
    # $LA_Params_list = __LA_Params_list__
    # $LA_Body_list = __LA_Body_list__
    # $LA_NAME_APIM_Path_List = __LA_NAME_APIM_Path_List__ 

    # Write-Output " AZURE_SUBSCRIPTION_ID_DEV = $($AZURE_SUBSCRIPTION_ID_DEV)"   
    # Write-Output " AZURE_TENANT_ID = $($AZURE_TENANT_ID)"  
    # Write-Output " AzSubscName = $($AzSubscName)"               

    Write-Output " AZURE_LA_RESOURCE_GROUP_DEV = $($AZURE_LA_RESOURCE_GROUP_DEV)"
    Write-Output " integrationAccountName = $($integrationAccountName)"
    Write-Output " mapFilesArtefactPath = $($mapFilesArtefactPath)"
    # Write-Output " APIM_RG = $($APIM_RG)"
    # Write-Output " apimName = $($apimName)"                      
    # Write-Output " apimUrl = $($apimUrl)"  

    # Write-Output " ProjectName = $($ProjectName)"    
    # Write-Output " CustomerName = $($CustomerName)"

    # Write-Output " SecretRetentionPeriod = $($SecretRetentionPeriod)"
    
    # Write-Output " IDD_API_Name = $($IDD_API_Name)"
    # Write-Output " secondsToWaitForSecret = $($secondsToWaitForSecret)"
    # Write-Output " APIM_API_Name = Prj-$($ProjectName)-API-$($IDD_API_Name)" 
    # Write-Output " LA_NAME_list =  $($LA_NAME_list)"
    # Write-Output " LA_Method_List = $($LA_Method_List)"
    # Write-Output " LA_Params_list = $($LA_Params_list)"
    # Write-Output " LA_Body_list = $($LA_Body_list)"
    # Write-Output " LA_NAME_APIM_Path_List = $($LA_NAME_APIM_Path_List)"
}

function mapsPath {

  if ($null -eq $env:System_HostType)
  {
    $integrationAccountMapFilePath = ""
  }
  else {
    $integrationAccountMapFilePath = "D:\a\r1\a$($mapFilesArtefactPath)".Replace('/','\')
  }
  return $integrationAccountMapFilePath
}

function addMaps {
  param (
    [string] $mapFilesPath
  )
  $filter = "*.liquid"
  Write-Host " * set path: $($mapFilesPath) "
  Set-Location -path "$($mapFilesPath)"

  Write-Host " * get files with filter: $($filter)"
  $mapFiles = Get-ChildItem -Filter $filter

  $existingMaps = Get-AzIntegrationAccountMap -ResourceGroupName $AZURE_LA_RESOURCE_GROUP_DEV -Name $integrationAccountName
  $set = New-Object System.Collections.Generic.HashSet[string]
  foreach ($existingMap in $existingMaps)
  {
    $set.Add($existingMap.Name)
  }
    
  foreach( $mapFile in $mapFiles)
  {
    
    $mapName = $mapFile.Name.ToLower().Replace(".liquid","")
    Write-Host " * adding $($mapName) from $($mapFile.FullName)"
    if($set.ContainsKey($mapName)){
      Remove-AzIntegrationAccountMap -ResourceGroupName $AZURE_LA_RESOURCE_GROUP_DEV -MapName $existingMap.Name -Name $integrationAccountName -Force
      New-AzIntegrationAccountMap -ResourceGroupName $AZURE_LA_RESOURCE_GROUP_DEV -Name $integrationAccountName -MapName $mapName -MapFilePath $mapFile.FullName -MapType Liquid
    }
    else{
    New-AzIntegrationAccountMap -ResourceGroupName $AZURE_LA_RESOURCE_GROUP_DEV -Name $integrationAccountName -MapName $mapName -MapFilePath $mapFile.FullName -MapType Liquid
    }
  }
}

function removeMaps {
  Write-Host " * removing existing maps from IA $($integrationAccountName) in RG $($AZURE_LA_RESOURCE_GROUP_DEV)"
  $existingMaps = Get-AzIntegrationAccountMap -ResourceGroupName $AZURE_LA_RESOURCE_GROUP_DEV -Name $integrationAccountName
  foreach ($existingMap in $existingMaps)
  {
    Write-Host "##[warning] removing map: $($existingMap.Name) from RG: $($AZURE_LA_RESOURCE_GROUP_DEV) and IA: $($integrationAccountName) "
    Remove-AzIntegrationAccountMap -ResourceGroupName $AZURE_LA_RESOURCE_GROUP_DEV -MapName $existingMap.Name -Name $integrationAccountName -Force
  }
}

$path = mapsPath
#removeMaps
addMaps -mapFilesPath $path
