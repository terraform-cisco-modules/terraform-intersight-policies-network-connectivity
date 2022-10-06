terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.32"
    }
  }
}

# Setup provider, variables and outputs
provider "intersight" {
  apikey    = var.intersight_keyid
  secretkey = file(var.intersight_secretkeyfile)
  endpoint  = var.intersight_endpoint
}

variable "intersight_keyid" {}
variable "intersight_secretkeyfile" {}
variable "intersight_endpoint" {
  default = "intersight.com"
}
variable "name" {}

output "moid" {
  value = module.main.moid
}

# This is the module under test
module "main" {
  source      = "../.."
  description = "${var.name} DNS Policy."
  dns_servers_v4 = [
    "208.67.220.220",
    "208.67.222.222"
  ]
  dns_servers_v6 = [
    "2620:119:35::35",
    "2620:119:53::53"
  ]
  enable_dynamic_dns        = true
  enable_ipv6               = true
  name                      = var.name
  obtain_ipv4_dns_from_dhcp = false
  organization              = "terratest"
  update_domain             = "example.com"
}
