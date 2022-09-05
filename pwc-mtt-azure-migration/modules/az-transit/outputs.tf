output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "Transit VNet ID"
}

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Transit VNet name"
}
output "rg_name" {
  value       = azurerm_virtual_network.vnet.resource_group_name
  description = "Transit VNet resource group"
}
