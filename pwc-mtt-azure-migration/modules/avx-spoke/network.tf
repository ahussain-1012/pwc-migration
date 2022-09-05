resource "aviatrix_vpc" "avx_spoke_vpc" {
  cloud_type = 8
  account_name = var.account_name
  name = var.spoke_vnet_name
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  region = var.location
  cidr = var.spoke_vnet_cidr
}

resource "aviatrix_spoke_gateway" "spoke_gw" {
  depends_on = [
    aviatrix_vpc.avx_spoke_vpc
  ]
  gw_name = "${var.spoke_vnet_name}-gw"
  vpc_id = aviatrix_vpc.avx_spoke_vpc.vpc_id
  cloud_type = 8
  vpc_reg = aviatrix_vpc.avx_spoke_vpc.region
  gw_size = var.spoke_gw_size
  account_name = var.account_name
  subnet = aviatrix_vpc.avx_spoke_vpc.public_subnets[0].cidr
  ha_subnet = aviatrix_vpc.avx_spoke_vpc.public_subnets[1].cidr
  ha_gw_size = var.spoke_gw_size
  manage_transit_gateway_attachment = false
}

resource "aviatrix_spoke_transit_attachment" "spoke_transit_att" {
  depends_on = [
    aviatrix_spoke_gateway.spoke_gw
  ]
  spoke_gw_name = aviatrix_spoke_gateway.spoke_gw.gw_name
  transit_gw_name = var.transit_gw_name
}

