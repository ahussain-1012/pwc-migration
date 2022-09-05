output "env" {
  value       = random_string.env.result
  description = "Unique environment name"
}

output "aztransit_rg_name" {
  value       = module.transit.rg_name
  description = "Azure transit VNet resource group"
}

output "aztransit_vnet_id" {
  value       = module.transit.vnet_id
  description = "Azure transit VNet ID"
}

output "aztransit_vnet_name" {
  value       = module.transit.vnet_name
  description = "Azure transit VNet name"
}

output "azspoke1_vnet_id" {
  value       = module.az_spoke1.vnet_id
  description = "Spoke1 VNet ID"
}

output "azspoke1_vnet_name" {
  value       = module.az_spoke1.vnet_name
  description = "Spoke1 VNet name"
}

output "azspoke1_backend_snet_id" {
  value       = module.az_spoke1.backend_snet_id
  description = "Spoke1 backend subnet VNet ID"
}

output "azspoke1_rg_name" {
  value       = module.az_spoke1.rg_name
  description = "Spoke1 RG name"
}

output "azspoke1compute_rg" {
  value       = module.az_spoke1_compute.rg_name
  description = "AZ Spoke1 compute RG"
}

output "azspoke1compute_storage" {
  value       = module.az_spoke1_compute.storage_name
  description = "AZ Spoke1 compute storage"
}

output "azspoke1compute_vmname" {
  value       = module.az_spoke1_compute.vm_name
  description = "AZ Spoke1 compute VM name"
}

output "azspoke1_vnet1_vnet2_peering_name" {
  description = "Spoke1 - Transit peering name"
  value       = module.azspoke1_aztransit_peering.vnet1_vnet2_peering_name
}

output "azspoke1_vnet2_vnet1_peering_name" {
  description = "Transit - Spoke1 peering name"
  value       = module.azspoke1_aztransit_peering.vnet2_vnet1_peering_name
}

output "azspoke2_vnet_id" {
  value       = module.az_spoke2.vnet_id
  description = "Spoke2 VNet ID"
}

output "azspoke2_vnet_name" {
  value       = module.az_spoke2.vnet_name
  description = "Spoke2 VNet name"
}

output "azspoke2_backend_snet_id" {
  value       = module.az_spoke2.backend_snet_id
  description = "Spoke2 backend subnet VNet ID"
}

output "azspoke2_rg_name" {
  value       = module.az_spoke2.rg_name
  description = "Spoke2 RG name"
}

output "azspoke2compute_rg" {
  value       = module.az_spoke2_compute.rg_name
  description = "AZ Spoke2 compute RG"
}

output "azspoke2compute_storage" {
  value       = module.az_spoke2_compute.storage_name
  description = "AZ Spoke2 compute storage"
}

output "azspoke2compute_vmname" {
  value       = module.az_spoke2_compute.vm_name
  description = "AZ Spoke2 compute VM name"
}

output "azspoke2_vnet1_vnet2_peering_name" {
  description = "Spoke2 - Transit peering name"
  value       = module.azspoke2_aztransit_peering.vnet1_vnet2_peering_name
}

output "azspoke2_vnet2_vnet1_peering_name" {
  description = "Transit - Spoke2 peering name"
  value       = module.azspoke2_aztransit_peering.vnet2_vnet1_peering_name
}

output "avxtransit_vnet_name" {
  value       = module.avxtransit.transit_vnet_name
  description = "AVX Transit firenet vnet name"
}

output "avxtransit_vnet_rg" {
  value       = module.avxtransit.transit_vnet_rg
  description = "AVX Transit firenet resource group"
}

output "avxtransit_vnet_avx_id" {
  value       = module.avxtransit.transit_vnet_avx_id
  description = "AVX Transit firenet Aviatrix ID"
}

output "avxtransit_gw_name" {
  value       = module.avxtransit.transit_gw_name
  description = "AVX Transit gateway name"
}

output "avxtransit_vnet_azure_id" {
  value       = local.avxtransit_firenet_az_id
  description = "AVX Transit firenet Azure ID"
}

output "avxspoke1_vnet_name" {
  value       = module.avxspoke1.spoke_vnet_name
  description = "Spoke1 VNet name"
}

output "avxspoke1_vnet_rg" {
  value       = module.avxspoke1.spoke_vnet_rg
  description = "Spoke1 resource group"
}

output "avxspoke1_subnet_id" {
  value       = module.avxspoke1.spoke_subnet_id
  description = "ID of the first private subnet in Aviatrix Spoke1 VNet"
}

output "avxspoke1compute_rg" {
  value       = module.avxspoke1_compute.rg_name
  description = "AVX Spoke1 compute RG"
}

output "avxspoke1compute_storage" {
  value       = module.avxspoke1_compute.storage_name
  description = "AVX Spoke1 compute storage"
}

output "avxspoke1compute_vmname" {
  value       = module.avxspoke1_compute.vm_name
  description = "AVX Spoke1 compute VM name"
}

/*output "aztransitars_asn" {
  value       = module.aztransit_ars.ars_asn
  description = "ARS AS number"
}

output "ars_bgp_ips" {
  value       = module.aztransit_ars.ars_bgp_ips
  description = "ARS BGP IPs"
}

output "ars_id" {
  value       = module.aztransit_ars.ars_id
  description = "ARS ID"
}

output "aztransit_avx_id" {
  value       = local.az_transit_avx_id
  description = "Azure transit AVX ID"
}

output "bgp_remote_lan_ip" {
  value       = aviatrix_transit_external_device_conn.transit_ars_extconn.local_lan_ip
  description = "BGP local LAN IP"
}

output "bgp_backup_remote_lan_ip" {
  value       = aviatrix_transit_external_device_conn.transit_ars_extconn.backup_local_lan_ip
  description = "BGP backup local LAN IP"
}

output "mtt_vnet_name" {
  value       = module.mtt.mtt_vnet_name
  description = "MTT VNet name"
}

output "mtt_vnet_id" {
  value       = module.mtt.mtt_vnet_id
  description = "MTT VNet ID"
}

output "mtt_vnet_rg" {
  value       = module.mtt.mtt_vnet_rg
  description = "MTT VNet resource group"
}

output "mtt_gw_name" {
  value       = module.mtt.mtt_gw_name
  description = "MTT gateway name"
}

*/