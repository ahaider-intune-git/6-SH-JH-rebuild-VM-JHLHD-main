################################################################################## 
# Data - Pulling the information of existing resources 
##################################################################################
# 
# LHD         :     MNCLHS
# File        :     One Variable Form 
# version     :     v.1.0
# Dev         :     Satish
##################################################################################

# Data - Curent Client Config Details  
# ************************************************
data "azurerm_client_config" "current" {
}

data "azurerm_subscription" "current" {
}

# Data - SMC Details - Australia East
# ************************************************
data "azurerm_resource_group" "smc_shared_01" {
  name = var.resource_group_name_shared_01
}

data "azurerm_resource_group" "smc_platform_01" {
  name = var.resource_group_name_platform_01
}

data "azurerm_resource_group" "smc_platform_02" {
  name = var.resource_group_name_platform_02
}

data "azurerm_resource_group" "smc_application_01" {
  name = var.resource_group_name_application_01
}


data "azurerm_log_analytics_workspace" "log_workspace" {
  name                = "mcazinfp-law001"
  resource_group_name = var.resource_group_name_shared_01
}
/*
# Data - SMC Details - Provider Details
# ************************************************
data "azurerm_virtual_network" "smc_vnet" {
  name                = var.provider_vnet_name
  resource_group_name = var.provider_smc_name
}

data "azurerm_subnet" "smc_subnet" {
  name                 = var.provider_subnet_name
  virtual_network_name = data.azurerm_virtual_network.smc_vnet.name
  resource_group_name  = var.provider_smc_name
}
*/