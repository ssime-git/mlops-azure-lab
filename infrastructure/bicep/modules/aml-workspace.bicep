param name string
param location string
param storageAccountId string
param keyVaultId string
param containerRegistryId string
param applicationInsightsId string
param tags object = {}

resource amlWorkspace 'Microsoft.MachineLearningServices/workspaces@2024-01-01-preview' = {
  name: name
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    storageAccount: storageAccountId
    keyVault: keyVaultId
    containerRegistry: containerRegistryId
    applicationInsights: applicationInsightsId
    publicNetworkAccess: 'Enabled'
    v1LegacyMode: false
  }
}

output id string = amlWorkspace.id
output name string = amlWorkspace.name
output principalId string = amlWorkspace.identity.principalId
