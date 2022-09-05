# az-compute
Given a subnet ID (with other input variables), this module creates an Azure VM with a NIC in the given subnet. A storage account is created to help with serial console access, and a default NSG is also created. This VM does not have any public access, and only serial console access is allowed. This VM can be used to verify connectivity in a topology. 
