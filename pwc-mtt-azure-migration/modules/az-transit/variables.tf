variable "lb_static_ip" {
  type        = string
  description = "lb static ip"
}

variable "lb_name" {
  type        = string
  default     = "Frontend"
  description = ""
}

variable "location" {
  type        = string
  default     = "eastus"
  description = ""
}

variable "rg" {
  type        = string
  default     = "sha-tf-pa-transit"
  description = ""
}

variable "user_ip" {
  type        = string
  default     = "162.157.131.33/32"
  description = ""
}

variable "vnet_cidrs" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = ""
}

variable "vnet_name" {
  type        = string
  default     = "transit_vnet"
  description = ""
}

variable "mgmtsnet_cidr" {
  type        = string
  default     = "10.0.0.0/24"
  description = ""
}

variable "untrustsnet_cidr" {
  type        = string
  default     = "10.0.2.0/24"
  description = ""
}

variable "trustsnet_cidr" {
  type        = string
  default     = "10.0.0.0/24"
  description = ""
}

variable "storage_name" {
  type        = string
  default     = "patfghtransitstorage"
  description = ""
}

variable "fw_hostname" {
  type        = string
  default     = "firewall"
  description = ""
}

variable "fw_size" {
  type        = string
  default     = "Standard_D3_v2"
  description = "Firewall size"
}

variable "fw_username" {
  type        = string
  default     = "azureuser"
  description = "Firewall username"
}

variable "fw_password" {
  type        = string
  default     = "Aviatrix123#"
  description = "Firewall password"
}

