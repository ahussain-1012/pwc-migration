variable "vnet1_rg" {
  description = "VNet1 resource group name"
  type        = string
}

variable "vnet2_rg" {
  description = "VNet2 resource group name"
  type        = string
}

variable "vnet1_name" {
  description = "Name of VNet1"
  type        = string
}

variable "vnet1_id" {
  description = "ID of VNet1"
  type        = string
}

variable "vnet2_name" {
  description = "Name of VNet2"
  type        = string
}

variable "vnet2_id" {
  description = "ID of VNet2"
  type        = string
}

variable "vnet1_allow_forwarded_traffic" {
  description = "Allow VNet1 to recieve traffic from VNet2"
  type        = bool
  default     = true
}

variable "vnet2_allow_forwarded_traffic" {
  description = "Allow VNet2 to recieve traffic from VNet1"
  type        = bool
  default     = true
}

variable "vnet1_allow_gateway_transit" {
  description = "Use VNG or ARS transit in VNet1"
  type        = bool
  default     = false
}

variable "vnet2_allow_gateway_transit" {
  description = "Use VNG or ARS transit in VNet2"
  type        = bool
  default     = false
}

variable "vnet1_use_remote_gateways" {
  description = "Allow traffic from VNet1 to use the VNG or ARS in VNet2"
  type        = bool
  default     = false
}

variable "vnet2_use_remote_gateways" {
  description = "Allow traffic from VNet2 to use the VNG or ARS in VNet1"
  type        = bool
  default     = false
}
