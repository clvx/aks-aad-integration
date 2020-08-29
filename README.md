# Terraform implementation of AKS integrated with Azure AD 


## Prerequisites 

- An Azure Service Principal has been already provisioned with enough privileges
to manage AKS and AD.
    - SP credentials are being saved in `.key.json`

## Terraform variables

Load the following variables in your `*.tfvars` file:

    resource_group_name = ""
    location            = ""
    admin_username      = ""
    cluster_name        = ""
    dns_prefix          = ""
    aad_organization    = ""
    aad_user_password   = ""

## Login to Azure

### Loading Azure SP variables

    export CLIENT_ID=$(cat .key.json | jq -r .sp.appId)
    export CLIENT_SECRET=$(cat .key.json | jq -r .sp.password)
    export TENANT_ID=$(cat .key.json | jq -r .sp.tenant)

> Unless the service principal has all the necessary privileges, avoid this shit and just use your regular user.
### Login as the SP

    az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET --tenant $TENANT_ID

### Loading Azure variables for Terraform

    export ARM_CLIENT_ID=$CLIENT_ID
    export ARM_CLIENT_SECRET=$CLIENT_SECRET
    export ARM_TENANT_ID=$TENANT_ID
    export ARM_SUBSCRIPTION_ID=$(az account list | jq -r .[0].id)

### Terraform vars for AKS service principal

    export TF_VAR_sp_client_id=$CLIENT_ID
    export TF_VAR_sp_client_secret=$CLIENT_SECRET

### Connecting to Azure storage

    
    cat < EOF >> azure.tfbackend
    resource_group_name  = "<resource_group>"
    storage_account_name = "<storage_account_name>"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    EOF

    terraform init -backend-config=azure.tfbackend


### Connecting to AKS

    export ARM_RG=<aks-resource-group>
    export ARM_CLUSTER_NAME=<aks-cluster-name>

    # To connect to AKS as a cluster admin
    az aks get-credentials --resource-group $ARM_RG --name $ARM_CLUSTER_NAME --overwrite-existing --admin  -f ./config

    # To connect to AKS as a regular user
    # Proper roles/rolebinding configuration had to be defined to be usable 
    az aks get-credentials --resource-group $ARM_RG --name $ARM_CLUSTER_NAME --overwrite-existing


## Documentation

AKS, RBAC and managed AAD: 

- https://docs.microsoft.com/en-us/azure/aks/azure-ad-rbac
- https://docs.microsoft.com/en-us/azure/aks/managed-aad
- https://docs.microsoft.com/en-us/azure/developer/terraform/create-k8s-cluster-with-tf-and-aks
- https://learn.hashicorp.com/tutorials/terraform/aks
- https://docs.microsoft.com/en-us/azure/aks/azure-ad-integration-cli

Azure terraform modules:

- https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html
- https://www.terraform.io/docs/providers/azuread/r/group_member.html
- https://www.terraform.io/docs/providers/azuread/r/user.html
- https://www.terraform.io/docs/providers/azurerm/r/role_assignment.html

 Creating a service principal:

- https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html
