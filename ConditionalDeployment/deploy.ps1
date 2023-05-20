# Define resource groups
$resource_group = 'arm-condition-deployments-02'

# Deploy resource groups
New-AzResourceGroup -Name $resource_group -Location 'North Europe' -Force

# Deploy template
New-AzResourceGroupDeployment  `
    -Mode 'Complete' `
    -Name 'conditions-deployment-latest' `
    -ResourceGroupName $resource_group `
    -TemplateFile 'condition-sqlserver.json'