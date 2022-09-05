resource "azurerm_virtual_network_peering" "vnet1_vnet2" {
  name                      = "${var.vnet1_name}-${var.vnet2_name}"
  resource_group_name       = var.vnet1_rg
  virtual_network_name      = var.vnet1_name
  remote_virtual_network_id = var.vnet2_id
  allow_forwarded_traffic   = var.vnet1_allow_forwarded_traffic
  allow_gateway_transit     = var.vnet1_allow_gateway_transit
}

resource "azurerm_virtual_network_peering" "vnet2_vnet1" {
  depends_on = [
    azurerm_virtual_network_peering.vnet1_vnet2
  ]
  name                      = "${var.vnet1_name}-${var.vnet2_name}"
  resource_group_name       = var.vnet2_rg
  virtual_network_name      = var.vnet2_name
  remote_virtual_network_id = var.vnet1_id
  allow_forwarded_traffic   = var.vnet2_allow_forwarded_traffic
  allow_gateway_transit     = var.vnet2_allow_gateway_transit
}

