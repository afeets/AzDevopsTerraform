provider "azurerm" {
    version = "2.5.0"
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name         = "Terraform_blob_storage"
        storage_account_name        = "saterraformawf"
        container_name              = "tfstate"
        key                         = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" "terraform_test" {
    name = "terraform-main-rg"
    location = "Southeast Asia"
}

variable "image_build_id" {
  type        = string
  description = "Latest Image Build Version"
}

resource "azurerm_container_group" "terraform_test_container" {
    name                    = "weatherapi"
    location                = azurerm_resource_group.terraform_test.location
    resource_group_name     = azurerm_resource_group.terraform_test.name

    ip_address_type         = "public"
    dns_name_label          = "andyfeetenby"
    os_type                 = "Linux"

    container {
        name                = "weatherapi"
        image               = "andyfeetenby/weatherapi:${var.image_build_id}"
        cpu                 = "1"
        memory              = "1"
    
        ports {
            port            = 80
            protocol        = "TCP"
        }
    }
}