variable "rg" {
  description = "resource group name"
  type        = string
  default     = "pa-gh-spoke-rg"
}

variable "vnet_cidrs" {
  description = ""
  type        = list(string)
}

variable "location" {
  description = ""
  type        = string
  default     = "South Central US"
}

variable "vnet_name" {
  description = ""
  type        = string
  default     = "spoke"
}

variable "backendsnet_cidr" {
  description = ""
  type        = string
  default     = "192.168.1.0/24"
}

variable "backendsnet_name" {
  description = ""
  type        = string
  default     = "backendSubnet"
}

variable "lb_ip" {
  description = "load balancer IP"
  type        = string
}
