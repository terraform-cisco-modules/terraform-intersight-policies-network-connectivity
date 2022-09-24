#____________________________________________________________
#
# Network Connectivity Policy Variables Section.
#____________________________________________________________

variable "description" {
  default     = ""
  description = "Description for the Policy."
  type        = string
}

variable "dns_servers_v4" {
  default     = ["208.67.220.220", "208.67.222.222"]
  description = "List of IPv4 DNS Servers for this DNS Policy."
  type        = list(string)
}

variable "dns_servers_v6" {
  default     = []
  description = "List of IPv6 DNS Servers for this DNS Policy."
  type        = list(string)
}

variable "dynamic_dns" {
  default     = false
  description = "Flag to Enable or Disable Dynamic DNS on the Policy.  Meaning obtain DNS Servers from DHCP Service."
  type        = bool
}

variable "ipv6_enable" {
  default     = false
  description = "Flag to Enable or Disable IPv6 on the Policy."
  type        = bool
}

variable "name" {
  default     = "dns"
  description = "Name for the Policy."
  type        = string
}

variable "organization" {
  default     = "default"
  description = "Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/."
  type        = string
}

variable "profiles" {
  default     = []
  description = <<-EOT
    List of Profiles to Assign to the Policy.
    * name - Name of the Profile to Assign.
    * object_type - Object Type to Assign in the Profile Configuration.
      - fabric.SwitchProfile - For UCS Domain Switch Profiles.
      - server.Profile - For UCS Server Profiles.
      - server.ProfileTemplate - For UCS Server Profile Templates.
  EOT
  type = list(object(
    {
      name        = string
      object_type = optional(string, "server.Profile")
    }
  ))
}

variable "tags" {
  default     = []
  description = "List of Tag Attributes to Assign to the Policy."
  type        = list(map(string))
}

variable "update_domain" {
  default     = ""
  description = "Name of the Domain to Update when using Dynamic DNS for the Policy."
  type        = string
}

