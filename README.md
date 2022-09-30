<!-- BEGIN_TF_DOCS -->
# Terraform Intersight Policies - Network Connectivity
Manages Intersight Network Connectivity Policies

Location in GUI:
`Policies` » `Create Policy` » `Network Connectivity`

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
  secretkey = var.secretkey
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
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}
```

## Environment Variables

### Terraform Cloud/Enterprise - Workspace Variables
- Add variable apikey with value of [your-api-key]
- Add variable secretkey with value of [your-secret-file-content]

### Linux
```bash
export TF_VAR_apikey="<your-api-key>"
export TF_VAR_secretkey=`cat <secret-key-file-location>`
```

### Windows
```bash
$env:TF_VAR_apikey="<your-api-key>"
$env:TF_VAR_secretkey="<secret-key-file-location>"
```
<!-- END_TF_DOCS -->