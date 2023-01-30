##################################################################################
# Terraform SMC Automation for Non-Production Environment
##################################################################################
# 
# LHD         :     MNCLHD
# File        :     Shared SMC main File to pass the foundation requirments 
# Version     :     v.1.0
# LHD Admins  :     
# Dev         :     Satish
# repo        :     Master
##################################################################################

locals {
  tag_data = csvdecode(file("./Files/tags/tags.csv")) # CSV file path refereing to the rules
  tag_values = flatten([
    for t in local.tag_data : [
      for s in(formatlist("%s", split(",", t.tags))) : {
        trimspace(element((formatlist("%s", split("=", s))), 0)) = trimspace(element((formatlist("%s", split("=", s))), 1))
      }
    ]
  ])
  tags = zipmap(
    flatten(
      [for item in local.tag_values : keys(item)]
    ),
    flatten(
      [for item in local.tag_values : values(item)]
    )
  )
  other_tags = merge(
    { tag1 = "value1" },
    { tag2 = "value2" }
  )
  #'module.Shared_Recovery_Service_Vault_VM_Backup_Policies[\"policy_01\"].azurerm_backup_policy_vm.policy[\"MC-AZ-VM-30Day8W12M5Y-10PM\"]' /subscriptions/35ad5b77-6e27-4c5b-b269-02a49a7936d9/resourceGroups/mcazsh1p-RGP-01/providers/Microsoft.RecoveryServices/vaults/mcazInfp-rsv001/backupPolicies/MC-AZ-VM-30Day8W12M5Y-10PM

  backup_policies_vm = ["MC-AZ-VM-30Day8W12M5Y-10PM", "MC-AZ-VM-7Day4W12M-10PM", "MC-AZ-VM-7Day-10PM"]
  vault_backup_policies = {
    policy_01 = "MC-AZ-VM-30Day8W12M5Y-10PM",
    policy_02 = "MC-AZ-VM-7Day4W12M-10PM",
    policy_03 = "MC-AZ-VM-7Day-10PM"
  }
  vm_backup_policies = {

    policy_01 = { name = "MC-AZ-VM-30Day8W12M5Y-10PM",
      frequency       = "Daily",
      time            = "22:00",
      retention_daily = { count = "30" }
      retention_weekly = { count = "8",
        weekdays = ["Sunday"],
      }
      retention_monthly = { count = "12",
        weekdays = ["Sunday"],
        weeks    = ["First"]
      }
      retention_yearly = { count = "5",
        months   = ["January"]
        weekdays = ["Sunday"],
        weeks    = ["First"]
      }
      tags = {}
    }
    policy_02 = { name = "MC-AZ-VM-7Day4W12M-10PM",
      frequency       = "Daily",
      time            = "22:00",
      retention_daily = { count = "7" }
      retention_weekly = { count = "4",
        weekdays = ["Sunday"],
      }
      retention_monthly = { count = "12",
        weekdays = ["Sunday"],
        weeks    = ["First"]
      }
      retention_yearly = { count = 0,
        months   = [],
        weekdays = [],
        weeks    = []
      }
      tags = {}
    }
    policy_03 = { name = "MC-AZ-VM-7Day-10PM",
      frequency       = "Daily",
      time            = "22:00",
      retention_daily = { count = "7" }
      retention_weekly = { count = 0,
        weekdays = [],
      }
      retention_monthly = { count = 0,
        weekdays = [],
        weeks    = []
      }
      retention_yearly = { count = 0,
        months   = [],
        weekdays = [],
        weeks    = []
      }
      tags = {}
    }
    /* policy_04 = {       name                = "pt1p-vm-bkup-prod",
                                                frequency           = "Daily",
                                                time                = "02:00",
                                                retention_daily     =   {   count   = "7"}
                                                retention_weekly     =  {   count   = "4",
                                                                            weekdays = ["Sunday"],
                                                                        }
                                                retention_monthly     = {   count   = 0,
                                                                            weekdays = [],
                                                                            weeks    = []
                                                                        }
                                                retention_yearly      = {   count   = 0,
                                                                            months   = [],
                                                                            weekdays = [],
                                                                            weeks    = []
                                                                        }
                                                            tags      = {}
                            }*/
  }
}

# Resource - NSG Rules
#**************************************************************

# Resource - NSG Rules
#**************************************************************
module "Shared_Network_Security_Group_Rules" {


  source                      = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-nsg-rules-csv.git"
  network_security_group_name = var.shared_network_security_group_name
  resource_group_name         = data.azurerm_resource_group.smc_shared_01.name
  location                    = data.azurerm_resource_group.smc_shared_01.location
  csv_file_name_nsg           = var.shared_csv_file_name_nsg
}

# Resource - Recovery_Service_Vault
#**************************************************************
module "Shared_Recovery_Service_Vault" {

  source              = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-recovery-vault.git"
  name                = var.shared_recovery_service_vault_name
  resource_group_name = data.azurerm_resource_group.smc_shared_01.name
  location            = data.azurerm_resource_group.smc_shared_01.location
  storage_mode_type   = var.storage_mode_type

  # VM File Share Policy Details
  backup_policy_file_share_name = null

  # shared SMC Policy Details
  backup_policy_vm_name = var.shared_backup_policy_vm_name
  backup_policy_vm = {
    frequency = "Daily"
    time      = "02:00"
  }
  retention_daily_policy_vm = {
    count = 7
  }
  retention_weekly_policy_vm = {
    count    = 4
    weekdays = ["Sunday"]
  }
  retention_monthly_policy_vm = {
    count    = 12
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }
  tags = local.tags
}

