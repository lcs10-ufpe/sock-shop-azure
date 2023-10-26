# resource "azurerm_resource_group" "terraform_group" {
#     name     = "demo_group"
#     location = "East US"

#     tags = {
#         environment = "Terraform Demo"
#     }
# }

resource "azurerm_subnet" "public_subnet" {
    name                 = "demo_public_subnet"
    # resource_group_name  = azurerm_resource_group.terraform_group.name
    resource_group_name  = "demo_group"
    virtual_network_name = azurerm_virtual_network.terraform_network.name
    address_prefixes       = ["192.168.0.0/24"]
}

# resource "azurerm_public_ip" "terraform_public_ip" {
#     name                         = "demo_public_ip"
#     location                     = azurerm_resource_group.terraform_group.location
#     resource_group_name          = azurerm_resource_group.terraform_group.name
#     allocation_method            = "Static"

#     tags = {
#         environment = "Terraform Demo"
#     }
# }
