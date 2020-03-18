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


echo "Before replacement---------------------"
cat implementations/core/organization-variables.tf
sed -i "s;sharedservice_email;tl93372@gmail.com;" ${TERRAFORM_PATH}/implementations/core/organization-variables.tf
sed -i "s;logarchive_email;tl93373@gmail.com;" ${TERRAFORM_PATH}/implementations/core/organization-variables.tf
sed -i "s;security_email;test.gft.aws.03@gmail.com;" ${TERRAFORM_PATH}/implementations/core/organization-variables.tf
sed -i "s;network_email;test.gft.aws.04@gmail.com;" ${TERRAFORM_PATH}/implementations/core/organization-variables.tf
sed -i "s;test-account_email;tb.test.logging.01@gmail.com;" ${TERRAFORM_PATH}/implementations/core/organization-variables.tf
sed -i "s;test-account-2_email;tb.test.logging.02@gmail.com;" ${TERRAFORM_PATH}/implementations/core/organization-variables.tf
echo "After replacement---------------------"
cat implementations/core/organization-variables.tf

# Files preparation script
python3 ${AUTOMATION_SCRIPTS}/terraform-pre-run.py

cd ${TERRAFORM_PATH}

echo "After terraform pre run---------------------"
cat implementations/core/organization-variables.tf

echo "-----------------------PRINTING MAIN.TF-------------------------------------------"
cat main.tf 
echo "------------------------TERRAFORM INIT--------------------------------------------"
terraform init
echo "------------------------TERRAFORM VALIDATE----------------------------------------"
terraform validate
