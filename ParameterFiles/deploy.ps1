# Define resource groups
$resource_group_dev = 'arm-parametrization-dev'
$resource_group_prod = 'arm-parametrization-prod'

# Deploy resource groups
New-AzResourceGroup -Name $resource_group_dev -Location 'North Europe' -Force
New-AzResourceGroup -Name $resource_group_prod -Location 'North Europe' -Force

# Deploy template with dev parameters
New-AzResourceGroupDeployment  `
    -Name 'dev-deployment' `
    -ResourceGroupName $resource_group_dev `
    -TemplateFile '02-storage.json' `
    -TemplateParameterFile '02-storage.parameters-dev.json'

# Deploy template with prod parameters
New-AzResourceGroupDeployment `
    -Name 'prod-deployment' `
    -ResourceGroupName $resource_group_prod `
    -TemplateFile '02-storage.json' `
    -TemplateParameterFile '02-storage.parameters-prod.json'