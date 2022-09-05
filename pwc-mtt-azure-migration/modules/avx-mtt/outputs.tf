output "mtt_vnet_name" {
  value       = aviatrix_vpc.mtt_vpc.name
  description = "MTT VNet name"
}

output "mtt_vnet_id" {
  value       = aviatrix_vpc.mtt_vpc.vpc_id
  description = "MTT VNet ID"
}

output "mtt_vnet_rg" {
  value       = aviatrix_vpc.mtt_vpc.resource_group
  description = "MTT VNet resource group"
}

output "mtt_gw_name" {
  value       = aviatrix_transit_gateway.mtt_gw.gw_name
  description = "MTT gateway name"
}

