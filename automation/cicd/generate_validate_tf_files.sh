#!/bin/bash
# test line  

# Variables
export AWS_ACCESS_KEY_ID=${access_key}
export AWS_SECRET_ACCESS_KEY=${secret_key}
export AWS_DEFAULT_REGION=${DEV_region}

# Paths
MAIN_PATH=$(pwd)
AUTOMATION_SCRIPTS="${MAIN_PATH}/automation/cicd"
TERRAFORM_PATH="${MAIN_PATH}/terraform"

# Files preparation script
python3 ${AUTOMATION_SCRIPTS}/terraform-pre-run.py

cd ${TERRAFORM_PATH}
ls
echo "------------------------TERRAFORM INIT--------------------------------------------"
terraform init
echo "------------------------TERRAFORM VALIDATE----------------------------------------"
terraform validate