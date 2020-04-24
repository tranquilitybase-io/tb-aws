#!/bin/bash
# Commennt
# Commennt
echo "------------------------AWS Environment VAriables -----------------------------------------------"
export AWS_ACCESS_KEY_ID=${access_key}
export AWS_SECRET_ACCESS_KEY=${secret_key}
export AWS_DEFAULT_REGION=${DEV_region}

# Paths
MAIN_PATH=$(pwd)
AUTOMATION_SCRIPTS="${MAIN_PATH}/automation/cicd"
TERRAFORM_PATH="${MAIN_PATH}/terraform"
K8S_PATH="${MAIN_PATH}/automation/k8s"

echo "------------------------AWS CLI-----------------------------------------------"
aws --version
aws configure set aws_access_key_id ${access_key}
aws configure set aws_secret_access_key ${secret_key}
aws configure set default.region ${DEV_region}
echo "------------------------get-caller-identity-----TERRAFORM-------------------------"
aws sts get-caller-identity

echo "------------------------get-caller-identity-----Shared Services AdminOU-------------------"
temp_json=$(aws sts assume-role --role-arn "arn:aws:iam::000516684594:role/AWSLZCoreOUAdminRole" --role-session-name AWSCLI-Session-sharedservices)
export AWS_ACCESS_KEY_ID=$(echo ${temp_json} | jq -r ".Credentials | .AccessKeyId")
export AWS_SECRET_ACCESS_KEY=$(echo ${temp_json} | jq -r ".Credentials | .SecretAccessKey")
export AWS_SESSION_TOKEN=$(echo ${temp_json} | jq -r ".Credentials | .SessionToken")
aws sts get-caller-identity

echo "------------------------Validate kubeconfig and kubectl---------------------------"
aws eks --region ${DEV_region} update-kubeconfig --name awslz_eks_eagleconsole
kubectl get svc
kubectl apply -f ${K8S_PATH}/eagle-console/eagle-console-deployment.yaml
kubectl apply -f ${K8S_PATH}/eagle-console/houston-deployment.yaml
kubectl apply -f ${K8S_PATH}/eagle-console/mysql-deployment.yaml
sleep 1m
kubectl get pods
echo "------------------------Services deployments--------------------------------------"
kubectl get svc
kubectl apply -f ${K8S_PATH}/eagle-console/eagle-console-service.yaml
sleep 1m
kubectl get svc