terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.70.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.3.0"
    }
  }
   backend "azurerm" {
    resource_group_name  = "rg-br-mateusmais-prod"
    storage_account_name = "mateusmaisterraform"
    container_name       = "tfstate"
    key                  = "kubernetes/aks-rancher.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = "6849eec3-5c1d-4629-acce-eadec66cc18c"
  client_id       = "84d28679-2f09-4464-800a-93d34fde3dda"
  client_secret   = "D4D.kslmwNMUNIkf2U6MyupRqLIwi-RVZj"
  tenant_id       = "77f91f97-eeac-4ec0-bff5-a33822b0a029"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}