variable "rg" {
  description = "resource group name"
  type        = string
}

variable "location" {
  description = "Location to create compute resources"
  type        = string
}

variable "storage_name" {
  description = "Storage account name - globally unique"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID in which the VM will be created"
  type        = string
}

variable "vm_hostname" {
  description = "Name of the backend vm"
  type        = string
  default     = "backend-server"
}

variable "vm_size" {
  description = "Size of the backend vm"
  type        = string
  default     = "Standard_D1_v2"
}

variable "vm_username" {
  description = "Username of the backend vm"
  type        = string
  default     = "azureuser"
}

variable "vm_password" {
  description = "Password for the backend vm"
  type        = string
  default     = "Aviatrix123#"
}

