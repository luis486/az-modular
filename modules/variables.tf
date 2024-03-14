variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location for all resources."
}

variable "resource_group_name_prefix" {
  type        = string
  description = "Prefix of the resource group name that's combined with a random value so name is unique in your Azure subscription."
}

variable "admin_password"{
  type = string
  description = "Here you can see the password to be authorizated on the virtual machine"
}

variable name_function{
  type = string
  description = "Name function"
}