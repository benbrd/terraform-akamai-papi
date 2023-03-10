variable "contract_id" {
  description = "Akamai contract ID associated with the new configuration."
  type = string
}

variable "group_name" {
  description = "Akamai group ID associated with the new configuration. Groups are part of an Akamai contract."
  type = string
}

variable "product_id" {
  description = "ID of the Akamai Product that you want to use for Content Delivery."
  type        = string
  default     = "prd_Fresca"
}

# variable hostname reflects the hostname you want to Akamaize.
variable "hostname" {
  description = "Hostname you want to Akamaize."
  type        = list(string)
}
 
variable "cpcode_name" {
  description = "Name you want to give to your Akamai CP Code (Content Provider Code) used for billing, monitoring and reporting."
  type        = string
}

variable "edge_hostname" {
  description = "Akamai Edge Hostname you want to use, ending in *.akamaized.net, *.edgesuite.net or *.edgekey.net."
  type        = string
}

variable "origin_hostname" {
  description = "Hostname where your Origin is located. You can specify an IP address as well"
  type        = string
}

variable "ip_behavior" {
  description = "If your hostname supports IPv4 only or IPv4 + IPv6."
  type        = string
  default     = "IPV6_COMPLIANCE"
}

variable "rule_format" {
  description = "Akamai Property Manager rule format which includes updated behaviors for newer versions. 'latest' is accepted."
  type        = string
  default     = "latest"
}

variable "cert_provisioning_type" {
  description = "Type of HTTPS SSL/TLS Certificate method you use with Akamai. This can be CPS_MANAGED for certificates managed in Certificate Provisioning System or DEFAULT for Secure By Default feature."
  type        = string
  default     = "DEFAULT"
}

variable "akamai_network" {
  description = "Name of the network the configuration is being activated for. Allowed values are: STAGING or PRODUCTION"
  type        = string
  default     = "STAGING"
}

variable "email" {
  description = "JSON array of email addresses of people to be notified when activation is complete. To send notification emails to multiple people, separate the individual email addresses by using commas: [\"user1@mail.com\", \"user2@mail.com\"]"
  type        = list(string)
  default     = ["noreply@example.com"]
}