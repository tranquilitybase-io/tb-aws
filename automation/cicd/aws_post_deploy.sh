#!/bin/bash
# Commennt
# Commennt
echo "------------------------get-caller-identity-----TERRAFORM-------------------------"
#aws sts get-caller-identity

echo "------------------------get-caller-identity-----Network AdminOU-------------------"
##aws sts assume-role --role-arn "arn:aws:iam::615513573213:role/AWSLZCoreOUAdminRole" --role-session-name AWSCLI-Session-network
#temp_json=$(aws sts assume-role --role-arn "arn:aws:iam::615513573213:role/AWSLZCoreOUAdminRole" --role-session-name AWSCLI-Session-network)
#export AWS_ACCESS_KEY_ID=$(echo ${temp_json} | jq -r ".Credentials | .AccessKeyId")
#export AWS_SECRET_ACCESS_KEY=$(echo ${temp_json} | jq -r ".Credentials | .SecretAccessKey")
#export AWS_SESSION_TOKEN=$(echo ${temp_json} | jq -r ".Credentials | .SessionToken")
#aws sts get-caller-identity

echo "------------------------Validate kubeconfig and kubectl---------------------------"
#aws eks --region ${DEV_region} update-kubeconfig --name awslz_eks_ingress_cluster
#kubectl get svc

echo "----------------------------------------------------------------------------------"
#more ~/.kube/config
