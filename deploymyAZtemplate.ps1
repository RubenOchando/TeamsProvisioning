get-module
Connect-AzAccount
New-AzResourceGroup -Name testdeleteasap -Location "westeurope"

$templateFile = "{provide-the-path-to-the-template-file}"

New-AzResourceGroupDeployment `
  -Name blanktemplate `
  -ResourceGroupName myResourceGroup `
  -TemplateFile $templateFile