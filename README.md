<!-- BEGIN_TF_DOCS -->
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Cisco](https://img.shields.io/badge/Developed%20by-Cisco-blue)](https://developer.cisco.com)
[![Tests](https://github.com/terraform-cisco-modules/terraform-intersight-policies-network-connectivity/actions/workflows/terratest.yml/badge.svg)](https://github.com/terraform-cisco-modules/terraform-intersight-policies-network-connectivity/actions/workflows/terratest.yml)

# Terraform Intersight Policies - Network Connectivity
Manages Intersight Network Connectivity Policies

Location in GUI:
`Policies` » `Create Policy` » `Network Connectivity`

## Easy IMM

[*Easy IMM - Comprehensive Example*](https://github.com/terraform-cisco-modules/easy-imm-comprehensive-example) - A comprehensive example for policies, pools, and profiles.

## Example

### main.tf
```hcl
module "network_connectivity" {
  source  = "terraform-cisco-modules/policies-network-connectivity/intersight"
  version = ">= 1.0.1"

  description = "default Network Connectivity Policy."
  dns_servers_v4 = [
    "208.67.220.220",
    "208.67.222.222"
  ]
  enable_ipv6   = false
  name          = "default"
  organization  = "default"
  update_domain = ""
}
```

### provider.tf
```hcl
terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.32"
    }
  }
  required_version = ">=1.3.0"
}

provider "intersight" {
  apikey    = var.apikey
  endpoint  = var.endpoint
  secretkey = fileexists(var.secretkeyfile) ? file(var.secretkeyfile) : var.secretkey
}
```

### variables.tf
```hcl
variable "apikey" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "endpoint" {
  default     = "https://intersight.com"
  description = "Intersight URL."
  type        = string
}

variable "secretkey" {
  default     = ""
  description = "Intersight Secret Key Content."
  sensitive   = true
  type        = string
}

variable "secretkeyfile" {
  default     = "blah.txt"
  description = "Intersight Secret Key File Location."
  sensitive   = true
  type        = string
}
```

## Environment Variables

### Terraform Cloud/Enterprise - Workspace Variables
- Add variable apikey with the value of [your-api-key]
- Add variable secretkey with the value of [your-secret-file-content]

### Linux and Windows
```bash
export TF_VAR_apikey="<your-api-key>"
export TF_VAR_secretkeyfile="<secret-key-file-location>"
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.32 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | >=1.0.32 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description for the Policy. | `string` | `""` | no |
| <a name="input_dns_servers_v4"></a> [dns\_servers\_v4](#input\_dns\_servers\_v4) | List of IPv4 DNS Servers for this DNS Policy. | `list(string)` | <pre>[<br>  "208.67.220.220",<br>  "208.67.222.222"<br>]</pre> | no |
| <a name="input_dns_servers_v6"></a> [dns\_servers\_v6](#input\_dns\_servers\_v6) | List of IPv6 DNS Servers for this DNS Policy. | `list(string)` | `[]` | no |
| <a name="input_domain_profiles"></a> [domain\_profiles](#input\_domain\_profiles) | Map for Moid based Domain Profile Sources. | `any` | `{}` | no |
| <a name="input_enable_dynamic_dns"></a> [enable\_dynamic\_dns](#input\_enable\_dynamic\_dns) | Flag to Enable or Disable Dynamic DNS on the Policy.  Meaning obtain DNS Servers from DHCP Service. | `bool` | `false` | no |
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Flag to Enable or Disable IPv6 on the Policy. | `bool` | `false` | no |
| <a name="input_moids"></a> [moids](#input\_moids) | Flag to Determine if pools and policies should be data sources or if they already defined as a moid. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Policy. | `string` | `"dns"` | no |
| <a name="input_obtain_ipv4_dns_from_dhcp"></a> [obtain\_ipv4\_dns\_from\_dhcp](#input\_obtain\_ipv4\_dns\_from\_dhcp) | Flag to Enable or Disable IPv4 Dynamic DNS Servers on the Policy. | `bool` | `false` | no |
| <a name="input_obtain_ipv6_dns_from_dhcp"></a> [obtain\_ipv6\_dns\_from\_dhcp](#input\_obtain\_ipv6\_dns\_from\_dhcp) | Flag to Enable or Disable IPv6 Dynamic DNS Servers on the Policy. | `bool` | `false` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/. | `string` | `"default"` | no |
| <a name="input_profiles"></a> [profiles](#input\_profiles) | List of Profiles to Assign to the Policy.<br>* name - Name of the Profile to Assign.<br>* object\_type - Object Type to Assign in the Profile Configuration.<br>  - fabric.SwitchProfile - For UCS Domain Switch Profiles.<br>  - server.Profile - For UCS Server Profiles.<br>  - server.ProfileTemplate - For UCS Server Profile Templates. | <pre>list(object(<br>    {<br>      name        = string<br>      object_type = optional(string, "server.Profile")<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of Tag Attributes to Assign to the Policy. | `list(map(string))` | `[]` | no |
| <a name="input_update_domain"></a> [update\_domain](#input\_update\_domain) | Name of the Domain to Update when using Dynamic DNS for the Policy. | `string` | `""` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_moid"></a> [moid](#output\_moid) | Network Connecivity Policy Managed Object ID (moid). |
## Resources

| Name | Type |
|------|------|
| [intersight_networkconfig_policy.network_connectivity](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/networkconfig_policy) | resource |
| [intersight_fabric_switch_profile.profiles](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_switch_profile) | data source |
| [intersight_organization_organization.org_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |
| [intersight_server_profile.profiles](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/server_profile) | data source |
| [intersight_server_profile_template.templates](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/server_profile_template) | data source |
<!-- END_TF_DOCS -->