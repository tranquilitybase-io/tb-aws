## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| all\_all\_egress\_rules | Egress rules | `list` | <pre>[<br>  "all-all"<br>]</pre> | no |
| amzn2\_ami\_version | AMI version to deploy Amazon Linux 2 | `string` | `"ami-0d6621c01e8c2de2c"` | no |
| bastion\_ami\_version | AMI version to deploy bastion | `string` | `"ami-0d6621c01e8c2de2c"` | no |
| bastion\_ingress\_rules | Bastion ingress rules | `list` | <pre>[<br>  "ssh-tcp"<br>]</pre> | no |
| bastion\_instance\_name | Bastion instance name | `string` | `"awslz_bastion-01"` | no |
| bastion\_security\_group\_description | Bastion Security group description | `string` | `"Bastion server: ssh and icmp"` | no |
| bastion\_security\_group\_name | Bastion security group name | `string` | `"awslz_bastion_access_from_internet"` | no |
| cgw\_bgn\_asn | BGN ASN number | `number` | `64600` | no |
| cgw\_ip\_address\_gcp\_int0 | Customer IP address from GCP interface 0 | `string` | `"35.242.49.95"` | no |
| cgw\_ip\_address\_gcp\_int1 | Customer IP address from GCP interface 1 | `string` | `"35.220.53.214"` | no |
| cgw\_static\_route | Static Route ? | `bool` | `false` | no |
| cgw\_type | Type of customer gateway | `string` | `"ipsec.1"` | no |
| create\_egress\_attachment | Flag to create Egress VPC Attachment | `bool` | `true` | no |
| create\_ingress\_attachment | Flag to create Ingress VPC Attachment | `bool` | `false` | no |
| create\_inline\_attachment | Flag to create In-line VPC Attachment | `bool` | `false` | no |
| create\_vpn\_gcp\_int0 | Boolean to decide if the VPN for GCP interface 0 is created or not | `bool` | `false` | no |
| create\_vpn\_gcp\_int1 | Boolean to decide if the VPN for GCP interface 1 is created or not | `bool` | `false` | no |
| deployment\_key\_name | Deployment key name | `string` | `"Deployer-key-2"` | no |
| egress\_vpc\_cidr | Egress VPC CIDR | `string` | `"10.99.0.0/22"` | no |
| egress\_vpc\_name | Egress VPC Name | `string` | `"aws_lz_egress_vpc"` | no |
| egress\_vpc\_private\_subnets | Egress VPC Private Subnets list | `list(string)` | <pre>[<br>  "10.99.2.0/24",<br>  "10.99.3.0/24"<br>]</pre> | no |
| egress\_vpc\_public\_subnets | Egress VPC Pubic Subnets list | `list(string)` | <pre>[<br>  "10.99.0.0/24",<br>  "10.99.1.0/24"<br>]</pre> | no |
| email\_netmon | Email account for networking events notification | `string` | `"cesar.sanchez@gft.com"` | no |
| env\_deployment\_key | Environment key | `string` | `""` | no |
| env\_generation\_date | Key pair generation date | `string` | `""` | no |
| ingress\_eks\_cluster\_name | Ingress VPC EKS cluster name | `string` | `"awslz_eks_ingress_cluster"` | no |
| ingress\_eks\_node\_group\_instance\_types | Instances types for the node group | `list` | <pre>[<br>  "t3.small"<br>]</pre> | no |
| ingress\_eks\_node\_group\_name | Name of the node group for the cluster | `string` | `"awslz_eks_node_group_ingress_cluster"` | no |
| ingress\_eks\_node\_group\_role\_name | Ingress Cluster node group name | `string` | `"awslz_eks_ingress_node_group"` | no |
| ingress\_eks\_role\_name | EKS role name | `string` | `"awslz_eks_ingress_cluster"` | no |
| ingress\_subnets\_list | Subnets for the EKS cluster | `string` | `""` | no |
| ingress\_vpc\_cidr | Egress VPC CIDR | `string` | `"10.99.4.0/22"` | no |
| ingress\_vpc\_name | Ingress VPC Name | `string` | `"aws_lz_ingress_vpc"` | no |
| ingress\_vpc\_private\_subnets | Ingress VPC Private Subnets list | `list(string)` | <pre>[<br>  "10.99.6.0/24",<br>  "10.99.7.0/24"<br>]</pre> | no |
| ingress\_vpc\_public\_subnets | Ingress VPC Pubic Subnets list | `list(string)` | <pre>[<br>  "10.99.4.0/24",<br>  "10.99.5.0/24"<br>]</pre> | no |
| inline\_vpc\_cidr | In-line VPC CIDR | `string` | `"10.99.12.0/22"` | no |
| inline\_vpc\_name | In-line VPC Name | `string` | `"aws_lz_inline_vpc"` | no |
| inline\_vpc\_private\_subnets | In-line VPC Private Subnets list | `list(string)` | <pre>[<br>  "10.99.12.0/24",<br>  "10.99.13.0/24"<br>]</pre> | no |
| inline\_vpc\_public\_subnets | In-line VPC Pubic Subnets list | `list(string)` | `[]` | no |
| internet\_ingress\_cidr\_blocks | Ingress cidr block | `list` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| netmon\_ingress\_rules | Ingress rules | `list(string)` | <pre>[<br>  "https-443-tcp",<br>  "http-80-tcp",<br>  "ssh-tcp"<br>]</pre> | no |
| netmon\_instance\_name | Network Monitoring instance name | `string` | `"aws_lz_nagios_netmon"` | no |
| netmon\_private\_ip | Private ip for the Sandbox web server | `string` | `"10.99.12.100"` | no |
| netmon\_security\_group\_description | Security group description | `string` | `"Internal server: http, https, ssh"` | no |
| netmon\_security\_group\_name | Security group name | `string` | `"aws_lz_netmon_sg"` | no |
| network\_account\_key\_name | Key pair name of the Network Account | `string` | `"Deployer-key-2"` | no |
| network\_bastion\_internal\_access\_ingress\_rules | Bastion ingress rules | `list` | <pre>[<br>  "ssh-tcp",<br>  "all-icmp"<br>]</pre> | no |
| network\_bastion\_internal\_access\_security\_group\_description | Bastion Security group description | `string` | `"Bastion access to internal network"` | no |
| network\_bastion\_internal\_access\_security\_group\_name | Bastion security group name to access internal network | `string` | `"awslz_bastion_access_to_internal"` | no |
| network\_reverse\_proxy\_ingress\_rules | Ingress rules | `list` | <pre>[<br>  "https-443-tcp",<br>  "http-80-tcp",<br>  "http-8080-tcp"<br>]</pre> | no |
| network\_reverse\_proxy\_instance\_name | Nginx instance name | `string` | `"awslz_reverse_proxy"` | no |
| network\_reverse\_proxy\_private\_ip | Private ip for the Sandbox web server | `string` | `"10.99.4.100"` | no |
| network\_reverse\_proxy\_security\_group\_description | Security group description | `string` | `"Reverse proxy server: http and https"` | no |
| network\_reverse\_proxy\_security\_group\_name | Security group name | `string` | `"reverse_proxy_internet"` | no |
| nginx\_user\_data | User data for the instance | `string` | `""` | no |
| t2\_micro\_instance\_type | EC2 instance type | `string` | `"t2.micro"` | no |
| tgw\_vpc\_internal\_traffic\_cidr | n/a | `string` | `"10.0.0.0/8"` | no |
| tgw\_vpc\_internet\_cidr | n/a | `string` | `"0.0.0.0/0"` | no |
| ubuntu18\_04\_ami\_version | AMI version to deploy Ubuntu 18.04 | `string` | `"ami-0d1cd67c26f5fca19"` | no |

## Outputs

No output.

