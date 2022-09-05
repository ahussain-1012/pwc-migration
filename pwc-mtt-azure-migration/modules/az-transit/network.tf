resource "azurerm_subnet_network_security_group_association" "mgmtnsg_assoc" {
  network_security_group_id = azurerm_network_security_group.nsg_mgmt.id
  subnet_id                 = azurerm_subnet.mgmt_snet.id
}

resource "azurerm_subnet_network_security_group_association" "tfer--Trust_network_security_group_association" {
  network_security_group_id = azurerm_network_security_group.nsg_trust.id
  subnet_id                 = azurerm_subnet.trust_snet.id
}

resource "azurerm_virtual_network" "vnet" {
  address_space           = var.vnet_cidrs
  location                = azurerm_resource_group.rg.location
  name                    = var.vnet_name
  resource_group_name     = azurerm_resource_group.rg.name
}

resource "azurerm_lb" "internal_lb" {
  frontend_ip_configuration {
    name                          = "${var.lb_name}-fe-ip"
    private_ip_address            = var.lb_static_ip
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
    subnet_id                     = azurerm_subnet.trust_snet.id
  }
  location            = azurerm_resource_group.rg.location
  name                = var.lb_name
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  sku_tier            = "Regional"
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.internal_lb.id
  name                           = "IlbRule"
  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  frontend_ip_configuration_name = "${var.lb_name}-fe-ip"
  probe_id                       = azurerm_lb_probe.hp.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bep.id]
}

resource "azurerm_lb_backend_address_pool" "bep" {
  loadbalancer_id     = azurerm_lb.internal_lb.id
  name                = "${var.fw_hostname}-bep"
}

resource "azurerm_network_interface_backend_address_pool_association" "fw0_trust_nic2_bep" {
  network_interface_id    = azurerm_network_interface.fw0_trust_nic2.id
  ip_configuration_name   = "${var.fw_hostname}0-trust"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bep.id
}

resource "azurerm_network_interface_backend_address_pool_association" "fw1_trust_nic2_bep" {
  network_interface_id    = azurerm_network_interface.fw1_trust_nic2.id
  ip_configuration_name   = "${var.fw_hostname}1-trust"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bep.id
}

resource "azurerm_lb_probe" "hp" {
  interval_in_seconds = "15"
  loadbalancer_id     = azurerm_lb.internal_lb.id
  name                = "${var.fw_hostname}-ewlbprobe"
  number_of_probes    = "2"
  port                = "22"
  protocol            = "Tcp"
}

resource "azurerm_network_security_group" "nsg_mgmt" {
  location            = azurerm_resource_group.rg.location
  name                = "${var.fw_hostname}-mgmtnsg"
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    access                     = "Allow"
    description                = "Rule"
    destination_address_prefix = "*"
    destination_port_range     = "*"
    direction                  = "Inbound"
    name                       = "Allow-Outside-From-IP"
    priority                   = "100"
    protocol                   = "*"
    source_address_prefix      = var.user_ip
    source_port_range          = "*"
  }
}

resource "azurerm_network_security_group" "nsg_trust" {
  location            = azurerm_resource_group.rg.location
  name                = "${var.fw_hostname}-trustnsg"
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    access                     = "Allow"
    destination_address_prefix = "*"
    destination_port_range     = "*"
    direction                  = "Inbound"
    name                       = "Port_Any"
    priority                   = "100"
    protocol                   = "*"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }
}

resource "azurerm_public_ip" "untrust_pip0" {
  allocation_method   = "Static"
  ip_version          = "IPv4"
  location            = azurerm_resource_group.rg.location
  name                = "${var.fw_hostname}-untrust0"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  sku_tier            = "Regional"
}

resource "azurerm_public_ip" "untrust_pip1" {
  allocation_method   = "Static"
  ip_version          = "IPv4"
  location            = azurerm_resource_group.rg.location
  name                = "${var.fw_hostname}-untrust1"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  sku_tier            = "Regional"
}

resource "azurerm_public_ip" "mgmt_pip0" {
  allocation_method   = "Static"
  ip_version          = "IPv4"
  location            = azurerm_resource_group.rg.location
  name                = "${var.fw_hostname}-mgmt0"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  sku_tier            = "Regional"
}

resource "azurerm_public_ip" "mgmt_pip1" {
  allocation_method   = "Static"
  ip_version          = "IPv4"
  location            = azurerm_resource_group.rg.location
  name                = "${var.fw_hostname}-mgmt1"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  sku_tier            = "Regional"
}

resource "azurerm_subnet" "mgmt_snet" {
  address_prefixes      = [var.mgmtsnet_cidr]
  name                  = "${var.fw_hostname}-mgmt"
  resource_group_name   = azurerm_resource_group.rg.name
  virtual_network_name  = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "untrust_snet" {
  address_prefixes     = [var.untrustsnet_cidr]
  name                 = "${var.fw_hostname}-untrust"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "trust_snet" {
  address_prefixes     = [var.trustsnet_cidr]
  name                 = "${var.fw_hostname}-trust"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

