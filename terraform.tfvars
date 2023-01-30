##################################################################################
# one Variable Form - To pass the all required parameters to the automation code
# LHD Resources creation based on the refrence architecture and requirements 
##################################################################################
# 
# LHD         :     MNCLHD
# File        :     One Variable Form 
# version     :     v.1.0
# Dev         :     Satish
##################################################################################

#**************************************************************
# Provider Network Details 
#**************************************************************
provider_smc_name    = "Provider-INF-VNET-01"
provider_vnet_name   = "Provider-INF-RGP-01"
provider_subnet_name = ""
location_01          = "australiaeast"
location_02          = "australiasoutheast"

#**************************************************************
# SMC - Shared SMC 
#**************************************************************
resource_group_name_shared_01 = "mcazsh1p-RGP-01"

# NSG Rules
#********************************
shared_network_security_group_name = "mcazsh1p-NSG-01"
shared_csv_file_name_nsg           = "nsg_rules/shared_nsg_rules"

# Recovery Service Vault
#********************************
shared_recovery_service_vault_name = "mcazInfp-rsv001"
shared_backup_policy_vm_name       = "vm-bkup-prod"
storage_mode_type                  = "LocallyRedundant"

# Log Analytical Workspace
#********************************
shared_log_analytical_workspace_name    = "mcazinfp-law001"
shared_log_analytical_workspace_name_02 = "mcazinfp-law002"
#shared_log_analytical_workspace_name_02     = "mcazinfp-law002"

# Key Vault
#********************************
shared_key_vault_name = "mcazinfp-kvt001"

#**************************************************************
# SMC - Platform SMC 
#**************************************************************
#resource_group_name_platform_01 = "mcazpt1p-RGP-01"
resource_group_name_platform_02 = "mcazpt2p-RGP-01"
# Recovery Service Vault
#********************************
#platform_recovery_service_vault_name = "mcazInfp-rsv001"
platform_backup_policy_vm_name    = "pt1p-vm-bkup-prod"
platform_02_backup_policy_vm_name = "pt2p-vm-bkup-prod"
# NSG Rules
#********************************
#platform_network_security_group_name = "mcazpt1p-NSG-01"
#platform_csv_file_name_nsg           = "platform_nsg_rules"



#**************************************************************
# SMC - Application SMC 
#**************************************************************
resource_group_name_application_01 = "mcazap1p-RGP-01"
# Recovery Service Vault
#********************************
application_recovery_service_vault_name   = "mcazInfp-rsv001"
application_backup_policy_vm_name         = "ap1p-vm-bkup-prod"
application_backup_policy_file_share_name = null

# NSG Rules
#********************************
application_network_security_group_name = "mcazap1p-NSG-01"
application_csv_file_name_nsg           = "application_nsg_rules"
