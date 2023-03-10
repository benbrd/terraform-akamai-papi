# data source that contains the Akamai group based on the name supplied in a variable. A group is tied to an Akamai contract.
data "akamai_group" "group" {
  group_name  = var.group_name
  contract_id = var.contract_id
}

# data source that contains the Akamai contract. An Akamai contract contains all the entitlements and Akamai product/solution usage.
data "akamai_contract" "contract" {
  group_name = var.group_name
}

data "akamai_property_hostnames" "hostnames" {
  contract_id = var.contract_id
  group_id    = trimprefix(data.akamai_group.group.id, "grp_")
  property_id = akamai_property.property.id
}

# data source to define the Akamai Property Rules. Akamai's delivery configurations are managed in 'Property Manager' and are currently driven of a JSON template. A main.json file contains all the rules, behaviors and criteria that make up an Akamai property / delivery configuration.
data "akamai_property_rules_template" "rules" {

  # template file is found in the fixed property-snippets folder in which rules.json is located. JSON files can also be split into smaller JSON files.
  template_file = abspath("${path.module}/property-snippets/rules.json")

  # variable origin_hostname is taken from the Terraform variables file and injected in the Origin Server Property Behavior. This defines the location of your Origin.
  variables {
    name  = "origin_hostname"
    value = var.origin_hostname
    type  = "string"
  }

  # variable cp_code is taken from the Terraform variables file and injected in the CP Code Property Behavior. This is used for billing, monitoring and reporting.
  variables {
    name  = "cp_code"
    value = parseint(replace(akamai_cp_code.cp_code.id, "cpc_", ""), 10)
    type  = "number"
  }
}

# resource that creates / manages the Akamai CP Code which is a 6 or 7 digit ID that is used for billing, monitoring and reporting. CP Codes are tied to an Akamai Contract and Akamai Group as well as an Akamai Product and have a name provided in a variable.
resource "akamai_cp_code" "cp_code" {
  product_id  = var.product_id
  contract_id = var.contract_id
  group_id    = data.akamai_group.group.id
  name        = var.cpcode_name
}

# resource that creates / manages the Akamai Edge Hostname which is used to route traffic to Akamai. Usually ends in *.akamaized.net, *.edgesuite.net or *.edgekey.net.
resource "akamai_edge_hostname" "edge_hostname" {
  product_id    = var.product_id
  contract_id   = var.contract_id
  group_id      = data.akamai_group.group.id
  ip_behavior   = var.ip_behavior
  edge_hostname = var.edge_hostname
}

# resource that creates / manages the Akamai Property / delivery configuration. Configuration is tied to a Contract and Group. Configuration has a specific Product tied to it as well.
resource "akamai_property" "property" {
  name        = var.hostname[0]
  product_id  = var.product_id
  contract_id = var.contract_id
  group_id    = data.akamai_group.group.id
  rule_format = var.rule_format

  # hostname required to add to the configuration. Also requires the Edge Hostname to add the logical mapping. Please note that a manual step is needed to update your DNS to route traffic properly to Akamai after deployment and testing.
  hostnames {
    cname_from             = var.hostname[0]
    cname_to               = var.edge_hostname
    cert_provisioning_type = var.cert_provisioning_type
  }

  # rules will load in the main.json file added earlier in a data source.
  rules = data.akamai_property_rules_template.rules.json
}

# resource to activate the Akamai Property on either Akamai STAGING or Akamai PRODUCTION. Email address is used to notify on completed deployment.
resource "akamai_property_activation" "activation" {
  property_id = akamai_property.property.id
  contact     = var.email
  version     = akamai_property.property.latest_version
  network     = upper(var.akamai_network)
}