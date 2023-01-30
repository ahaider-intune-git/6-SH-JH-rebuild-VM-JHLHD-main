#############################################################################
# # Variable File
############################################################################# 
# 
# File:     Variables declaration required and default values
# Version:  1.0
# 
#############################################################################

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}
#**************************************************************
# SMC - Shared SMC 
#**************************************************************

# NSG Rules
#********************************
variable "shared_network_security_group_name" {
  description = "Platform SMC Name"
  type        = string
  default     = "mcazsh1p-RGP-01"
}

variable "shared_csv_file_name_nsg" {
  description = "Name of the NSG Rules CSV File"
  type        = string
  default     = "shared_nsg_rules"
}

variable "shared_recovery_service_vault_name" {
  description = "Name of the Recover Service Vault"
  type        = string
  default     = "recovervaultname"
}

variable "shared_backup_policy_file_share_name" {
  description = "Name of the backup policy fileshare"
  type        = string
  default     = "recovervaultname"
}

variable "shared_backup_policy_vm_name" {
  description = "Name of the backup policy virtual machine"
  type        = string
  default     = "recovervaultname"
}

variable "storage_mode_type" {
  type        = string
  description = "storage mode type for recovery vault. Possible values are GeoRedundant, LocallyRedundant and ZoneRedundant"
  default     = "GeoRedundant"
}

variable "shared_log_analytical_workspace_name" {
  description = "Name of the backup policy virtual machine"
  type        = string
  default     = "logworkspacename"
}

variable "shared_log_analytical_workspace_name_02" {
  description = "Name of the backup policy virtual machine"
  type        = string
  default     = "logworkspacename"
}

variable "solutions" {
  description = "A list of solutions to add to the workspace. Should contain solution_name, publisher and product."
  type        = list(object({ solution_name = string, publisher = string, product = string }))
  default = [
    { solution_name = "",
      publisher     = "Microsoft",
      product       = ""
    }
  ]
}

variable "security_center_subscription" {
  description = "List of subscriptions this log analytics should collect data for. Does not work on free subscription."
  type        = list(string)
  default     = []
}

variable "windows_performance_counters" {
  description = "Map of Windows performance counters"
  type        = map(any)
  default     = {}
}

variable "windows_event_logs" {
  description = "Map of Windows events"
  type        = map(any)
  default     = {}
}

# Key Vault
#********************************
variable "shared_key_vault_name" {
  description = "shared key vault name"
  type        = string
  default     = "sahredsample-keyvault-name"
}

#**************************************************************
# SMC - Platform 01 SMC 
#**************************************************************

# NSG Rules
#********************************
variable "platform_01_network_security_group_name" {
  description = "Platform SMC Name"
  type        = string
  default     = "mcazpt1p-NSG-01"
}

variable "platform_01_csv_file_name_nsg" {
  description = "Name of the NSG Rules CSV File"
  type        = string
  default     = "platform_01_nsg_rules"
}

variable "platform_recovery_service_vault_name" {
  description = "Name of the Recover Service Vault"
  type        = string
  default     = "recovervaultname"
}

variable "platform_backup_policy_file_share_name" {
  description = "Name of the backup policy fileshare"
  type        = string
  default     = ""
}

variable "platform_02_backup_policy_file_share_name" {
  description = "Name of the backup policy fileshare"
  type        = string
  default     = ""
}

variable "platform_backup_policy_vm_name" {
  description = "Name of the backup policy virtual machine"
  type        = string
  default     = "recovervaultname"
}

variable "platform_02_backup_policy_vm_name" {
  description = "Name of the backup policy virtual machine"
  type        = string
  default     = ""
}


#**************************************************************
# SMC - Platform 02 SMC 
#**************************************************************

# NSG Rules
#********************************
variable "platform_02_network_security_group_name" {
  description = "Platform SMC Name"
  type        = string
  default     = "mcazpt2p-NSG-01"
}

variable "platform_02_csv_file_name_nsg" {
  description = "Name of the NSG Rules CSV File"
  type        = string
  default     = "platform_02_nsg_rules"
}


# Provider SMC and Vnet Details
#********************************
variable "provider_smc_name" {
  default     = "Provider-INF-RGP-01"
  type        = string
  description = "Resource group name"
}

variable "provider_vnet_name" {
  description = "Provider Vnet Name"
  type        = string
  default     = "Provider-INF-VNET-01"
}

variable "provider_subnet_name" {
  description = "Provider Subnet Name"
  type        = string
  default     = "mcazpt1p-SNET-01"
}

# SMC - Resource Groups
#**************************************************************
variable "resource_group_name_platform_01" {
  description = "Name of the Platform SMC"
  type        = string
  default     = "mcazpt1p-RGP-01"
}

variable "resource_group_name_platform_02" {
  description = "Name of the Platform SMC"
  type        = string
  default     = "mcazpt2p-RGP-01"
}

variable "resource_group_name_shared_01" {
  description = "Name of the Shared SMC"
  type        = string
  default     = "mcazsh1p-RGP-01"
}

variable "resource_group_name_application_01" {
  description = "Name of the Shared SMC"
  type        = string
  default     = "mcazap1p-RGP-01"
}

# Subscription Details
#**************************************************************
variable "subscription_id" {
  description = "Enter the subscription ID for provisioning resources in Azure"
  type        = string
  default     = ""
}

variable "client_id" {
  description = "Enter Client ID for applications created in Azure AD"
  type        = string
  default     = ""
}

variable "client_secret" {
  description = "Enter Client secret for Application in Azure AD"
  type        = string
  default     = ""
}

variable "tenant_id" {
  description = "Tenant id of the subsrciption "
  type        = string
  default     = ""
}

variable "client_name" {
  description = "Client Name details "
  type        = string
  default     = ""
}

variable "account_id" {
  description = "Account ID "
  type        = string
  default     = ""
}

variable "object_id" {
  description = "Object ID "
  type        = string
  default     = ""
}

variable "environment" {
  description = "Azure SMC Environment "
  type        = string
  default     = "Non_Prod"
}

variable "name" {
  description = "Azure resource name "
  type        = string
  default     = ""
}

variable "azure_region_01" {
  description = "Azure region 01"
  type        = string
  default     = ""
}

variable "location_01" {
  description = "location 01 "
  type        = string
  default     = ""
}

variable "azure_region_02" {
  description = "Azure region 02"
  type        = string
  default     = ""
}

variable "location_02" {
  description = "location 02 "
  type        = string
  default     = ""
}

#**************************************************************
# SMC - Resource Groups
#**************************************************************



#**************************************************************
# SMC - Application SMC 
#**************************************************************

# NSG Rules
#********************************
variable "application_network_security_group_name" {
  description = "Platform SMC Name"
  type        = string
  default     = "mcazpt1p-NSG-01"
}

variable "application_csv_file_name_nsg" {
  description = "Name of the NSG Rules CSV File"
  type        = string
  default     = "application_nsg_rules"
}

variable "application_recovery_service_vault_name" {
  description = "Name of the Recover Service Vault"
  type        = string
  default     = "recovervaultname"
}

variable "application_backup_policy_file_share_name" {
  description = "Name of the backup policy fileshare"
  type        = string
  default     = ""
}

variable "application_backup_policy_vm_name" {
  description = "Name of the backup policy virtual machine"
  type        = string
  default     = "recovervaultname"
}

variable "resource_exists" {
  description = "status of the resource"
  type        = bool
  default     = false
}

variable "vault_resource_group_name" {
  description = "Name of the backup policy virtual machine"
  type        = string
  default     = ""
}


variable "vault_fileshares_policies" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

variable "vault_vm_policies" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}