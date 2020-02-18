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

# Files preparation
python3 automation/cicd/terraform-pre-run.py

cd ${TERRAFORM_PATH}
echo "location: $(pwd)"
echo "Files to use: "
ls
cat main.tf 
cat variables.tf 
cat outputs.tf 
echo "--------------------------------------------------------------------"
terraform init
ls
echo "--------------------------------------------------------------------"
terraform validate
ls
echo "--------------------------------------------------------------------"
terraform refresh
echo "--------------------------------------------------------------------"
#terraform import
echo "--------------------------------------------------------------------"
terraform plan
ls
echo "--------------------------------------------------------------------"
terraform apply -auto-approve
ls
