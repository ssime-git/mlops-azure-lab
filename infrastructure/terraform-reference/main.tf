# ============================================================
# REFERENCE UNIQUEMENT - pas de terraform apply en lab
# ============================================================

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = true
    }
  }
}

data "azurerm_client_config" "current" {}

locals {
  base_name = "${var.project_name}-${var.environment}"
  common_tags = merge(var.tags, {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
  })
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${local.base_name}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_storage_account" "main" {
  name                     = "sa${replace(local.base_name, "-", "")}ml"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.common_tags
}

resource "azurerm_key_vault" "main" {
  name                      = "kv-${local.base_name}"
  resource_group_name       = azurerm_resource_group.main.name
  location                  = var.location
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  sku_name                  = "standard"
  enable_rbac_authorization = true
  tags                      = local.common_tags
}

resource "azurerm_container_registry" "main" {
  name                = "acr${replace(local.base_name, "-", "")}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  sku                 = var.environment == "prod" ? "Premium" : "Basic"
  admin_enabled       = false
  tags                = local.common_tags
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-mlopslab-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.common_tags
}

resource "azurerm_application_insights" "main" {
  name                = "appi-${local.base_name}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  workspace_id        = azurerm_log_analytics_workspace.main.id
  application_type    = "web"
  tags                = local.common_tags
}

resource "azurerm_machine_learning_workspace" "main" {
  name                    = "aml-${local.base_name}"
  resource_group_name     = azurerm_resource_group.main.name
  location                = var.location
  storage_account_id      = azurerm_storage_account.main.id
  key_vault_id            = azurerm_key_vault.main.id
  container_registry_id   = azurerm_container_registry.main.id
  application_insights_id = azurerm_application_insights.main.id
  tags                    = local.common_tags
  identity { type = "SystemAssigned" }
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-${local.base_name}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  dns_prefix          = "aks-${local.base_name}"
  tags                = local.common_tags

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = var.aks_vm_size
  }

  identity { type = "SystemAssigned" }
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.main.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}
