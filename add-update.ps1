if ($null -eq $env:System_HostType)
{
    ### when working from local 
    $AZURE_SUBSCRIPTION_ID_DEV = '06cfa029-270f-4e02-a9b2-79ef2c3b7155' #"e96ed8d4-2224-445d-a27b-d1523a78bfe6"             # stage
    $AZURE_TENANT_ID = 'fbd88c40-d25c-40f9-978f-1a689d61685e' #'5a20405e-b9ea-44f4-9a30-2332cdf8b41b'                       # release
  #  $AzSubscName = 'AIS Dev/UAT' #"MBS-AZUREUK-DEV-02"                                  # stage

    $AZURE_LA_RESOURCE_GROUP_DEV = 'ais-dev-rg-services'          # release

    $ProjectName = "FoundTest-Test"                                                 # release
    $CustomerName = "ais"                                                           # release
    
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

    Write-Host "I'm here on laptop."
}
else { 
    Write-Output "I'm here in ADO."
    Write-Output "Setup script's variables values from the ADO release variables"

    $AZURE_LA_RESOURCE_GROUP_DEV = $env:projectResourceGroupName 
    
    $integrationAccountName =  $env:integrationAccountName
    $mapFilesArtefactPath = $env:mapFilesArtefactPath         

    Write-Output " AZURE_LA_RESOURCE_GROUP_DEV = $($AZURE_LA_RESOURCE_GROUP_DEV)"
    Write-Output " integrationAccountName = $($integrationAccountName)"
    Write-Output " mapFilesArtefactPath = $($mapFilesArtefactPath)"

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
    if($set -contains $mapName){
      Write-Host " * replacing $($mapName) from $($mapFile.FullName)"
      Remove-AzIntegrationAccountMap -ResourceGroupName $AZURE_LA_RESOURCE_GROUP_DEV -MapName $mapName -Name $integrationAccountName -Force
      New-AzIntegrationAccountMap -ResourceGroupName $AZURE_LA_RESOURCE_GROUP_DEV -Name $integrationAccountName -MapName $mapName -MapFilePath $mapFile.FullName -MapType Liquid
    }
    else{
    Write-Host " * adding $($mapName) from $($mapFile.FullName)"
    New-AzIntegrationAccountMap -ResourceGroupName $AZURE_LA_RESOURCE_GROUP_DEV -Name $integrationAccountName -MapName $mapName -MapFilePath $mapFile.FullName -MapType Liquid
    }
  }
}


$path = mapsPath
addMaps -mapFilesPath $path
