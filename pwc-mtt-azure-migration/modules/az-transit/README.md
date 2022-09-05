# az-transit
This module deploys an Azure native transit VNet, simplified for the Aviatrix Azure brownfield migration scenario. The deployed resources consist of a VNet, along with 3 subnets. NSGs are also created and attached to the subnets. Additionally, a couple of Palo Alto firewalls are deployed behind a load balancer as well.  
Default configuration for the Palo Alto firewalls is available in the `palo_config.xml` file in the `/pwc-mtt-azure-migration/modules` directory.
