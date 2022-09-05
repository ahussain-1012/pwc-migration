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

variable "vnet_name" {
  description = "Default spoke VNET name"
  type        = string
  default     = "pwc-avx-spoke"
}

variable "vnet_cidr" {
  description = ""
  type        = string
}

variable "transit_gw_size" {
  description = "Transit gateway size"
  type        = string
  default     = "Standard_B4ms"
}

variable "mtt_avx_asn" {
  description = "MTT AVX BGP ASN"
  type        = string
}
