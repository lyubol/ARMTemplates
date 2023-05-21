# Define variables
$resource_group_name = 'arm-linked-templates'
$resource_group_location = 'North Europe'
$storage_account_name = "tslajhsuye01"
$container_name = "armtemplates"
$local_file_path = "C:\Users\L_L\Desktop\AZ-400\ARMTemplates\LinkedTemplates\web-app.json"
$destination_blob_name = "web-app.json"

# Create resource group
New-AzResourceGroup `
    -Name $resource_group_name `
    -Location $resource_group_location `
    -Force

# Create a new storage account
$storageAccount = New-AzStorageAccount `
    -ResourceGroupName $resource_group_name `
    -Name $storage_account_name `
    -Location $resource_group_location `
    -SkuName "Standard_LRS" `
    -Kind "StorageV2"

# Get storage account key
$storage_account_key = Get-AzStorageAccountKey `
    -ResourceGroupName $resource_group_name `
    -Name $storage_account_name

# Get storage account context
$context = New-AzStorageContext `
    -StorageAccountName $storage_account_name `
    -StorageAccountKey $storage_account_key.value[0] `
    -Protocol Https

# Create a new container in the storage account
New-AzStorageContainer `
    -Context $context `
    -Name $container_name 

# Upload the file to the container
Set-AzStorageBlobContent `
    -Context $context `
    -Container $container_name `
    -File $local_file_path `
    -Blob $destination_blob_name

# Set the SAS token expiry date/time
$expiryTime = (Get-Date).AddDays(2) 

# Get storage account context
$context = New-AzStorageContext `
    -StorageAccountName $storage_account_name `
    -StorageAccountKey $storage_account_key.value[0] `
    -Protocol Https

# Generate the SAS token for the blob
$sasToken = New-AzStorageBlobSASToken -Container $container_name -Blob $storage_account_name -Permission r -ExpiryTime $expiryTime -Context $context

# Construct the SAS URL for the blob
$blobSasUrl = "https://$storage_account_name.blob.core.windows.net/$container_name/$destination_blob_name?$sasToken"

# Deploy template
New-AzResourceGroupDeployment  `
    -Mode 'Incremental' `
    -Name 'linked-template-deployment' `
    -ResourceGroupName $resource_group_name `
    -TemplateFile 'linked-templates.json' `
    -templateSasUri $blobSasUrl