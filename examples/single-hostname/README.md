# Akamai Single Hostname Property provisioning example

This example illustrates how to provision a single hostname using `terraform-akamai-papi` module into property manager and activate it to Akamai STAGING network.


# main.tf
```hcl
module "example" {
	 source  = "<module-path>"

	 contract_id  = "<contract_id>"
	 cpcode_name  = "example-TF"
	 edge_hostname  = "www.example.com.edgesuite.net"
	 group_name  = "<group_name>"
	 hostname  = ["www.example.com"]
	 origin_hostname  = "origin.example.com"

	 akamai_network  = "STAGING"
	 email  = [ "noreply@example.com"]
}
```
# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```
Run `terraform destroy` when you don't need these resources.

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_akamai"></a> [akamai](#requirement\_akamai) | >= 3.2.0 |

## Providers

No providers.

## Resources

No resources.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_single_hostname"></a> [single\_hostname](#module\_single\_hostname) | ../../ | n/a |

## Inputs

No inputs.

## Outputs

No outputs.

# Contributing

We're happy to accept help from fellow code-monkeys.
Report issues/questions/feature requests on in the [issues](https://github.com/brrbrr/terraform-akamai-core-new-security-configuration/issues) section.
Refer to the [contribution guidelines](./contributing.md) for information on contributing to this module.

# Authors

- [@Benjamin Brouard](https://www.github.com/brrbrr), Security Professional Services @Akamai.

# License

[Apache License 2](https://choosealicense.com/licenses/apache-2.0/). See [LICENSE](./LICENSE.md) for full details.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
