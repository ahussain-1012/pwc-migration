output "rg_name" {
  value       = azurerm_resource_group.compute_rg.name
  description = "Compute RG name"
}

output "storage_name" {
  value       = azurerm_storage_account.storage.name
  description = "Compute RG name"
}

output "vm_name" {
  value       = azurerm_linux_virtual_machine.vm.name
  description = "Compute VM name"
}
