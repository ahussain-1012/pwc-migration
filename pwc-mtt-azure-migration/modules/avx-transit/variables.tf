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

variable "transit_vnet_name" {
  description = "Transit firenet name"
  type        = string
  default     = "pwc-transit-firenet"
}

variable "transit_vnet_cidr" {
  description = ""
  type        = string
}

variable "transit_gw_size" {
  description = "Transit gateway size"
  type        = string
  default     = "Standard_B4ms"
}

