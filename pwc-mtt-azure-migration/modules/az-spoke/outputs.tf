output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "Spoke VNet ID"
}

output "backend_snet_id" {
  value       = azurerm_subnet.backend_snet.id
  description = "Spoke backend subnet VNet ID"
}

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Spoke VNet name"
}

output "rg_name" {
  value       = azurerm_resource_group.spoke_rg.name
  description = "Spoke RG name"
}

