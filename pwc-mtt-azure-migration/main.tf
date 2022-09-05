# this resource is used to get values specific to the Azure client configuration (eg: subscription ID)
data "azurerm_client_config" "current" {}

# this generates a random string to uniquely identify this environment
resource "random_string" "env" {
  length  = 4
  special = false
}

module "transit" {
  source = "./modules/az-transit/"

  lb_static_ip     = "10.198.10.174"
  lb_name          = "internal-fw-lb"
  location         = var.location
  rg               = "aztransit110-rg"
  user_ip          = "162.157.131.33/32"
  vnet_cidrs       = ["10.198.10.0/24"]
  vnet_name        = "transit110_vnet"
  mgmtsnet_cidr    = "10.198.10.0/28"
  untrustsnet_cidr = "10.198.10.16/28"
  trustsnet_cidr   = "10.198.10.160/28"
  storage_name     = "sha1990transit111"
  fw_hostname      = "fw110"
  fw_size          = "Standard_D3_v2"
  fw_username      = "azureuser"
  fw_password      = "Aviatrix123#"
}


module "az_spoke1" {
  source = "./modules/az-spoke/"

  rg               = "${random_string.env.result}-azspoke1rg"
  vnet_cidrs       = ["10.0.151.0/24"]
  location         = var.location
  vnet_name        = "spoke151"
  backendsnet_cidr = "10.0.151.0/28"
  backendsnet_name = "backend"
  lb_ip            = "10.198.10.174"
}

module "az_spoke1_compute" {
  depends_on = [
    module.az_spoke1
  ]
  source = "./modules/az-compute/"

  rg           = "${random_string.env.result}-azspoke1computerg"
  location     = var.location
  storage_name = "${lower(random_string.env.result)}azspoke1storage"
  subnet_id    = module.az_spoke1.backend_snet_id
  vm_hostname  = "vm151"
  vm_size      = "Standard_D1_v2"
  vm_username  = "azureuser"
  vm_password  = "Aviatrix123#"
}

module "azspoke1_aztransit_peering" {
  depends_on = [
    module.transit,
    module.az_spoke1
  ]
  source = "./modules/az-vnet-peering/"

  # vnet1 = az_spoke1
  # vnet2 = az_transit
  vnet1_rg                      = module.az_spoke1.rg_name
  vnet2_rg                      = module.transit.rg_name
  vnet1_name                    = module.az_spoke1.vnet_name
  vnet1_id                      = module.az_spoke1.vnet_id
  vnet2_name                    = module.transit.vnet_name
  vnet2_id                      = module.transit.vnet_id
  vnet1_allow_forwarded_traffic = true
  vnet2_allow_forwarded_traffic = true
  vnet1_allow_gateway_transit   = false
  vnet2_allow_gateway_transit   = true
  vnet1_use_remote_gateways     = true
  vnet2_use_remote_gateways     = false
}

module "az_spoke2" {
  source = "./modules/az-spoke/"

  rg               = "${random_string.env.result}-azspoke2rg"
  vnet_cidrs       = ["10.0.152.0/24"]
  location         = var.location
  vnet_name        = "spoke152"
  backendsnet_cidr = "10.0.152.0/28"
  backendsnet_name = "backend"
  lb_ip            = "10.198.10.174"
}

module "az_spoke2_compute" {
  depends_on = [
    module.az_spoke2
  ]
  source = "./modules/az-compute/"

  rg           = "${random_string.env.result}-azspoke2computerg"
  location     = var.location
  storage_name = "${lower(random_string.env.result)}azspoke2storage"
  subnet_id    = module.az_spoke2.backend_snet_id
  vm_hostname  = "vm152"
  vm_size      = "Standard_D1_v2"
  vm_username  = "azureuser"
  vm_password  = "Aviatrix123#"
}

module "azspoke2_aztransit_peering" {
  depends_on = [
    module.transit,
    module.az_spoke2
  ]
  source = "./modules/az-vnet-peering/"

  # vnet1 = az_spoke2
  # vnet2 = az_transit
  vnet1_rg                      = module.az_spoke2.rg_name
  vnet2_rg                      = module.transit.rg_name
  vnet1_name                    = module.az_spoke2.vnet_name
  vnet1_id                      = module.az_spoke2.vnet_id
  vnet2_name                    = module.transit.vnet_name
  vnet2_id                      = module.transit.vnet_id
  vnet1_allow_forwarded_traffic = true
  vnet2_allow_forwarded_traffic = true
  vnet1_allow_gateway_transit   = false
  vnet2_allow_gateway_transit   = true
  vnet1_use_remote_gateways     = true
  vnet2_use_remote_gateways     = false
}

module "avxtransit" {
  source = "./modules/avx-transit/"

  location          = var.location
  account_name      = var.account_name
  transit_vnet_name = "avxtransit140"
  transit_vnet_cidr = "10.0.140.0/24"
  transit_gw_size   = "Standard_B4ms"
}

module "avxtransit_aztransit_peering" {
  depends_on = [
    module.transit,
    module.avxtransit
  ]
  source = "./modules/az-vnet-peering/"

