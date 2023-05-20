# Define resource groups
$resource_group = 'arm-copyloops'

# Deploy resource groups
New-AzResourceGroup -Name $resource_group -Location 'North Europe' -Force

# Deploy template
New-AzResourceGroupDeployment  `
    -Mode 'Complete' `
    -Name 'copyloops-deployment-latest' `
    -ResourceGroupName $resource_group `
    -TemplateFile 'copyloop-storage-output.json'