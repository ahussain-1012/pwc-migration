resource "azurerm_storage_account" "storage" {
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  name                     = var.storage_name
  account_kind             = "Storage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_linux_virtual_machine" "internal_fw0" {
  depends_on = [
    azurerm_storage_account.storage,
    azurerm_network_interface.fw0_outbound_nic0,
    azurerm_network_interface.fw0_untrust_nic1,
    azurerm_network_interface.fw0_trust_nic2
  ]
  admin_username                  = var.fw_username
  admin_password                  = var.fw_password
  computer_name                   = "${var.fw_hostname}-0"
  name                            = "${var.fw_hostname}-0"
  disable_password_authentication = "false"
  encryption_at_host_enabled      = "false"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.fw_size
  network_interface_ids           = [azurerm_network_interface.fw0_outbound_nic0.id, azurerm_network_interface.fw0_untrust_nic1.id, azurerm_network_interface.fw0_trust_nic2.id]

  boot_diagnostics {
    storage_account_uri = "http://${var.storage_name}.blob.core.windows.net"
  }
  os_disk {
    caching                   = "ReadWrite"
    name                      = "${var.fw_hostname}0-osdisk"
    storage_account_type      = "Standard_LRS"
  }
  plan {
    name      = "bundle1"
    product   = "vmseries1"
    publisher = "paloaltonetworks"
  }
  source_image_reference {
    offer     = "vmseries1"
    publisher = "paloaltonetworks"
    sku       = "bundle1"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "internal_fw1" {
  depends_on = [
    azurerm_storage_account.storage,
    azurerm_network_interface.fw1_outbound_nic0,
    azurerm_network_interface.fw1_untrust_nic1,
    azurerm_network_interface.fw1_trust_nic2
  ]
  admin_username                  = var.fw_username
  admin_password                  = var.fw_password
  computer_name                   = "${var.fw_hostname}-1"
  name                            = "${var.fw_hostname}-1"
  disable_password_authentication = "false"
  encryption_at_host_enabled      = "false"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.fw_size
  network_interface_ids           = [azurerm_network_interface.fw1_outbound_nic0.id, azurerm_network_interface.fw1_untrust_nic1.id, azurerm_network_interface.fw1_trust_nic2.id]

  boot_diagnostics {
    storage_account_uri = "http://${var.storage_name}.blob.core.windows.net"
  }
  os_disk {
    caching                   = "ReadWrite"
    name                      = "${var.fw_hostname}1-osdisk"
    storage_account_type      = "Standard_LRS"
  }
  plan {
    name      = "bundle1"
    product   = "vmseries1"
    publisher = "paloaltonetworks"
  }
  source_image_reference {
    offer     = "vmseries1"
    publisher = "paloaltonetworks"
    sku       = "bundle1"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "fw0_outbound_nic0" {
  ip_configuration {
    name                          = "${var.fw_hostname}0-mgmt"
    primary                       = "true"
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.mgmt_pip0.id
    subnet_id                     = azurerm_subnet.mgmt_snet.id
  }

  location            = azurerm_resource_group.rg.location
  name                = "${var.fw_hostname}0-mgmt0"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_interface" "fw0_untrust_nic1" {
  enable_ip_forwarding          = "true"

  ip_configuration {
    name                          = "${var.fw_hostname}0-untrust"
    primary                       = "true"
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.untrust_pip0.id
    subnet_id                     = azurerm_subnet.untrust_snet.id
  }

  location            = azurerm_resource_group.rg.location
  name                = "${var.fw_hostname}0-untrust1"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_interface" "fw0_trust_nic2" {
  enable_ip_forwarding          = "true"

  ip_configuration {
    name                          = "${var.fw_hostname}0-trust"
    primary                       = "true"
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    subnet_id                     = azurerm_subnet.trust_snet.id
  }

  location            = azurerm_resource_group.rg.location
  name                = "${var.fw_hostname}0-trust2"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_interface" "fw1_outbound_nic0" {
  ip_configuration {
    name                          = "${var.fw_hostname}1-mgmt"
    primary                       = "true"
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.mgmt_pip1.id
    subnet_id                     = azurerm_subnet.mgmt_snet.id
  }

  location            = azurerm_resource_group.rg.location
  name                = "${var.fw_hostname}1-mgmt0"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_interface" "fw1_untrust_nic1" {
  enable_ip_forwarding          = "true"

  ip_configuration {
    name                          = "${var.fw_hostname}1-untrust"
    primary                       = "true"
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.untrust_pip1.id
    subnet_id                     = azurerm_subnet.untrust_snet.id
  }

  location            = azurerm_resource_group.rg.location
  name                = "${var.fw_hostname}1-untrust1"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_interface" "fw1_trust_nic2" {
  enable_ip_forwarding          = "true"

  ip_configuration {
    name                          = "${var.fw_hostname}1-trust"
    primary                       = "true"
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    subnet_id                     = azurerm_subnet.trust_snet.id
  }

  location            = azurerm_resource_group.rg.location
  name                = "${var.fw_hostname}1-trust2"
  resource_group_name = azurerm_resource_group.rg.name
}

