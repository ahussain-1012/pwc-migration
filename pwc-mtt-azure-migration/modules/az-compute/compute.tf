resource "azurerm_resource_group" "compute_rg" {
  name = var.rg
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_name
  resource_group_name      = azurerm_resource_group.compute_rg.name
  location                 = azurerm_resource_group.compute_rg.location
  account_kind             = "Storage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_linux_virtual_machine" "vm" {
  depends_on = [
    azurerm_storage_account.storage,
    azurerm_network_interface.vm_nic
  ]
  name                            = var.vm_hostname
  computer_name                   = var.vm_hostname
  location                        = azurerm_resource_group.compute_rg.location
  admin_username                  = var.vm_username
  admin_password                  = var.vm_password
  resource_group_name             = azurerm_resource_group.compute_rg.name
  size                            = var.vm_size
  network_interface_ids           = [azurerm_network_interface.vm_nic.id]
  disable_password_authentication = "false"
  encryption_at_host_enabled      = "false"

  boot_diagnostics {
    storage_account_uri = "http://${var.storage_name}.blob.core.windows.net"
  }
  os_disk {
    caching                   = "ReadWrite"
    name                      = "osdisk"
    storage_account_type      = "Standard_LRS"
  }
  source_image_reference {
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "vm_nic" {
  ip_configuration {
    name                          = "ipconfig1"
    primary                       = "true"
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    subnet_id                     = var.subnet_id
  }

  location            = azurerm_resource_group.compute_rg.location
  name                = "${var.vm_hostname}_nic"
  resource_group_name = azurerm_resource_group.compute_rg.name
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  depends_on = [
    azurerm_linux_virtual_machine.vm
  ]
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_security_group" "nsg" {
  location            = azurerm_resource_group.compute_rg.location
  resource_group_name = azurerm_resource_group.compute_rg.name
  name                = "${var.vm_hostname}_nsg"
}

