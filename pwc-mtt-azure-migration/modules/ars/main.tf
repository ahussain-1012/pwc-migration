resource "azurerm_subnet" "ars_snet" {
  address_prefixes     = [var.ars_subnet_cidr]
  name                 = "RouteServerSubnet"
  virtual_network_name = var.transit_vnet_name
  resource_group_name  = var.rg
}

resource "azurerm_virtual_hub" "ars" {
  name                = "${var.transit_vnet_name}-ars"
  resource_group_name = var.rg
  location            = var.location
  sku                 = "Standard"
}

resource "azurerm_public_ip" "ars_pip" {
  name                = "${var.transit_vnet_name}-arspip"
  resource_group_name = var.rg
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_virtual_hub_ip" "ars_vhubip" {
  name                         = "${var.transit_vnet_name}-vhubip"
  virtual_hub_id               = azurerm_virtual_hub.ars.id
  private_ip_allocation_method = "Dynamic"
  public_ip_address_id         = azurerm_public_ip.ars_pip.id
  subnet_id                    = azurerm_subnet.ars_snet.id
}
