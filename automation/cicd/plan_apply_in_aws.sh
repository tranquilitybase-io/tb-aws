#!/bin/bash 
# Variables
export AWS_ACCESS_KEY_ID=${access_key}
export AWS_SECRET_ACCESS_KEY=${secret_key}
export AWS_DEFAULT_REGION=${DEV_region}
 
# Paths 
MAIN_PATH=$(pwd)
TERRAFORM_PATH="${MAIN_PATH}/terraform"

cd ${TERRAFORM_PATH}
echo "-----------------------PRINTING MAIN.TF-------------------------------------------"
cat main.tf
echo "------------------------TERRAFORM INIT--------------------------------------------"
terraform init
echo "------------------------TERRAFORM APPLY-------------------------------------------"
terraform apply -refresh=true -auto-approve