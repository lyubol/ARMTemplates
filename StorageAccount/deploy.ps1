$resource_group = 'arm-introduction-01'
New-AzResourceGroup -Name $resource_group -Location 'North Europe' -Force

New-AzResourceGroupDeployment  `
    -Name 'new-storage' `
    -ResourceGroupName $resource_group `
    -TemplateFile '01-storage.json' `
    -storageName 'armstorage013' `
    -storageSKU 'Standard_LRS'