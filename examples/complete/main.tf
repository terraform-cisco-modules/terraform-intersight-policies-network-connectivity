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
