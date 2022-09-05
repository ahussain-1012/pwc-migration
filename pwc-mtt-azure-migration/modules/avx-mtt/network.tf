resource "aviatrix_vpc" "mtt_vpc" {
  cloud_type = 8
  account_name = var.account_name
  name = var.vnet_name
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  region = var.location
  cidr = var.vnet_cidr
}

resource "aviatrix_transit_gateway" "mtt_gw" {
  depends_on = [
    aviatrix_vpc.mtt_vpc
  ]
  single_az_ha = true
  gw_name = "${var.vnet_name}-gw"
  vpc_id = aviatrix_vpc.mtt_vpc.vpc_id
  cloud_type = 8
  vpc_reg = aviatrix_vpc.mtt_vpc.region
  connected_transit = true
  gw_size = var.transit_gw_size
  account_name = var.account_name
  subnet = aviatrix_vpc.mtt_vpc.public_subnets[0].cidr
  local_as_number = var.mtt_avx_asn
  bgp_ecmp = true
  enable_bgp_over_lan = true
  ha_subnet = aviatrix_vpc.mtt_vpc.public_subnets[1].cidr
  ha_gw_size = var.transit_gw_size
  enable_multi_tier_transit = true
}
