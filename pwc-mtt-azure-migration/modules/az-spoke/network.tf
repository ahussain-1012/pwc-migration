resource "azurerm_resource_group" "spoke_rg" {
  location = var.location
  name     = var.rg
}

resource "azurerm_virtual_network" "vnet" {
  address_space           = var.vnet_cidrs
  location                = azurerm_resource_group.spoke_rg.location
  name                    = var.vnet_name
  resource_group_name     = azurerm_resource_group.spoke_rg.name
}

resource "azurerm_subnet_route_table_association" "backendsnet_rtb_assoc" {
  route_table_id = azurerm_route_table.defaultBackendUDR.id
  subnet_id      = azurerm_subnet.backend_snet.id
}

resource "azurerm_subnet" "backend_snet" {
  address_prefixes     = [var.backendsnet_cidr]
  name                 = var.backendsnet_name
  resource_group_name  = azurerm_resource_group.spoke_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_route_table" "defaultBackendUDR" {
  disable_bgp_route_propagation = true
  location                      = azurerm_resource_group.spoke_rg.location
  name                          = "${var.backendsnet_name}_${var.vnet_name}_rtb"
  resource_group_name           = azurerm_resource_group.spoke_rg.name

  route {
    address_prefix         = "10.0.0.0/8"
    name                   = "10-0-0-0-8"
    next_hop_in_ip_address = var.lb_ip
    next_hop_type          = "VirtualAppliance"
  }

  route {
    address_prefix         = "172.16.0.0/12"
    name                   = "172-16-0-0-12"
    next_hop_in_ip_address = var.lb_ip
    next_hop_type          = "VirtualAppliance"
  }

  route {
    address_prefix         = "192.168.0.0/16"
    name                   = "192-168-0-0-16"
    next_hop_in_ip_address = var.lb_ip
    next_hop_type          = "VirtualAppliance"
  }
}

