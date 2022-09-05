output "ars_asn" {
  value       = azurerm_virtual_hub.ars.virtual_router_asn
  # value       = 65515
  description = "ARS AS number"
}

output "ars_bgp_ips" {
  value       = azurerm_virtual_hub.ars.virtual_router_ips
  # value       = ["10.198.10.229", "10.198.10.228"]
  description = "ARS BGP IPs"
}

output "ars_id" {
  value       = azurerm_virtual_hub.ars.id
  # value       = ""
  description = "ARS ID"
}
