#!/bin/bash

# Variables
export TF_VAR_REGION=${DEV_region}
export TF_VAR_ACCESS_KEY=${CS_access_key}
export TF_VAR_SECRET_KEY=${CS_secret_key}

# Paths
MAIN_PATH=$(pwd)
TERRAFORM_PATH="${MAIN_PATH}/terraform/scripts"

cd ${TERRAFORM_PATH}
terraform init
terraform plan