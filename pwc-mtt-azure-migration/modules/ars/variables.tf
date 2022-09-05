variable "rg" {
  type        = string
  description = "Resource Group name"
  default     = "ars-rg"
}

variable "location" {
  type        = string
  description = "Location for resources"
  default     = "East US"
}

variable "ars_name" {
  type        = string
  description = "ARS name"
  default     = "ars"
}

variable "ars_subnet_cidr" {
  type        = string
  description = "ARS Subnet CIDR"
}

variable "transit_vnet_name" {
  type        = string
  description = "Transit VNet name"
}
