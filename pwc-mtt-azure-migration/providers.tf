terraform {
  required_providers { # Define the required providers and their version for the module
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.98.0" # Set the module to require this version OR greater
    }
    aviatrix = {
      source  = "aviatrixsystems/aviatrix"
    }
  }
}

provider "aviatrix" {
  controller_ip           = var.controller_ip
  username                = var.controller_username
  password                = var.controller_password
  skip_version_validation = true
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}
