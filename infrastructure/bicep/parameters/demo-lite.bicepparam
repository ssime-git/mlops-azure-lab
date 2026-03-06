using '../main.bicep'

param environment = 'dev'
param location = 'westeurope'
param projectName = 'mlopsdemo'
param deployFullStack = false
param aksNodeCount = 1
param aksVmSize = 'Standard_D2s_v3'
