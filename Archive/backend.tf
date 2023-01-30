
#############################################################################
# Terraform Azure backend for statefile on blob storage 
############################################################################# 
# 
# File      :   backend to store the terraform state file 
# Version   :   v1.0
#
#############################################################################

# container for Terraform State file as backend in storage account 
# *****************************************************************

terraform {
  backend "azurerm" {
    #lhd_name             = "SH-JH_LHD"
    #pgm_name             = "SwDCR"
    #Organization         = "SH-eHealth"

    subscription_id      = "97a0f7b9-3bf7-4c59-99a8-064c85ed7df7"          # Id of the Subscription
    #storage_account_name = "cs1100300008792a77d"                                 # name of the storage account where the backend file is stored
    #container_name       = "mnclhd-terraform"                              # name of the storage account container where the backend file is stored
    #key                  = "StateFiles/MNCLHD-Platform-Shared-SMC.tfstate" # name of the state file to be saved
    #resource_group_name  = "mcazsh1p-RGP-01"                               # name of the smc where the storage account is configured
    #access_key           = ""
    #workspaces           = {name = "MNCLHD_NProd_australiaeast"}

  }
}
