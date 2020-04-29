# GFT AWS LZ EKS Terraform module

Usage: Terraform module which creates EKS cluster and node groups with the required configuration.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| eks\_cluster\_name | EKS name | `string` | n/a | yes |
| eks\_iam\_role\_name | Role name for cluster administration | `string` | n/a | yes |
| eks\_user\_policy | Defaul policy applied to EKS user | `string` | `"{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Principal\": {\n        \"Service\": \"eks.amazonaws.com\"\n      },\n      \"Action\": \"sts:AssumeRole\"\n    }\n  ]\n}\n"` | no |
| node\_group\_instance\_types | List of instance types | `list(string)` | n/a | yes |
| node\_group\_name | Node group name | `string` | n/a | yes |
| node\_group\_role\_name | Node group role name | `string` | n/a | yes |
| node\_group\_role\_policy | Default policy applied to the node group role | `string` | `"{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Action\": \"sts:AssumeRole\"\n    }\n  ]\n}\n"` | no |
| node\_group\_subnets | List subnets for node group | `list(string)` | n/a | yes |
| subnets | List of subnets | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_ca | Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster. |
| cluster\_endpoint | The endpoint for your EKS Kubernetes. |
| cluster\_id | ID for your EKS Kubernetes. |
| role\_arn | Role ARN |

