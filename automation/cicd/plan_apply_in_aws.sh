#!/bin/bash 
# Variables

export AWS_ACCESS_KEY_ID=${access_key}
export AWS_SECRET_ACCESS_KEY=${secret_key}
export AWS_DEFAULT_REGION=${DEV_region}
 
# Paths 
MAIN_PATH=$(pwd)
TERRAFORM_PATH="${MAIN_PATH}/terraform"

cd ${TERRAFORM_PATH}
echo "------------------------TERRAFORM INIT--------------------------------------------"
terraform init
#terraform import module.aws_lz_account_logarchive.aws_organizations_account.aws_lz_account 543433398002
#terraform refresh
echo "------------------------TERRAFORM REMOVE ACCOUNTS FROM STATE--------------------------------------------"
#terraform state rm module.aws_lz_account_security.aws_organizations_account.aws_lz_account
#terraform state rm module.aws_lz_account_sharedservices.aws_organizations_account.aws_lz_account
#terraform state rm module.aws_lz_account_logarchive.aws_organizations_account.aws_lz_account
#terraform state rm module.aws_lz_account_network.aws_organizations_account.aws_lz_account
echo "------------------------TERRAFORM REMOVE ACCOUNTS FROM STATE END--------------------------------------------"
#terraform import module.aws_lz_account_security.aws_organizations_account.aws_lz_account 971696596064
#terraform import module.aws_lz_account_sharedservices.aws_organizations_account.aws_lz_account 000516684594
#terraform import module.aws_lz_account_logarchive.aws_organizations_account.aws_lz_account 705215869482
#terraform import module.aws_lz_account_network.aws_organizations_account.aws_lz_account 615513573213 
#terraform import module.aws_lz_account_security.aws_organizations_account.aws_lz_account 971696596064
#terraform import module.aws_lz_account_sharedservices.aws_organizations_account.aws_lz_account 000516684594
#terraform import module.aws_lz_account_logarchive.aws_organizations_account.aws_lz_account 543433398002
echo "------------------------TERRAFORM APPLY-------------------------------------------"
#TF_LOG=DEBUG terraform apply -refresh=true -auto-approve
terraform apply -auto-approve