# Resource - Recovery_Service_Vault_VM_Backup_Polcies
#**************************************************************
module "Shared_Recovery_Service_Vault_VM_Backup_Policies" {
  for_each                  = local.vm_backup_policies
  source                    = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-recovery-vault_backup_policies.git"
  name                      = var.shared_recovery_service_vault_name
  resource_group_name       = data.azurerm_resource_group.smc_application_01.name
  location                  = data.azurerm_resource_group.smc_application_01.location
  vault_resource_group_name = data.azurerm_resource_group.smc_shared_01.name

  # VM Policy List
  #backup_policy_vm_name = "MC-AZ-VM-30Day8W12M5Y-10PM"
  backup_policy_vm_name = each.value.name
  backup_policy_vm = {
    frequency = each.value.frequency
    time      = each.value.time
  }

  retention_daily_policy_vm = each.value.retention_daily.count != 0 ? {
    count = each.value.retention_daily.count
  } : null

  retention_weekly_policy_vm = each.value.retention_weekly.count != 0 ? {
    count    = each.value.retention_weekly.count
    weekdays = each.value.retention_weekly.weekdays
  } : null
  retention_monthly_policy_vm = each.value.retention_monthly.count != 0 ? {
    count    = each.value.retention_monthly.count
    weekdays = each.value.retention_monthly.weekdays
    weeks    = each.value.retention_monthly.weeks
  } : null
  retention_yearly_policy_vm = each.value.retention_yearly.count != 0 ? {
    count    = each.value.retention_yearly.count
    weekdays = each.value.retention_yearly.weekdays
    weeks    = each.value.retention_yearly.weeks
    months   = each.value.retention_yearly.months
  } : null
}

# Resource - Log Analaytical Workspace
#**************************************************************
module "Shared_Log_Analytical_Workspace" {

  source              = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-log-analytical-workspace-v1.git"
  name                = var.shared_log_analytical_workspace_name
  resource_group_name = data.azurerm_resource_group.smc_shared_01.name
  location            = data.azurerm_resource_group.smc_shared_01.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
  solutions = [
    {
      solution_name = "VMInsights",
      publisher     = "Microsoft",
      product       = "OMSGallery/VMInsights"
    },
  ]

  windows_event_logs = {
    Application = {
      name           = "Application"
      event_log_name = "Application"
      event_types    = ["error", "Warning"]
    },
    System = {
      name           = "System"
      event_log_name = "System"
      event_types    = ["error", "Warning"]
    },
    Key_Management_Service = {
      name           = "Key_Management_Service"
      event_log_name = "Key_Management_Service"
      event_types    = ["error", "Warning"]
    }
  }

  windows_performance_counters = {
    counter1 = {
      name             = "Free Space"
      object_name      = "Logical Disk"
      instance_name    = "*"
      counter_name     = "LogicalDisk(*)\\% Free Space"
      interval_seconds = 120
    },
    counter2 = {
      name             = "Available MBytes"
      object_name      = "Memory"
      instance_name    = "*"
      counter_name     = "Memory(*)\\Available MBytes"
      interval_seconds = 120
    },
    counter3 = {
      name             = "Processor Queue Length"
      object_name      = "System"
      instance_name    = "*"
      counter_name     = "System(*)\\Processor Queue Length"
      interval_seconds = 120
    },
    counter4 = {
      name             = "Processor Time"
      object_name      = "Processor"
      instance_name    = "*"
      counter_name     = "Processor(_Total)\\% Processor Time"
      interval_seconds = 120
    },
    counter5 = {
      name             = "Bytes Received sec"
      object_name      = "Network Adapter"
      instance_name    = "*"
      counter_name     = "Network Adapter(*)\\Bytes Received/sec"
      interval_seconds = 120
    },
    counter6 = {
      name             = "Bytes Sent sec"
      object_name      = "Network Adapter"
      instance_name    = "*"
      counter_name     = "Network Adapter(*)\\Bytes Sent/sec"
      interval_seconds = 120
    },
    counter7 = {
      name             = "Avg. Disk sec Read"
      object_name      = "LogicalDisk"
      instance_name    = "*"
      counter_name     = "LogicalDisk(*)\\Avg. Disk sec/Read"
      interval_seconds = 120
    },
    counter8 = {
      name             = "Avg. Disk sec Write"
      object_name      = "LogicalDisk"
      instance_name    = "*"
      counter_name     = "LogicalDisk(*)\\Avg. Disk sec/Write"
      interval_seconds = 120
    }
  }
  tags = local.tags
}

# Resource - Key Vault
#**************************************************************
module "Shared_Key_Vault" {
  source = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-key-vault.git"

  name                        = var.shared_key_vault_name
  resource_group_name         = data.azurerm_resource_group.smc_shared_01.name
  location                    = data.azurerm_resource_group.smc_shared_01.location
  purge_protection_enabled    = true
  enabled_for_disk_encryption = true
  access_policies             = []
  keys                        = []
  disk_encryption_set         = []
  #tenant_id                               = data.azurerm_client_config.current.tenant_id
  #object_id                               = data.azurerm_client_config.current.object_id
  #access_policies                         = { }
  #depends_on                              = [module.Storage_Account]
}
##################################################################################