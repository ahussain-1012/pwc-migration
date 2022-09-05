# ARS
Given a VNet name, and a subnet CIDR (at least /27 or more), this module creates a subnet called `RouteServerSubnet` in the given VNet, and then deploys
an Azure Route Server in the new subnet. It returns the ARS ID, the ARS BGP peering IPs, and the ARS ASN.
