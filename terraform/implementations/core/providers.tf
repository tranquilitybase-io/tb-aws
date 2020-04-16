provider "aws" {
  version = "~> 2.48"
}

provider "aws" {
  version = "~> 2.48"
  alias = "sandbox-account-2"
  assume_role {
    role_arn = "arn:aws:iam::${module.aws_lz_account_sandbox_prod.account_id}:role/${var.org_admin_role}"
  }
}

provider "aws" {
  version = "~> 2.48"
  alias = "sandbox-account"
  assume_role {
    role_arn = "arn:aws:iam::${module.aws_lz_account_sandbox.account_id}:role/${var.org_admin_role}"
  }
}

provider "aws" {
  version = "~> 2.48"
  alias = "security-account"
  assume_role {
    role_arn = "arn:aws:iam::${module.aws_lz_account_security.account_id}:role/${var.org_admin_role}"
  }
}

provider "aws" {
  version = "~> 2.48"
  alias = "logarchive-account"
  assume_role {
    role_arn = "arn:aws:iam::${module.aws_lz_account_logarchive.account_id}:role/${var.org_admin_role}"
  }
}

provider "aws" {
  version = "~> 2.48"
  alias = "sharedservices-account"
  assume_role {
    role_arn = "arn:aws:iam::${module.aws_lz_account_sharedservices.account_id}:role/${var.org_admin_role}"
  }
}

provider "aws" {
  version = "~> 2.48"
  alias = "network-account"
  assume_role {
    role_arn = "arn:aws:iam::${module.aws_lz_account_network.account_id}:role/${var.org_admin_role}"
  }
}

provider "local" {
  version = "~> 1.4"
}

provider "null" {
  version = "~> 2.1"
}


provider "kubernetes" {
  alias  = "shared_services"

  load_config_file        = false
  host                    = module.aws_lz_eks_eagleconsole_cluster.cluster_endpoint
  cluster_ca_certificate  = base64decode(module.aws_lz_eks_eagleconsole_cluster.cluster_ca)
  token                   = data.external.heptio_authenticator_aws_sharedservices.result.token
}

provider "kubernetes" {
  alias  = "network"

  load_config_file        = false
  host                    = module.ingress_eks_cluster.cluster_endpoint
  cluster_ca_certificate  = base64decode(module.ingress_eks_cluster.cluster_ca)
  token                   = data.external.heptio_authenticator_aws_network.result.token
}