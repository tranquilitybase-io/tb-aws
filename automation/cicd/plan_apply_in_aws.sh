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

cd ${TERRAFORM_PATH}
echo "------------------------TERRAFORM INIT--------------------------------------------"
terraform init
ls *.tf
echo "------------------------TERRAFORM PLAN--------------------------------------------"
#terraform plan
echo "------------------------TERRAFORM APPLY--------------------------------------------"
terraform apply -refresh=true -auto-approve