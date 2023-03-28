# Akamai Terraform PAPI module

Like Property Manager in Akamai Control Center, this Akamai Terraform Property Manager API (PAPI) module lets you create, deploy, activate and manage your property configuration via Terraform.

> Property Manager is a configuration tool that you use with other ​Akamai Technologies, Inc.​ products to start serving the traffic to your site or application through the ​Akamai​ edge network. In Property Manager, you determine:
>- An edge hostname. This is the ​Akamai​-generated hostname that you assign to your domain so that the users' requests are resolved to the ​Akamai​ edge network. See Key concepts and terms for a detailed explanation of how edge hostnames work.
>- Traffic and security options. To help direct and protect your content.
>- Business rules. These rules tell the edge network servers how to handle and distribute the content retrieved from your origin server.

A property contains the delivery configuration, or rule tree, that determines how Akamai handles requests. This rule tree is usually represented using JSON, and is often referred to as rules.json. This module is using a default rules.json file located in ./property-snippets directory.

# Usage

## Run it as a standalone project

1. Clone the repository, using following command:

    ```bash
    > git clone https://github.com/brrbrr/terraform-akamai-papi.git
    > cd terraform-akamai-papi
    ```

2. Copy sample `terraform.tfvars.sample` into `terraform.tfvars` and provide values for all input variables defined in variables.tf file.

3. Run `terraform init` to download required providers and modules.
4. Run `terraform plan` to see the infrastructure plan
5. Run `terraform apply` to apply the Terraform configuration and create required infrastructure.

_**Note:** Run `terraform destroy` when you don't need these resources._
## Run it as a Terraform module

This way allows integration with your existing Terraform configurations.
Basic usage of this module is as follows:

```hcl
module "example" {
	 source  = "<module-path>"

	 # Required variables
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
```

## Example

- [single_hostname](./examples/single_hostname) - This example illustrates how to provision a single hostname on property manager using this module and activate it on Akamai Staging network.

## Prerequisite
Authentication is handled through Akamai EdgeGrid in the _provider.tf_ file.
Ensure you have your _.edgerc_ file available and that it contains your Akamai EdgeGrid tokens separated in sections.

```bash
[default]
client_secret = xxxx
host = xxxx # unique string followed by `luna.akamaiapis.net`
access_token = xxxx
client_token = xxxx
max-body = xxxx
#account_key = xxxxx # specify the Account Switch Key to handle another another account with your Akamai Internal Credentials
```

For more information on Akamai EdgeGrid, _.edgerc_ file and creating Akamai EdgeGrid tokens, see ['Get started with APIs'](https://techdocs.akamai.com/developer/docs/set-up-authentication-credentials).


<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_akamai"></a> [akamai](#requirement\_akamai) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_akamai"></a> [akamai](#provider\_akamai) | >= 2.0.0 |

## Resources

| Name | Type |
|------|------|
| [akamai_cp_code.cp_code](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/cp_code) | resource |
| [akamai_edge_hostname.edge_hostname](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/edge_hostname) | resource |
| [akamai_property.property](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property) | resource |
| [akamai_property_activation.activation](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property_activation) | resource |
| [akamai_contract.contract](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/contract) | data source |
| [akamai_group.group](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/group) | data source |
| [akamai_property_hostnames.hostnames](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_hostnames) | data source |
| [akamai_property_rules_template.rules](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_template) | data source |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contract_id"></a> [contract\_id](#input\_contract\_id) | Akamai contract ID associated with the new configuration. | `string` | n/a | yes |
| <a name="input_cpcode_name"></a> [cpcode\_name](#input\_cpcode\_name) | Name you want to give to your Akamai CP Code (Content Provider Code) used for billing, monitoring and reporting. | `string` | n/a | yes |
| <a name="input_edge_hostname"></a> [edge\_hostname](#input\_edge\_hostname) | Akamai Edge Hostname you want to use, ending in *.akamaized.net, *.edgesuite.net or *.edgekey.net. | `string` | n/a | yes |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | Akamai group ID associated with the new configuration. Groups are part of an Akamai contract. | `string` | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname you want to Akamaize. | `list(string)` | n/a | yes |
| <a name="input_origin_hostname"></a> [origin\_hostname](#input\_origin\_hostname) | Hostname where your Origin is located. You can specify an IP address as well | `string` | n/a | yes |
| <a name="input_akamai_network"></a> [akamai\_network](#input\_akamai\_network) | Name of the network the configuration is being activated for. Allowed values are: STAGING or PRODUCTION | `string` | `"STAGING"` | no |
| <a name="input_cert_provisioning_type"></a> [cert\_provisioning\_type](#input\_cert\_provisioning\_type) | Type of HTTPS SSL/TLS Certificate method you use with Akamai. This can be CPS\_MANAGED for certificates managed in Certificate Provisioning System or DEFAULT for Secure By Default feature. | `string` | `"DEFAULT"` | no |
| <a name="input_email"></a> [email](#input\_email) | JSON array of email addresses of people to be notified when activation is complete. To send notification emails to multiple people, separate the individual email addresses by using commas: ["user1@mail.com", "user2@mail.com"] | `list(string)` | <pre>[<br>  "noreply@example.com"<br>]</pre> | no |
| <a name="input_ip_behavior"></a> [ip\_behavior](#input\_ip\_behavior) | If your hostname supports IPv4 only or IPv4 + IPv6. | `string` | `"IPV6_COMPLIANCE"` | no |
| <a name="input_product_id"></a> [product\_id](#input\_product\_id) | ID of the Akamai Product that you want to use for Content Delivery. | `string` | `"prd_Fresca"` | no |
| <a name="input_rule_format"></a> [rule\_format](#input\_rule\_format) | Akamai Property Manager rule format which includes updated behaviors for newer versions. 'latest' is accepted. | `string` | `"latest"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_property_hostnames"></a> [property\_hostnames](#output\_property\_hostnames) | n/a |
| <a name="output_property_id"></a> [property\_id](#output\_property\_id) | n/a |

# Contributing
  
We're happy to accept help from fellow code-monkeys.
Use issues section to track ideas, feedback, tasks, or bugs.
Refer to the [contribution guidelines](./contributing.md) for information on contributing to this project.
# Authors

![@Benjamin Brouard](https://img.shields.io/badge/Benjamin%20Brouard-Security%20Professional%20Services%20%40%20Akamai-blue?logo=akamai&link=https://git.source.akamai.com/users/bbrouard/)
  
# License

[Apache License 2](https://choosealicense.com/licenses/apache-2.0/). See [LICENSE](./LICENSE.md) for full details.

-----------------

![Made with love](https://img.shields.io/badge/Made%20with%20%E2%9D%A4%EF%B8%8F-in%20France-EF4135?labelColor=0055A4)
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
