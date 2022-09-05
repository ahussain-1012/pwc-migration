output "vnet1_vnet2_peering_name" {
  description = "VNet1 - VNet2 peering name"
  value       = azurerm_virtual_network_peering.vnet1_vnet2.name
}

output "vnet2_vnet1_peering_name" {
  description = "VNet2 - VNet1 peering name"
  value       = azurerm_virtual_network_peering.vnet2_vnet1.name
}
