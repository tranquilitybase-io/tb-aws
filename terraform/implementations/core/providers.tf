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

/*
provider "kubernetes" {
  alias  = "shared_services"
  load_config_file = false

  host     = "https://${module.Transform-Cluster.endpoint}"
  username = "${module.Transform-Cluster.username}"
  password = "${module.Transform-Cluster.password}"

  client_certificate     = "${base64decode(module.Transform-Cluster.client_certificate)}"
  client_key             = "${base64decode(module.Transform-Cluster.client_key)}"
  cluster_ca_certificate = "${base64decode(module.Transform-Cluster.cluster_ca_certificate)}"
}

provider "kubernetes" {
  alias  = "network"
  load_config_file = false

  host     = "https://${module.Transform-Cluster.endpoint}"
  username = "${module.Transform-Cluster.username}"
  password = "${module.Transform-Cluster.password}"

  client_certificate     = "${base64decode(module.Transform-Cluster.client_certificate)}"
  client_key             = "${base64decode(module.Transform-Cluster.client_key)}"
  cluster_ca_certificate = "${base64decode(module.Transform-Cluster.cluster_ca_certificate)}"
}*/