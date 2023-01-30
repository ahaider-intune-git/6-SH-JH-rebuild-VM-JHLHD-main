#**************************************************************
# Policy as a Code
#**************************************************************

# Data - Policy Set definiation reference
#**************************************************************
data "azurerm_policy_set_definition" "MNC_Policy_Initative_Generic" {
  display_name = "MNC_Policy_Initative_Generic"
}

data "azurerm_policy_set_definition" "MNC_Policy_Initative_Compute" {
  display_name = "MNC_Policy_Initative_Compute"
}

data "azurerm_policy_set_definition" "MNC_Policy_Initative_Security" {
  display_name = "MNC_Policy_Initative_Security"
}

data "azurerm_policy_set_definition" "MNC_Policy_Initative_Tag_Governance" {
  display_name = "MNC_Policy_Initative_Tag_Governance"
}
data "azurerm_policy_set_definition" "MNC_Policy_Initative_Storage" {
  display_name = "MNC_Policy_Initative_Storage"
}

data "azurerm_policy_set_definition" "MNC_Policy_Initative_Monitoring" {
  display_name = "MNC_Policy_Initative_Monitoring"
}

#****************************************************************************************************************************

##########################################################################################################################
# Policy Assignment  - Application SMC
##########################################################################################################################

module "MNC_Application_Policy_Assignment_Generic" {
  source                     = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-policy-assignment.git"
  assignment_name            = "MNC_mcazap1p-RGP-01_Policy_Assignment_Generic"
  resource_group_name_id     = data.azurerm_resource_group.smc_application_01.id
  policy_definition_id       = data.azurerm_policy_set_definition.MNC_Policy_Initative_Generic.id
  location                   = data.azurerm_resource_group.smc_application_01.location
  policy_definition_category = "Generic"
  description                = "Application SMC mcazap1p-RGP-01 - Generic Policy assignment"
  assignment_parameters = {
    listOfAllowedLocations = ["australiaeast", "australiasoutheast"]
  }
}

module "MNC_Application_Policy_Assignment_Compute" {
  source                     = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-policy-assignment.git"
  assignment_name            = "MNC_mcazap1p-RGP-01_Policy_Assignment_Compute"
  resource_group_name_id     = data.azurerm_resource_group.smc_application_01.id
  policy_definition_id       = data.azurerm_policy_set_definition.MNC_Policy_Initative_Compute.id
  location                   = data.azurerm_resource_group.smc_application_01.location
  policy_definition_category = "Compute"
  description                = "Application SMC mcazap1p-RGP-01 - Compute Policy assignment"

  assignment_parameters = {
    listOfAllowedSKUs = ["standard_ds1_v2", "standard_d2s_v3", "standard_d2as_v4", "standard_b2s", "standard_B1ms", "standard_B1s", "standard_B2ms", "standard_B1ls", "standard_DS2_v2", "standard_B4ms", "standard_D4s_v3",
      "standard_DS3_v2", "standard_D8s_v3", "standard_D2ds_v4", "standard_D2s_v4", "standard_D4as_v4", "standard_D4ds_v4", "standard_D4s_v4", "standard_D8as_v4", "standard_D8ds_v4", "standard_D8s_v4", "standard_E2as_v4",
    "standard_E2ds_v4", "standard_E2s_v4", "standard_E4-2ds_v4", "standard_E4-2s_v4", "standard_E8-2ds_v4c", "standard_E4as_v4", "standard_E4ds_v4", "standard_E4s_v4", "standard_F2s_v2", "standard_F4s_v2", "standard_F8s_v2"],
    #"standard_d2_v4"
    #managed_disk_diskAccessId   = "",
    managed_disk_location = "australiaeast",
    npd_WorkspaceId       = data.azurerm_log_analytics_workspace.log_workspace.id,
    npd_WorkspaceKey      = data.azurerm_log_analytics_workspace.log_workspace.primary_shared_key,
    #managed_disk_effect         = "Modify",
    #npd_law_EnvironmentTagValue = "Prod",
    #npd_law_effect              = "DeployIfNotExists"
    vm_min_disk_size = "4"
    vm_max_disk_size = "1024"
  }
}

