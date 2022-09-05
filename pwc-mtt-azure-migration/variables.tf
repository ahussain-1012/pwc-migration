variable "controller_ip" {
  type        = string
  description = "IP address of the Aviatrix Controller"
}

variable "controller_username" {
  type        = string
  description = "Username for the Aviatrix Controller"
  default     = "admin"
}

variable "controller_password" {
  type        = string
  description = "Password for the Aviatrix Controller"
  default     = "Aviatrix123#"
}

variable "account_name" {
  description = "CSP Account name in the controller"
  type        = string
  default     = "azure"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Location for the resources"
}

variable "avx_asn" {
  type        = string
  default     = "65005"
  description = "Aviatrix transit gateway ASN"
}

variable "mtt_avx_asn" {
  type        = string
  default     = "65005"
  description = "Aviatrix MTT transit gateway ASN"
}

variable "ars_asn" {
  type        = string
  default     = "65515"
  description = "ARS ASN"
}
