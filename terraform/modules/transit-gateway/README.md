# AWS Transit Gateway Terraform module

Terraform module which creates Transit Gateway resources in Network Account.

This type of resources are supported:

* [Transit Gateway](https://www.terraform.io/docs/providers/aws/r/ec2_transit_gateway.html)

## Terraform versions

Only Terraform 0.12 is supported.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| amazon\_side\_asn | The Autonomous System Number \(ASN\) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN. | string | `"64512"` | no |
| create\_tgw | Controls if TGW should be created \(it affects almost all resources\) | bool | `"true"` | no |
| description | Description of the EC2 Transit Gateway | string | `"null"` | no |
| enable\_auto\_accept\_shared\_attachments | Whether resource attachment requests are automatically accepted | bool | `"false"` | no |
| name | Name to be used on all the resources as identifier | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_ec2\_transit\_gateway\_arn | EC2 Transit Gateway Amazon Resource Name \(ARN\) |
| this\_ec2\_transit\_gateway\_association\_default\_route\_table\_id | Identifier of the default association route table |
| this\_ec2\_transit\_gateway\_id | EC2 Transit Gateway identifier |
| this\_ec2\_transit\_gateway\_owner\_id | Identifier of the AWS account that owns the EC2 Transit Gateway |