module "MNC_Application_Policy_Assignment_Security" {
  source                     = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-policy-assignment.git"
  assignment_name            = "MNC_mcazap1p-RGP-01_Policy_Assignment_Security"
  resource_group_name_id     = data.azurerm_resource_group.smc_application_01.id
  policy_definition_id       = data.azurerm_policy_set_definition.MNC_Policy_Initative_Security.id
  location                   = data.azurerm_resource_group.smc_application_01.location
  policy_definition_category = "Security"
  description                = "Application SMC mcazap1p-RGP-01 - Security Policy assignment"
  assignment_parameters = {
    RDP_effect       = "Audit",
    key_vault_effect = "Audit",
    SSH_effect       = "Audit"
  }
}

module "MNC_Application_Policy_Assignment_Tag_Governance" {
  source                     = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-policy-assignment.git"
  assignment_name            = "MNC_mcazap1p-RGP-01_Policy_Assignment_Tag_Governance"
  resource_group_name_id     = data.azurerm_resource_group.smc_application_01.id
  policy_definition_id       = data.azurerm_policy_set_definition.MNC_Policy_Initative_Tag_Governance.id
  location                   = data.azurerm_resource_group.smc_application_01.location
  policy_definition_category = "Tag_Governance"
  description                = "Application SMC mcazap1p-RGP-01 - Tag_Governance Policy assignment"
  assignment_parameters = {
    RL_tagName  = "Environment",
    RL_tagValue = "Production"

    Application_Name_tagName  = "AutoShutdownSchedule",
    Application_Name_tagValue = "AutoShutdownSchedule",

    Data_Classification_tagName  = "VMOperationalHours",
    Data_Classification_tagValue = "VMOperationalHours",

    Environment_tagName  = "Environment",
    Environment_tagValue = "Application",

    Department_tagName  = "Terraform",
    Department_tagValue = "Terraform",

    Maintenance_tagName  = "VMMaintenceWindow",
    Maintenance_tagValue = "VMMaintenceWindow",

    CostCode_tagName  = "Cost Center",
    CostCode_tagValue = "Cost Center",

    BusinessOwner_tagName  = "Description",
    BusinessOwner_tagValue = "Description",
  }
}

module "MNC_Application_Policy_Assignment_Storage" {
  source                     = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-policy-assignment.git"
  assignment_name            = "MNC_mcazap1p-RGP-01_Policy_Assignment_Storage"
  resource_group_name_id     = data.azurerm_resource_group.smc_application_01.id
  policy_definition_id       = data.azurerm_policy_set_definition.MNC_Policy_Initative_Storage.id
  location                   = data.azurerm_resource_group.smc_application_01.location
  policy_definition_category = "Storage"
  description                = "Application SMC mcazap1p-RGP-01 - Storage Policy assignment"
  assignment_parameters = {
    sa_listOfAllowedSKUs        = ["Standard_LRS"],
    sa_listOfAllowedSKUs_effect = "Deny",
    sa_pub_access_effect        = "Audit",
    sa_restrict_network_effect  = "Audit"
  }
}

module "MNC_Application_Policy_Assignment_Monitoring" {
  source                     = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-policy-assignment.git"
  assignment_name            = "MNC_mcazap1p-RGP-01_Policy_Assignment_Monitoring"
  resource_group_name_id     = data.azurerm_resource_group.smc_application_01.id
  policy_definition_id       = data.azurerm_policy_set_definition.MNC_Policy_Initative_Monitoring.id
  location                   = data.azurerm_resource_group.smc_application_01.location
  policy_definition_category = "Monitoring"
  description                = "Application SMC mcazap1p-RGP-01 - Monitoring Policy assignment"
  assignment_parameters = {
    effect = "Deny",
    listOfResourceTypesNotAllowed = ["84Codes.CloudAMQP/*",
      "Crypteron.DataSecurity/*",
      "Microsoft.AISuperComputer/*",
      "Microsoft.AVS/*",
      "Microsoft.AzureStack/*",
      "Microsoft.AzureStackHCI/*",
      "Microsoft.BlockChain/*",
      "Microsoft.BlockChainTokens/*",
      "Microsoft.BotService/*",
      "Microsoft.ConnectedVMwarevSphere/*",
      "Microsoft.ContainerInstance/*",
      "Microsoft.ContainerRegistry/*",
      "Microsoft.ContainerService/*",
      "Microsoft.DataBox/*",
      "Microsoft.DataboxEdge/*",
      "Microsoft.DataFactory/*",
      "Microsoft.HanaOnAzure/*",
      "Microsoft.HardwareSecurityModules/*",
      "Microsoft.HDInsight/*",
      "Microsoft.IoTCentral/*",
      "Microsoft.IoTSecurity/*",
      "Microsoft.MachineLearning/*",
      "Microsoft.MachineLearningServices/*",
      "Microsoft.NetApp/*",
      "Microsoft.Network",
      "applicationGateways/*",
      "azureFirewall/*",
      "dnszones/*",
      "ExpressRoute/*",
      "frontDoors/*",
      "localnetworkGateways",
      "virtualHubs/*",
      "virtualNetworkGateways",
      "vpnGateways/*",
      "Microsoft.SignalIRService/*",
    "Microsoft.VMware/*"]

  }
}

