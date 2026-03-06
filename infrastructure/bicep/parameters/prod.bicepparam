using '../main.bicep'

param environment = 'prod'
param location = 'westeurope'
param projectName = 'mlopslab'
param deployFullStack = true
param aksNodeCount = 2
param aksVmSize = 'Standard_D4s_v3'
