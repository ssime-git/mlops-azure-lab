// ============================================================
// main.bicep - Orchestrateur MLOps Lab
// Deploie : Storage, Key Vault, ACR, App Insights, AML, AKS
// ============================================================

@description('Environnement de deploiement')
@allowed(['dev', 'prod'])
param environment string

@description('Region Azure')
param location string = resourceGroup().location

@description('Nom de base du projet')
param projectName string = 'mlopslab'

@description('Mode full = AML + AKS, mode lite = infra de base pour demo')
param deployFullStack bool = true

@description('Nombre de noeuds AKS')
param aksNodeCount int = 1

@description('Taille des VMs AKS')
param aksVmSize string = 'Standard_D2s_v3'

var baseName = '${projectName}-${environment}'
var uniqueSuffix = toLower(substring(uniqueString(subscription().id, resourceGroup().id), 0, 5))
var commonTags = {
  environment: environment
  project: projectName
  managedBy: 'bicep'
}

module storage 'modules/storage-account.bicep' = {
  name: 'deploy-storage'
  params: {
    name: 'sa${replace(baseName, '-', '')}${uniqueSuffix}ml'
    location: location
    tags: commonTags
  }
}

module keyVault 'modules/key-vault.bicep' = {
  name: 'deploy-keyvault'
  params: {
    name: 'kv-${baseName}-${uniqueSuffix}'
    location: location
    tags: commonTags
  }
}

module acr 'modules/container-registry.bicep' = {
  name: 'deploy-acr'
  params: {
    name: 'acr${replace(baseName, '-', '')}${uniqueSuffix}'
    location: location
    sku: environment == 'prod' ? 'Premium' : 'Basic'
    tags: commonTags
  }
}

module appInsights 'modules/application-insights.bicep' = if (deployFullStack) {
  name: 'deploy-appinsights'
  params: {
    name: 'appi-${baseName}'
    location: location
    tags: commonTags
  }
}

module amlWorkspace 'modules/aml-workspace.bicep' = if (deployFullStack) {
  name: 'deploy-aml'
  params: {
    name: 'aml-${baseName}'
    location: location
    storageAccountId: storage.outputs.id
    keyVaultId: keyVault.outputs.id
    containerRegistryId: acr.outputs.id
    applicationInsightsId: appInsights.outputs.id
    tags: commonTags
  }
}

module aks 'modules/aks.bicep' = if (deployFullStack) {
  name: 'deploy-aks'
  params: {
    name: 'aks-${baseName}'
    location: location
    nodeCount: aksNodeCount
    vmSize: aksVmSize
    acrId: acr.outputs.id
    tags: commonTags
  }
}

resource amlWorkspaceAcrPull 'Microsoft.Authorization/roleAssignments@2022-04-01' = if (deployFullStack) {
  name: guid(amlWorkspace.outputs.id, acr.outputs.id, 'AcrPull')
  scope: resourceGroup()
  properties: {
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      '7f951dda-4ed3-4680-a7ca-43fe172d538d'
    )
    principalId: amlWorkspace.outputs.principalId
    principalType: 'ServicePrincipal'
  }
}

output resourceGroupName string = resourceGroup().name
output deploymentMode string = deployFullStack ? 'full' : 'lite'
output amlWorkspaceName string = deployFullStack ? amlWorkspace.outputs.name : ''
output aksClusterName string = deployFullStack ? aks.outputs.name : ''
output acrLoginServer string = acr.outputs.loginServer
output keyVaultUri string = keyVault.outputs.vaultUri