##########################################################################################################################
# Policy Assignment  - Shared SMC
##########################################################################################################################
##
module "MNC_Shared_Policy_Assignment_Generic" {
  source                     = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-policy-assignment.git"
  assignment_name            = "MNC_mcazsh1p-RGP-01_Policy_Assignment_Generic"
  resource_group_name_id     = data.azurerm_resource_group.smc_shared_01.id
  policy_definition_id       = data.azurerm_policy_set_definition.MNC_Policy_Initative_Generic.id
  location                   = data.azurerm_resource_group.smc_shared_01.location
  policy_definition_category = "Generic"
  description                = "Application SMC mcazsh1p-RGP-01 - Generic Policy assignment"
  assignment_parameters = {
    listOfAllowedLocations = ["australiaeast", "australiasoutheast"]
  }
}
##
module "MNC_Shared_Policy_Assignment_Compute" {
  source                     = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-policy-assignment.git"
  assignment_name            = "MNC_mcazsh1p-RGP-01_Policy_Assignment_Compute"
  resource_group_name_id     = data.azurerm_resource_group.smc_shared_01.id
  policy_definition_id       = data.azurerm_policy_set_definition.MNC_Policy_Initative_Compute.id
  location                   = data.azurerm_resource_group.smc_shared_01.location
  policy_definition_category = "Compute"
  description                = "Shared SMC mcazsh1p-RGP-01 - Compute Policy assignment"

  assignment_parameters = {
    listOfAllowedSKUs = ["standard_ds1_v2", "standard_d2s_v3", "standard_d2as_v4", "standard_b2s", "standard_B1ms", "standard_B1s", "standard_B2ms", "standard_B1ls", "standard_DS2_v2", "standard_B4ms", "standard_D4s_v3", "standard_DS3_v2", "standard_D8s_v3", "standard_D2ds_v4", "standard_D2s_v4", "standard_D4as_v4", "standard_D4ds_v4", "standard_D4s_v4", "standard_D8as_v4", "standard_D8ds_v4", "standard_D8s_v4", "standard_E2as_v4", "standard_E2ds_v4", "standard_E2s_v4", "standard_E4-2ds_v4", "standard_E4-2s_v4", "standard_E8-2ds_v4c", "standard_E4as_v4", "standard_E4ds_v4", "standard_E4s_v4", "standard_F2s_v2", "standard_F4s_v2", "standard_F8s_v2"],
    #managed_disk_diskAccessId   = "/subscriptions/f38ea19d-7615-4622-8b99-1af07f91c264/resourcegroups/azsws-shinf-prd01-rgp-01/providers/microsoft.compute/diskaccesses/azsws-shinf-prd01-dsa01",
    managed_disk_location = "australiaeast",
    npd_WorkspaceId       = data.azurerm_log_analytics_workspace.log_workspace.id,
    npd_WorkspaceKey      = data.azurerm_log_analytics_workspace.log_workspace.primary_shared_key,
    #managed_disk_effect         = "Modify",
    #npd_law_EnvironmentTagValue = "Prod",
    #npd_law_effect              = "DeployIfNotExists"
    #vm_min_disk_size             = "4"
    vm_max_disk_size = "1024"
  }
}
##
module "MNC_Shared_Policy_Assignment_Security" {
  source                     = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-policy-assignment.git"
  assignment_name            = "MNC_mcazsh1p-RGP-01_Policy_Assignment_Security"
  resource_group_name_id     = data.azurerm_resource_group.smc_shared_01.id
  policy_definition_id       = data.azurerm_policy_set_definition.MNC_Policy_Initative_Security.id
  location                   = data.azurerm_resource_group.smc_shared_01.location
  policy_definition_category = "Security"
  description                = "Shared SMC mcazsh1p-RGP-01 - Security Policy assignment"
  assignment_parameters = {
    RDP_effect       = "Audit",
    key_vault_effect = "Audit",
    SSH_effect       = "Audit"
  }
}
##
module "MNC_Shared_Policy_Assignment_Tag_Governance" {
  source                     = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-policy-assignment.git"
  assignment_name            = "MNC_mcazsh1p-RGP-01_Policy_Assignment_Tag_Governance"
  resource_group_name_id     = data.azurerm_resource_group.smc_shared_01.id
  policy_definition_id       = data.azurerm_policy_set_definition.MNC_Policy_Initative_Tag_Governance.id
  location                   = data.azurerm_resource_group.smc_shared_01.location
  policy_definition_category = "Tag_Governance"
  description                = "Shared SMC mcazsh1p-RGP-01 - Tag_Governance Policy assignment"
  assignment_parameters = {
    RL_tagName  = "Environment",
    RL_tagValue = "Production"

    Application_Name_tagName  = "AutoShutdownSchedule",
    Application_Name_tagValue = "",

    Data_Classification_tagName  = "VMMaintenceWindow",
    Data_Classification_tagValue = "",

    Environment_tagName  = "Environment",
    Environment_tagValue = "Application",

    Department_tagName   = "Terraform",
    Department_tagValue  = "",
    Maintenance_tagName  = "VMOperationalHours",
    Maintenance_tagValue = "",

    CostCode_tagName  = "Cost Center",
    CostCode_tagValue = "",

    BusinessOwner_tagName  = "Description",
    BusinessOwner_tagValue = "",
  }
}
##
module "MNC_Shared_Policy_Assignment_Storage" {
  source                     = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-policy-assignment.git"
  assignment_name            = "MNC_mcazsh1p-RGP-01_Policy_Assignment_Storage"
  resource_group_name_id     = data.azurerm_resource_group.smc_shared_01.id
  policy_definition_id       = data.azurerm_policy_set_definition.MNC_Policy_Initative_Storage.id
  location                   = data.azurerm_resource_group.smc_shared_01.location
  policy_definition_category = "Storage"
  description                = "Shared SMC mcazsh1p-RGP-01 - Storage Policy assignment"
  assignment_parameters = {
    sa_listOfAllowedSKUs        = ["Standard_LRS"],
    sa_listOfAllowedSKUs_effect = "Deny",
    sa_pub_access_effect        = "Audit",
    sa_restrict_network_effect  = "Audit"
  }
}

