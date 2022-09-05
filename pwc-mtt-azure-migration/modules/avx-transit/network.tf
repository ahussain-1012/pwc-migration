resource "aviatrix_vpc" "transit_firenet_vpc" {
  cloud_type = 8
  account_name = var.account_name
  name = var.transit_vnet_name
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = true
  region = var.location
  cidr = var.transit_vnet_cidr
}

resource "aviatrix_transit_gateway" "transit_gw" {
  depends_on = [
    aviatrix_vpc.transit_firenet_vpc
  ]
  gw_name = "${var.transit_vnet_name}-gw"
  vpc_id = aviatrix_vpc.transit_firenet_vpc.vpc_id
  cloud_type = 8
  vpc_reg = aviatrix_vpc.transit_firenet_vpc.region
  connected_transit = true
  gw_size = var.transit_gw_size
  account_name = var.account_name
  subnet = aviatrix_vpc.transit_firenet_vpc.public_subnets[0].cidr
  enable_advertise_transit_cidr = true
  enable_transit_firenet = true
  enable_bgp_over_lan = true
  ha_subnet = aviatrix_vpc.transit_firenet_vpc.public_subnets[2].cidr
  ha_gw_size = var.transit_gw_size
}

resource "aviatrix_firenet" "firenet_1" {
  depends_on = [
    aviatrix_vpc.transit_firenet_vpc,
    aviatrix_transit_gateway.transit_gw
  ]
    vpc_id = aviatrix_vpc.transit_firenet_vpc.vpc_id
    inspection_enabled = true
    egress_enabled = false
    manage_firewall_instance_association = false
    tgw_segmentation_for_egress_enabled = false
    hashing_algorithm = "5-Tuple"
}

