param name string
param location string
param tags object = {}

var tenantId = subscription().tenantId

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    tenantId: tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    enableRbacAuthorization: true
    softDeleteRetentionInDays: 7
  }
}

output id string = keyVault.id
output vaultUri string = keyVault.properties.vaultUri
output name string = keyVault.name
