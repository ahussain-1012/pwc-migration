output "transit_vnet_name" {
  value       = aviatrix_vpc.transit_firenet_vpc.name
  description = "Transit firenet vnet name"
}

output "transit_vnet_rg" {
  value       = aviatrix_vpc.transit_firenet_vpc.resource_group
  description = "Transit firenet resource group"
}

output "transit_vnet_avx_id" {
  value       = aviatrix_vpc.transit_firenet_vpc.vpc_id
  description = "Transit firenet Aviatrix ID"
}

output "transit_gw_name" {
  value       = aviatrix_transit_gateway.transit_gw.gw_name
  description = "Transit gateway name"
}

