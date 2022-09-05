variable "location" {
  description = ""
  type        = string
  default     = "South Central US"
}

variable "account_name" {
  description = "CSP Account name in the controller"
  type        = string
  default     = "azure"
}

variable "transit_gw_name" {
  description = "Transit gateway name"
  type        = string
}

variable "spoke_vnet_name" {
  description = "Default spoke VNET name"
  type        = string
  default     = "pwc-avx-spoke"
}

variable "spoke_vnet_cidr" {
  description = ""
  type        = string
}

variable "spoke_gw_size" {
  description = "Spoke gateway size"
  type        = string
  default     = "Standard_B1ms"
}

