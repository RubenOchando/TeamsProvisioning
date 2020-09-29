# Provision storage and function app
$userNameDestination = "ro@ptaken.no"
$secureString = "C:\Users\ruoch\Documents\PT\Project\PTAKEN\ropass.txt"
$UserCredential= New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $userNameDestination, (Get-Content $secureString | ConvertTo-SecureString)

Connect-AzAccount -Credential $UserCredential


.\Deploy-AzureResourceGroup.ps1 `
    -ResourceGroupLocation westeurope `
    -ResourceGroupName ptrohdevopsRG2a `
    -StorageAccountName stgptrohgrap `
    -TemplateParametersFile prod.parameters.json

# Ensure storage queues are in place
$storageAccount = Get-AzStorageAccount | Where-Object ResourceGroupName -eq "ptrohdevopsRG2a"
$storageContext = $storageAccount.Context
New-AzStorageQueue -Name "create-team-request-queue" -Context $storageContext -ErrorAction Ignore
New-AzStorageQueue -Name "create-team-completion-queue" -Context $storageContext -ErrorAction Ignore
New-AzStorageQueue -Name "clone-team-request-queue" -Context $storageContext -ErrorAction Ignore
New-AzStorageQueue -Name "clone-team-completion-queue" -Context $storageContext -ErrorAction Ignore




