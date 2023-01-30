##################################################################################
# Terraform SMC Automation for Non-Production Environment
##################################################################################
# 
# LHD         :     MNCLHD
# File        :     application SMC main File to pass the foundation requirments 
# Version     :     v.1.0
# LHD Admins  :     Michal, Kevin
# Dev         :     Satish
# repo        :     Master
##################################################################################

# Resource - NSG Rules
#**************************************************************

module "Application_SMC_Network_Security_Group_Rules" {

  source                      = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-nsg-rules-csv.git"
  network_security_group_name = var.application_network_security_group_name
  resource_group_name         = data.azurerm_resource_group.smc_application_01.name
  location                    = data.azurerm_resource_group.smc_application_01.location
  csv_file_name_nsg           = "nsg_rules/${var.application_csv_file_name_nsg}"

}

# Resource - Recovery_Service_Vault
#**************************************************************
module "Application_SMC_Recovery_Service_Vault" {

  source                    = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-recovery-vault_backup_policies.git"
  name                      = var.shared_recovery_service_vault_name
  resource_group_name       = data.azurerm_resource_group.smc_application_01.name
  location                  = data.azurerm_resource_group.smc_application_01.location
  vault_resource_group_name = data.azurerm_resource_group.smc_shared_01.name

  # VM File Share Policy Details
  backup_policy_file_share_name = var.application_backup_policy_file_share_name
  backup_policy_fileshare = {
    frequency = "Daily"
    time      = "02:00"
  }
  retention_daily_policy_fileshare = {
    count = 30
  }

  # VM Policy Details
  backup_policy_vm_name = var.application_backup_policy_vm_name
  backup_policy_vm = {
    frequency = "Daily"
    time      = "01:00"
  }

  retention_daily_policy_vm = {
    count = 30
  }
  retention_weekly_policy_vm = {
    count    = 12
    weekdays = ["Saturday"]
  }
  retention_monthly_policy_vm = {
    count    = 12
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }
  retention_yearly_policy_vm = {
    count    = 10
    weekdays = ["Sunday"]
    weeks    = ["First"]
    months   = ["January"]
  }
}
##################################################################################

locals {
  backup_policies = [
    {
      backup_policy_file_share_name = var.application_backup_policy_file_share_name
      backup_policy_vm_name         = var.application_backup_policy_vm_name
    }
  ]

}