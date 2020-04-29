## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cidr\_blocks | Ingress cidr block | `list` | <pre>[<br>  "10.0.0.0/8"<br>]</pre> | no |
| cloudtrail\_name | Config Service name | `string` | `"aws_lz_cloudtrail"` | no |
| cloudtrail\_topic\_name | Name of topic for CloudTrail service | `string` | `"aws_lz_cloudtrail_alarm_sns_topic"` | no |
| config\_name | Config Service name | `string` | `"aws_lz_config"` | no |
| config\_topic\_name | Name of topic for Config service | `string` | `"aws_lz_config_sns_topic"` | no |
| create\_sandbox1\_attachment | Flag to create Sandbox1 VPC Attachment | `bool` | `false` | no |
| create\_sandbox2\_attachment | Flag to create Sandbox2 VPC Attachment | `bool` | `false` | no |
| enable\_nat\_gateway | Enable NAT gateway | `bool` | `false` | no |
| internal\_traffic\_cidr | n/a | `string` | `"10.0.0.0/8"` | no |
| internet\_cidr | n/a | `string` | `"0.0.0.0/0"` | no |
| sandbox\_2\_account\_key\_name | Key pair name of the Sandbox 2 Account | `string` | `"aws-lz"` | no |
| sandbox\_deployment\_key\_name | Deployment key name | `string` | `"Deployer-key"` | no |
| sandbox\_web\_server\_instance\_name | Instance name | `string` | `"awslz_test_web_server"` | no |
| sandbox\_web\_server\_private\_ip | Private ip for the Sandbox web server | `string` | `"10.100.1.100"` | no |
| security\_group\_description | Security group description | `string` | `"Internal server: http, ssh and icmp"` | no |
| security\_group\_name | Security group name | `string` | `"internal_webserver"` | no |
| user\_data | User data for the instance | `string` | `"apt-get update; apt-get install apache2; systemctl start apache2.service; systemctl enable apache2"` | no |
| vpc\_sandbox\_1\_cidr | Sandbox account 1 VPC CIDR range | `string` | `"10.100.0.0/22"` | no |
| vpc\_sandbox\_1\_name | Sandbox account 1 VPC name | `string` | `"AWS_LZ_VPC_Sandbox"` | no |
| vpc\_sandbox\_1\_private\_subnets\_cidr | Sandbox account 1 VPC private subnet CIDR range | `list` | <pre>[<br>  "10.100.1.0/24",<br>  "10.100.2.0/24"<br>]</pre> | no |
| vpc\_sandbox\_1\_public\_subnets\_cidr | Sandbox account 1 VPC public subnet CIDR range | `list` | `[]` | no |
| vpc\_sandbox\_2\_cidr | Sandbox account 2 VPC CIDR range | `string` | `"10.101.0.0/22"` | no |
| vpc\_sandbox\_2\_name | Sandbox account 2 VPC name | `string` | `"AWS_LZ_VPC_Sandbox_2"` | no |
| vpc\_sandbox\_2\_private\_subnets\_cidr | Sandbox account 2 VPC private subnet CIDR range | `list` | <pre>[<br>  "10.101.1.0/24",<br>  "10.101.2.0/24"<br>]</pre> | no |
| vpc\_sandbox\_2\_public\_subnets\_cidr | Sandbox account 2 VPC public subnet CIDR range | `list` | `[]` | no |
| web\_internal\_egress\_rules | Egress rules | `list` | <pre>[<br>  "all-all"<br>]</pre> | no |
| web\_internal\_ingress\_rules | Ingress rules | `list` | <pre>[<br>  "https-443-tcp",<br>  "http-80-tcp",<br>  "ssh-tcp"<br>]</pre> | no |

## Outputs

No output.

