#!/bin/bash

# Variables
export AWS_DEFAULT_REGION=${DEV_region}
export AWS_ACCESS_KEY_ID=${CS_access_key}
export AWS_SECRET_ACCESS_KEY=${CS_secret_key}

# Paths
MAIN_PATH=$(pwd)
TERRAFORM_PATH="${MAIN_PATH}/terraform/scripts"

cd ${TERRAFORM_PATH}
terraform init
terraform plan