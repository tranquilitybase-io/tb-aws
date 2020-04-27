#!/bin/bash

# Variables
export AWS_ACCESS_KEY_ID=${access_key}
export AWS_SECRET_ACCESS_KEY=${secret_key}
export AWS_DEFAULT_REGION=${DEV_region}

# Paths 
MAIN_PATH=$(pwd)
AUTOMATION_SCRIPTS="${MAIN_PATH}/automation/cicd"
TERRAFORM_PATH="${MAIN_PATH}/terraform"

echo "------------------------AWS CLI-----------------------------------------------"
aws --version
aws configure set aws_access_key_id ${access_key}
aws configure set aws_secret_access_key ${secret_key}
aws configure set default.region ${DEV_region}

echo "------------------------Create Profiles for AWS CLI ---------------------------------------"
ACCOUNT_LIST=$(aws organizations list-accounts)
for row in $(echo "${ACCOUNT_LIST}" | jq -r '.Accounts[] | @base64'); do
    ACCOUNT_ID=$(echo ${row} | base64 --decode | jq -r '.Id')
    ACCOUNT_NAME=$(echo ${row} | base64 --decode | jq -r '.Name')
    if [ $ACCOUNT_NAME != 'aws-lz' ] && [ $ACCOUNT_NAME != 'test-account' ] ; then
      echo "[profile ${ACCOUNT_NAME}]" >> ~/.aws/config
      echo "    role_arn = arn:aws:iam::${ACCOUNT_ID}:role/AWSLZCoreOUAdminRole" >> ~/.aws/config
      echo "    source_profile = default" >> ~/.aws/config
    fi
done
more ~/.aws/config
echo "------------------------END Create Profiles for AWS CLI -----------------------------------"

export bucket=$(aws s3 ls | awk '{print $3}')
export TF_VAR_env_generation_date=$(date +%d-%m-%Y_%H-%M)
ssh-keygen -t rsa -b 2048 -N "" -f temp--${TF_VAR_env_generation_date}.key > /dev/null 2>&1
export TF_VAR_env_deployment_key=$(cat temp--${TF_VAR_env_generation_date}.key.pub)



echo "------------------------TERRAFORM INIT--------------------------------------------"
cd ${TERRAFORM_PATH}
#export AWS_ACCESS_KEY_ID=${access_key}
#export AWS_SECRET_ACCESS_KEY=${secret_key}
#export AWS_DEFAULT_REGION=${DEV_region}
terraform init
echo "------------------------TERRAFORM APPLY-------------------------------------------"
#TF_LOG=DEBUG terraform apply -refresh=true -auto-approve
#python3 ${TERRAFORM_PATH}/modules/extensions/ram/aws_ram.py

#terraform state list

terraform apply -auto-approve


#terraform state rm module.eks.kubernetes_config_map.aws_auth[0]

#This scripts generates the Guardduty instances in all accounts and all regions
#python3 ${AUTOMATION_SCRIPTS}/guardduty.py

#terraform state rm module.aws_lz_aws_ram_share_tg

#terraform state rm module.vpc-network-account
#terraform state rm module.aws_lz_config_service-2
#terraform state rm module.aws_lz_cloudtrail-2

#terraform state rm module.aws_lz_config_bucket.aws_s3_bucket.s3_main
#terraform state rm module.aws_lz_config_bucket.aws_s3_bucket.s3_log

#terraform state rm module.aws_lz_guardduty_bucket.aws_s3_bucket.s3_findings
#terraform state rm module.aws_s3_bucket_policy_logarchive.aws_s3_bucket.s3_findings

#terraform state rm module.aws_lz_config_service.aws_config_configuration_recorder_status.main
#terraform state rm module.aws_lz_config_service.aws_config_configuration_recorder.main

#terraform state rm module.aws_lz_config_service_2.aws_iam_role
#terraform state rm module.aws_lz_config_service.aws_iam_role

#terraform state rm module.aws_lz_inline_vpc.aws_vpc.this[0]
