output "spoke_vnet_name" {
  value       = aviatrix_vpc.avx_spoke_vpc.name
  description = "Spoke vnet name"
}

output "spoke_vnet_rg" {
  value       = aviatrix_vpc.avx_spoke_vpc.resource_group
  description = "Spoke resource group"
}

output "spoke_subnet_id" {
  value       = aviatrix_vpc.avx_spoke_vpc.private_subnets[0].subnet_id
  description = "ID of the first private subnet in the Aviatrix spoke VNet"
}

