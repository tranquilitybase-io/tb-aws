#!/bin/bash
# test line

# Variables
export TF_VAR_aws_default_region=${DEV_region}
export TF_VAR_aws_access_key_id=${access_key}
export TF_VAR_aws_secret_access_key=${secret_key}

# Paths
MAIN_PATH=$(pwd)
TERRAFORM_PATH="${MAIN_PATH}/terraform/scripts"

cd ${TERRAFORM_PATH}
terraform init
terraform plan
terraform apply -auto-approve