https://digital.ai/periodic-table-of-devops-tools


~~~

az login
az account show --query tenantId -o tsv                                             # TENANT_ID
az account show --query id -o tsv                                                   # SUBSCRIPTION_ID
az ad sp create-for-rbac -n tf-sp-dev --role Contributor --query password -o tsv    # TF_ServicePrincipal_SECRET
az ad sp show --id http://tf-sp-dev --query appId -o tsv                            # TF_ServicePrincipal_ID


az group create -n tfstate-rg-dev -l westus
az storage account create -g tfstate-rg-dev -n tfstate-store-dev --sku Standard_LRS --encryption-services blob
TFSTATE_STORAGE_ACCOUNT_KEY=$(az storage account keys list -g tfstate-rg-dev --account-name tfstate-store-dev --query [0].value -o tsv)
az storage container create -n tfstate-blob-dev --account-name tfstate-store-dev --account-key $TFSTATE_STORAGE_ACCOUNT_KEY
az group lock create --lock-type CanNotDelete -n CanNotDelete -g tfstate-rg-dev

~~~


