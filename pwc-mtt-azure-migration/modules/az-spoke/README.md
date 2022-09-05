# az-spoke
This module deploys a simplified native spoke VNet. A spoke VNet is deployed with a single `backend` subnet, which is associated to a deployed route table. The route table has 3 routes, pointing all RFC 1918 private subnet to a given `lb_ip`, which is supposed to be the IP address of the internal load balancer in the native transit VNet.  
The VNet peering with the native transit VNet is not deployed as a part of this module.
