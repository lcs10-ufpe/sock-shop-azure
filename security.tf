resource "azurerm_network_security_group" "allow_security" {
    name                = "demo_allow_security"
    # location            = azurerm_resource_group.terraform_group.location
    # resource_group_name = azurerm_resource_group.terraform_group.name
    location                     = "East US"
    resource_group_name          = "demo_group"

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["22", "8080", "80"]
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Terraform Demo"
    }
}