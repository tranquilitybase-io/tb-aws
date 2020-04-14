#!/bin/bash -e

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
bucket=$(aws s3 ls | awk '{print $3}')

echo "------------------------CONNECTION--------------------------------------------"
ssh-keygen -t rsa -b 2048 -N "" -f temp.key > /dev/null 2>&1
export TF_VAR_env_deployment_key=$(cat temp.key.pub) #| awk '{print $1 $2}'
aws s3 cp temp.key s3://${bucket}/ > /dev/null 2>&1 && echo "Check your S3 bucket to download files"

cd ${TERRAFORM_PATH}
echo "------------------------TERRAFORM INIT--------------------------------------------"
terraform init
echo "------------------------TERRAFORM APPLY-------------------------------------------"
#TF_LOG=DEBUG terraform apply -refresh=true -auto-approve
#python3 ${TERRAFORM_PATH}/modules/extensions/ram/aws_ram.py
#terraform apply -auto-approve


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

