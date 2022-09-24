#____________________________________________________________
#
# Intersight Organization Data Source
# GUI Location: Settings > Settings > Organizations > {Name}
#____________________________________________________________

data "intersight_organization_organization" "org_moid" {
  name = var.organization
}

#____________________________________________________________
#
# Intersight UCS Domain Profile(s) Data Source
# GUI Location: Profiles > UCS Domain Profiles > {Name}
#____________________________________________________________

data "intersight_fabric_switch_profile" "profiles" {
  for_each = { for v in var.profiles : v => v if v.object_type == "fabric.SwitchProfile" }
  name     = each.value
}


#____________________________________________________________
#
# Intersight UCS Server Profile(s) Data Source
# GUI Location: Profiles > UCS Server Profiles > {Name}
#____________________________________________________________

data "intersight_server_profile" "profiles" {
  for_each = { for v in var.profiles : v.name => v if v.object_type == "server.Profile" }
  name     = each.value.name
}

#__________________________________________________________________
#
# Intersight UCS Server Profile Template(s) Data Source
# GUI Location: Templates > UCS Server Profile Templates > {Name}
#__________________________________________________________________

data "intersight_server_profile_template" "templates" {
  for_each = { for v in var.profiles : v.name => v if v.object_type == "server.ProfileTemplate" }
  name     = each.value.name
}

#__________________________________________________________________
#
# Intersight Network Connectivity Policy
# GUI Location: Policies > Create Policy > Network Connectivity
#__________________________________________________________________

resource "intersight_networkconfig_policy" "network_connectivity" {
  depends_on = [
    data.intersight_fabric_switch_profile.profiles,
    data.intersight_server_profile.profiles,
    data.intersight_server_profile_template.templates,
    data.intersight_organization_organization.org_moid
  ]
  alternate_ipv4dns_server = length(var.dns_servers_v4) > 1 ? var.dns_servers_v4[1] : null
  alternate_ipv6dns_server = length(var.dns_servers_v6) > 1 ? var.dns_servers_v6[1] : null
  description              = var.description != "" ? var.description : "${var.name} Network Connectivity Policy."
  dynamic_dns_domain       = var.update_domain
  enable_dynamic_dns       = var.dynamic_dns
  enable_ipv4dns_from_dhcp = var.dynamic_dns == true ? true : false
  enable_ipv6              = var.ipv6_enable
  enable_ipv6dns_from_dhcp = var.ipv6_enable == true && var.dynamic_dns == true ? true : false
  preferred_ipv4dns_server = length(var.dns_servers_v4) > 0 ? var.dns_servers_v4[0] : null
  preferred_ipv6dns_server = length(var.dns_servers_v6) > 0 ? var.dns_servers_v6[0] : null
  name                     = var.name
  organization {
    moid        = data.intersight_organization_organization.org_moid.results[0].moid
    object_type = "organization.Organization"
  }
  dynamic "profiles" {
    for_each = { for v in var.profiles : v.name => v }
    content {
      moid = length(regexall("fabric.SwitchProfile", profiles.value.object_type)
        ) > 0 ? data.intersight_fabric_switch_profile.profiles[profiles.value.name].results[0
        ].moid : length(regexall("server.ProfileTemplate", profiles.value.object_type)
        ) > 0 ? data.intersight_server_profile_template.templates[profiles.value.name].results[0
      ].moid : data.intersight_server_profile.profiles[profiles.value.name].results[0].moid
      object_type = profiles.value.object_type
    }
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
