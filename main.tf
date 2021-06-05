provider "azurerm" {
    version = "2.5.0"
    features {}
}

resource "azurerm_resource_group" "terraform_test" {
    name = "terraform-main-rg"
    location = "Southeast Asia"
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
        image               = "andyfeetenby/weatherapi"
        cpu                 = "1"
        memory              = "1"
    
        ports {
            port            = 80
            protocol        = "TCP"
        }
    }
}