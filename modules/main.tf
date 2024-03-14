resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg_name.id
  location = var.resource_group_location
}

resource "random_string" "linux_vm_hostname" {
  length  = 2
  lower   = true
  upper   = false
  special = false
}

resource "random_pet" "linux_public_ip_dns" {
  prefix = "dns"
}

# The following module is a Terraform Verified Module. 
# For more information about Verified Modules, see 
# https://github.com/azure/terraform-azure-modules/
module "linux" {
  count                         = 3 # Define 3 Ubuntu Server VMs
  source                        = "./modules"
  resource_group_name           = azurerm_resource_group.rg.name
  vnet_subnet_id                = module.network.vnet_subnets[0]
  is_windows_image              = false
  vm_hostname                   = "vm-${random_string.linux_vm_hostname.result}-${count.index}"
  delete_os_disk_on_termination = true
  admin_password                = var.admin_password
  vm_os_simple                  = "UbuntuServer:18.04-LTS"
  public_ip_dns                 = ["${random_pet.linux_public_ip_dns.id}-${count.index}"]
}

# The following module is a Terraform Verified Module. 
# For more information about Verified Modules, see 
# https://github.com/azure/terraform-azure-modules/
module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.rg.name
  version             = "5.2.0"
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["subnet1"]
  use_for_each        = true
}