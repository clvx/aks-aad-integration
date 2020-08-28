terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.25.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = var.tf_backend_rg
    storage_account_name = var.tf_backend_storage
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

}


# Configure the Azure provider
provider "azurerm" {
  features {}
}
