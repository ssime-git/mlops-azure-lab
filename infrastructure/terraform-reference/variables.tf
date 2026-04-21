variable "environment" {
  type        = string
  description = "Deployment environment"
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Must be 'dev' or 'prod'."
  }
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "project_name" {
  type    = string
  default = "mlopslab"
}

variable "aml_workspace_prefix" {
  type        = string
  default     = "aml"
  description = "Prefix for the Azure ML workspace name (change to bypass soft-delete conflicts)"
}

variable "aks_node_count" {
  type    = number
  default = 1
}

variable "aks_vm_size" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "tags" {
  type    = map(string)
  default = {}
}
