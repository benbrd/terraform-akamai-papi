output "property_id" {
  value = akamai_property.property.id
}

output "property_hostnames" {
  value = data.akamai_property_hostnames.hostnames.hostnames
}