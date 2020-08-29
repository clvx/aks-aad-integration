terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.25.0"
    }
  }
  backend "azurerm" {
  }

}


# Configure the Azure provider
provider "azurerm" {
  features {}
}
