terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = ">= 3.2.0"
    }
  }
  required_version = ">= 1.0.0"
}

module "single_hostname" {
	 source  = "../../"

	 contract_id  = "<contract_id>"
	 cpcode_name  = "example-TF"
	 edge_hostname  = "www.example.com.edgesuite.net"
	 group_name  = "<group_name>"
	 hostname  = ["www.example.com"]
	 origin_hostname  = "origin.example.com"

	 # Optional variables
	 akamai_network  = "STAGING"
	 cert_provisioning_type  = "DEFAULT"
	 email  = [ "noreply@example.com"]
	 ip_behavior  = "IPV6_COMPLIANCE"
	 product_id  = "prd_Fresca"
	 rule_format  = "latest"
}