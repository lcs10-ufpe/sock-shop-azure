resource "azurerm_linux_virtual_machine" "vm" {
    name                  = "demo"
    # location              = azurerm_resource_group.terraform_group.location
    # resource_group_name   = azurerm_resource_group.terraform_group.name
    location                     = "East US"
    resource_group_name          = "demo_group"
    network_interface_ids = [azurerm_network_interface.adapter_network.id]
    size                  = "Standard_F4"

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    admin_username = "lcs10"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "lcs10"
        public_key     = file("key/demo_key.pub")
    }

    tags = {
        environment = "Terraform Demo"
    }
}

data "azurerm_public_ip" "public_ip_address" {
  # name                = azurerm_public_ip.terraform_public_ip.name
  name                = "demo_public_ip"
  resource_group_name = azurerm_linux_virtual_machine.vm.resource_group_name
}

data "template_file" "hosts" {
	template = file("./template/hosts.tpl")

	vars = {
		PUBLIC_IP_0 = data.azurerm_public_ip.public_ip_address.ip_address
	}
}

resource "local_file" "hosts" {
  content = data.template_file.hosts.rendered
  filename = "./hosts"
}

output "public_ip" {
  value = data.azurerm_public_ip.public_ip_address.ip_address
}