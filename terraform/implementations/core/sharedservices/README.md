## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| ec\_eks\_cluster\_name | n/a | `string` | `"aws_lz_eks_eagleconsole"` | no |
| ec\_eks\_node\_group\_instance\_types | Instances types for the node group | `list` | <pre>[<br>  "t2.micro"<br>]</pre> | no |
| ec\_eks\_node\_group\_name | Cluster node group name | `string` | `"awslz_eks_eagleconsole_node_group"` | no |
| ec\_eks\_node\_group\_role\_name | Cluster node group name role\_role | `string` | `"awslz_eks_eagleconsole_node_group"` | no |
| ec\_eks\_role\_name | EKS role name | `string` | `"awslz_eks_cluster_role"` | no |
| enable\_nat\_gateway\_sharedservices | Enable NAT gateway | `bool` | `false` | no |
| enable\_vpn\_gateway\_sharedservices | Enable VPN gateway | `bool` | `false` | no |
| internal\_ingress\_cidr\_blocks | Internal ingress cidr block | `list` | <pre>[<br>  "10.0.0.0/8"<br>]</pre> | no |
| internal\_traffic\_cidr\_sharedservices | n/a | `string` | `"10.0.0.0/8"` | no |
| internet\_cidr\_sharedservices | n/a | `string` | `"0.0.0.0/0"` | no |
| kubectl\_ingress\_rules | Linux kubectl ingress rules | `list` | <pre>[<br>  "ssh-tcp"<br>]</pre> | no |
| kubectl\_instance\_name | Linux kubectl instance name | `string` | `"awslz_kubectl_server-1"` | no |
| kubectl\_security\_group\_description | Linux kubectl security group description | `string` | `"Internal server: kubectl controller"` | no |
| kubectl\_security\_group\_name | Linux kubectl security group name | `string` | `"kubectl_server"` | no |
| shared\_services\_deployment\_key\_name | Shared Services deployment key name | `string` | `"Deployer-key"` | no |
| vpc\_sharedservices\_cidr | Shared Services VPC CIDR range | `string` | `"10.99.8.0/22"` | no |
| vpc\_sharedservices\_name | Shared Services VPC name | `string` | `"AWS_LZ_VPC_SharedServices"` | no |
| vpc\_sharedservices\_private\_subnets\_cidr | Shared Services VPC private subnet CIDR range | `list` | <pre>[<br>  "10.99.8.0/24",<br>  "10.99.9.0/24"<br>]</pre> | no |
| vpc\_sharedservices\_public\_subnets\_cidr | Shared services VPC public subnet CIDR range | `list` | `[]` | no |

## Outputs

No output.

