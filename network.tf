resource "azurerm_virtual_network" "terraform_network" {
    name                = "demo_network"
    address_space       = ["192.168.0.0/16"]
    # location            = azurerm_resource_group.terraform_group.location
    # resource_group_name = azurerm_resource_group.terraform_group.name
    location                     = "East US"
    resource_group_name          = "demo_group"

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_network_interface" "adapter_network" {
    name                        = "demo_adapter_network"
    # location                    = azurerm_resource_group.terraform_group.location
    # resource_group_name         = azurerm_resource_group.terraform_group.name
    location                     = "East US"
    resource_group_name          = "demo_group"

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.public_subnet.id
        private_ip_address_allocation = "Dynamic"
        # public_ip_address_id          = azurerm_public_ip.terraform_public_ip.id
        public_ip_address_id          = "/subscriptions/seu_numero_da_conta_azure/resourceGroups/demo_group/providers/Microsoft.Network/publicIPAddresses/demo_public_ip"
    }

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_network_interface_security_group_association" "connect_security_group_to_network" {
    network_interface_id      = azurerm_network_interface.adapter_network.id
    network_security_group_id = azurerm_network_security_group.allow_security.id
}
