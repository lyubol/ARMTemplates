# Define resource groups
$resource_group = 'arm-dependencies'

# Deploy resource groups
New-AzResourceGroup -Name $resource_group -Location 'North Europe' -Force

# Deploy template
New-AzResourceGroupDeployment  `
    -Name 'dependencies-deployment' `
    -ResourceGroupName $resource_group `
    -TemplateFile 'storage-container-webapp.json'