  vnet1_rg                      = module.avxtransit.transit_vnet_rg
  vnet2_rg                      = module.transit.rg_name
  vnet1_name                    = module.avxtransit.transit_vnet_name
  vnet1_id                      = local.avxtransit_firenet_az_id
  vnet2_name                    = module.transit.vnet_name
  vnet2_id                      = module.transit.vnet_id
  vnet1_allow_forwarded_traffic = true
  vnet2_allow_forwarded_traffic = true
  vnet1_allow_gateway_transit   = false
  vnet2_allow_gateway_transit   = false
  vnet1_use_remote_gateways     = false
  vnet2_use_remote_gateways     = false
}

module "avxspoke1" {
  source = "./modules/avx-spoke/"

  location        = var.location
  account_name    = var.account_name
  transit_gw_name = module.avxtransit.transit_gw_name
  spoke_vnet_name = "avxspoke141"
  spoke_vnet_cidr = "10.0.141.0/24"
  spoke_gw_size   = "Standard_B1ms"
}

module "avxspoke1_compute" {
  depends_on = [
    module.avxspoke1
  ]
  source = "./modules/az-compute/"

  rg           = "${random_string.env.result}-avxspoke1computerg"
  location     = var.location
  storage_name = "${lower(random_string.env.result)}avxspoke1storage"
  subnet_id    = module.avxspoke1.spoke_subnet_id
  vm_hostname  = "avxvm141"
  vm_size      = "Standard_D1_v2"
  vm_username  = "azureuser"
  vm_password  = "Aviatrix123#"
}

/*module "aztransit_ars" {
  depends_on = [
    module.transit
  ]
  source = "./modules/ars/"

  rg                = module.transit.rg_name
  location          = var.location
  ars_name          = "${random_string.env.result}-azars"
  ars_subnet_cidr   = "10.198.10.224/27"
  transit_vnet_name = module.transit.vnet_name
}


resource "aviatrix_transit_external_device_conn" "transit_ars_extconn" {
  depends_on = [
    module.avxtransit
  ]
  vpc_id = module.avxtransit.transit_vnet_avx_id
  connection_name = "avx-${random_string.env.result}-ars"
  gw_name = module.avxtransit.transit_gw_name
  connection_type = "bgp"
  tunnel_protocol = "LAN"
  ha_enabled = true
  bgp_local_as_num = var.avx_asn
  bgp_remote_as_num = var.ars_asn
  backup_bgp_remote_as_num = var.ars_asn
  remote_lan_ip = module.aztransit_ars.ars_bgp_ips[0]
  backup_remote_lan_ip = module.aztransit_ars.ars_bgp_ips[1]
  remote_vpc_name = local.az_transit_avx_id
}

resource "azurerm_virtual_hub_bgp_connection" "ars_avx_bgp1" {
  depends_on = [
    module.aztransit_ars,
    aviatrix_transit_external_device_conn.transit_ars_extconn
  ]
  name           = "ars-avx-bgp1"
  virtual_hub_id = module.aztransit_ars.ars_id
  peer_asn       = var.avx_asn
  peer_ip        = aviatrix_transit_external_device_conn.transit_ars_extconn.local_lan_ip
}

resource "azurerm_virtual_hub_bgp_connection" "ars_avx_bgp2" {
  depends_on = [
    module.aztransit_ars,
    aviatrix_transit_external_device_conn.transit_ars_extconn
  ]
  name           = "ars-avx-bgp2"
  virtual_hub_id = module.aztransit_ars.ars_id
  peer_asn       = var.avx_asn
  peer_ip        = aviatrix_transit_external_device_conn.transit_ars_extconn.backup_local_lan_ip
}

module "mtt" {
  source = "./modules/avx-mtt/"

  location        = var.location
  account_name    = var.account_name
  vnet_name       = "${random_string.env.result}-mtt-vnet"
  vnet_cidr       = "10.0.170.0/24"
  transit_gw_size = "Standard_B4ms"
  mtt_avx_asn     = var.mtt_avx_asn
}

resource "aviatrix_transit_gateway_peering" "test_transit_gateway_peering" {
  depends_on = [
    module.mtt,
    module.avxtransit
  ]
  transit_gateway_name1 = module.mtt.mtt_gw_name
  transit_gateway_name2 = module.avxtransit.transit_gw_name
}*/

locals {
  # avx transit firenet azure ID
  # "avxtransit140:rg-av-avxtransit140-602099:6e5b091e-4d88-4396-996a-7273c19d908f" ------------------>>>>>>>>>
  # "/subscriptions/91b36c1b-3d3b-423d-8f72-aff5c8430f3c/resourceGroups/rg-av-avxtransit140-602099/providers/Microsoft.Network/virtualNetworks/avxtransit140"
  transit_firenet = split(":", module.avxtransit.transit_vnet_avx_id)
  avxtransit_firenet_az_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${local.transit_firenet[1]}/providers/Microsoft.Network/virtualNetworks/${local.transit_firenet[0]}"
  # az transit vnet avx ID
  # "/subscriptions/91b36c1b-3d3b-423d-8f72-aff5c8430f3c/resourceGroups/rg-av-avxtransit140-602099/providers/Microsoft.Network/virtualNetworks/avxtransit140" --------------->>>>>>>>>>
  # "avxtransit140:rg-av-avxtransit140-602099:6e5b091e-4d88-4396-996a-7273c19d908f"
  az_transit = split("/", module.transit.vnet_id)
  az_transit_avx_id = "${local.az_transit[8]}:${local.az_transit[4]}:${local.az_transit[2]}"
}
