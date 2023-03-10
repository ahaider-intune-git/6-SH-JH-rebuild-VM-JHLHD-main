## azure-foundation-services-he-MNCLHD
Azure Foundation Services for MNC LHD

## The Module created the following 
NSG rules - Platform SMC 
## Requirements
No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| Platform_Network_Security_Group_Rules | git::https://git.health.nsw.gov.au/ehnsw-swdcr/terraform-azurerm-nsg-rules-csv.git |  |

## Resources

| Name |
|------|
| [azurerm_client_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) |
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) |
| [azurerm_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | Account ID | `string` | `""` | no |
| azure\_region\_01 | Azure region 01 | `string` | `""` | no |
| azure\_region\_02 | Azure region 02 | `string` | `""` | no |
| client\_id | Enter Client ID for applications created in Azure AD | `string` | `""` | no |
| client\_name | Client Name details | `string` | `""` | no |
| client\_secret | Enter Client secret for Application in Azure AD | `string` | `""` | no |
| environment | Azure SMC Environment | `string` | `"Non_Prod"` | no |
| location\_01 | location 01 | `string` | `""` | no |
| location\_02 | location 02 | `string` | `""` | no |
| name | Azure resource name | `string` | `""` | no |
| object\_id | Object ID | `string` | `""` | no |
| platform\_csv\_file\_name\_nsg | Name of the NSG Rules CSV File | `string` | `"platform_nsg_rules"` | no |
| platform\_network\_security\_group\_name | Platform SMC Name | `string` | `"mcazpt1p-NSG-01"` | no |
| provider\_smc\_name | Resource group name | `string` | `"Provider-INF-RGP-01"` | no |
| provider\_subnet\_name | Provider Subnet Name | `string` | `"mcazpt1p-SNET-01"` | no |
| provider\_vnet\_name | Provider Vnet Name | `string` | `"Provider-INF-VNET-01"` | no |
| resource\_group\_name\_platform\_01 | Name of the Platform SMC | `string` | `"mcazpt1p-RGP-01"` | no |
| resource\_group\_name\_shared\_01 | Name of the Shared SMC | `string` | `"mcazsh1p-RGP-01"` | no |
| subscription\_id | Enter the subscription ID for provisioning resources in Azure | `string` | `""` | no |
| tenant\_id | Tenant id of the subsrciption | `string` | `""` | no |


## Modules Reference 

| Module_Name                          | Resource                        | Status |
|------                                |-------------                    |------|
| Shared_Network_Security_Group_Rules  | Network_Security_Group_Rules    | "" |
| Shared_Recovery_Service_Vault  | Recovery_Service_Vault    | "" |
| Shared_Log_Analytical_Workspace  | Log_Analytical_Workspace    | "" |
| Platform_Network_Security_Group_Rules  | Network_Security_Group_Rules    | "" |
| Platform_Recovery_Service_Vault  | Recovery_Service_Vault    | "" |
## Outputs

No output.


terraform apply --target='module.MNC_Shared_Policy_Assignment_Generic' --auto-approve
terraform apply --target='module.MNC_Shared_Policy_Assignment_Compute' --auto-approve
terraform apply --target='module.MNC_Shared_Policy_Assignment_Security' --auto-approve
terraform apply --target='module.MNC_Shared_Policy_Assignment_Tag_Governance' --auto-approve
terraform apply --target='module.MNC_Shared_Policy_Assignment_Storage' --auto-approve
terraform apply --target='module.MNC_Shared_Policy_Assignment_Monitoring' --auto-approve



Chnages required
module.Application_SMC_Recovery_Service_Vault.data.azurerm_recovery_services_vault.recovery_vault
module.Application_SMC_Recovery_Service_Vault.azurerm_backup_policy_vm.policy["ap1p-vm-bkup-prod"]

module.Platform_Recovery_Service_Vault.data.azurerm_recovery_services_vault.recovery_vault
module.Platform_Recovery_Service_Vault.azurerm_backup_policy_vm.policy["pt1p-vm-bkup-prod"]

module.Shared_Recovery_Service_Vault.azurerm_backup_policy_vm.example[0]
module.Shared_Recovery_Service_Vault.azurerm_recovery_services_vault.recovery_vault

module.Shared_Recovery_Service_Vault_VM_Backup_Policies["policy_01"].azurerm_backup_policy_vm.policy["MC-AZ-VM-30Day8W12M5Y-10PM"]
module.Shared_Recovery_Service_Vault_VM_Backup_Policies["policy_02"].azurerm_backup_policy_vm.policy["MC-AZ-VM-7Day4W12M-10PM"]
module.Shared_Recovery_Service_Vault_VM_Backup_Policies["policy_03"].azurerm_backup_policy_vm.policy["MC-AZ-VM-7Day-10PM"]