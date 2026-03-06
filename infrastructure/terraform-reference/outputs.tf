output "resource_group_name" { value = azurerm_resource_group.main.name }
output "aml_workspace_name" { value = azurerm_machine_learning_workspace.main.name }
output "aks_cluster_name" { value = azurerm_kubernetes_cluster.main.name }
output "acr_login_server" { value = azurerm_container_registry.main.login_server }
output "key_vault_uri" { value = azurerm_key_vault.main.vault_uri }