module "MNC_Shared_Policy_Assignment_Monitoring" {
  source                     = "git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-policy-assignment.git"
  assignment_name            = "MNC_mcazsh1p-RGP-01_Policy_Assignment_Monitoring"
  resource_group_name_id     = data.azurerm_resource_group.smc_shared_01.id
  policy_definition_id       = data.azurerm_policy_set_definition.MNC_Policy_Initative_Monitoring.id
  location                   = data.azurerm_resource_group.smc_shared_01.location
  policy_definition_category = "Monitoring"
  description                = "Shared SMC mcazsh1p-RGP-01 - Monitoring Policy assignment"
  assignment_parameters = {
    effect = "Deny",
    listOfResourceTypesNotAllowed = ["84Codes.CloudAMQP/*",
      "Crypteron.DataSecurity/*",
      "Microsoft.AISuperComputer/*",
      "Microsoft.AVS/*",
      "Microsoft.AzureStack/*",
      "Microsoft.AzureStackHCI/*",
      "Microsoft.BlockChain/*",
      "Microsoft.BlockChainTokens/*",
      "Microsoft.BotService/*",
      "Microsoft.ConnectedVMwarevSphere/*",
      "Microsoft.ContainerInstance/*",
      "Microsoft.ContainerRegistry/*",
      "Microsoft.ContainerService/*",
      "Microsoft.DataBox/*",
      "Microsoft.DataboxEdge/*",
      "Microsoft.DataFactory/*",
      "Microsoft.HanaOnAzure/*",
      "Microsoft.HardwareSecurityModules/*",
      "Microsoft.HDInsight/*",
      "Microsoft.IoTCentral/*",
      "Microsoft.IoTSecurity/*",
      "Microsoft.MachineLearning/*",
      "Microsoft.MachineLearningServices/*",
      "Microsoft.NetApp/*",
      "Microsoft.Network",
      "applicationGateways/*",
      "azureFirewall/*",
      "dnszones/*",
      "ExpressRoute/*",
      "frontDoors/*",
      "localnetworkGateways",
      "virtualHubs/*",
      "virtualNetworkGateways",
      "vpnGateways/*",
      "Microsoft.SignalIRService/*",
    "Microsoft.VMware/*"]

  }
}








