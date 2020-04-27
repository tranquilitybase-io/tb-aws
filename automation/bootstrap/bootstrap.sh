#!/usr/bin/env bash

working_path=$(pwd)
repo="${working_path}/tb-aws-master"

# Landing Zone variables
COMPANY=""
logarchive_account=""
sharedservices_account=""
security_account=""
network_account=""
AWS_ACCESS_KEY_ID=""
AWS_SECRET_ACCESS_KEY=""
AWS_DEFAULT_REGION=""

# Terraform version
readonly terraform_min_version="0.12.20"

# Format variables
HLC='\033[0;32m'
NC='\033[0m'
WHITE='\033[1;37m'
GRAY='\033[0;37m'
YELLOW='\033[1;32m'
RED='\033[0;31m'

clear
echo "Starting..."
#if [[ whoami != root ]]
#then
#    echo "This script must be run as root"
#    exit 1
#fi

# Creates a backup folder in the working directory to keep old version safe in case
# the user overwrites the current repository
function backup_folder() {
    if [[ ! -d "${working_path}/backup_old_version" ]]
    then
        mkdir ${working_path}/backup_old_version
    fi
}

function validate_emails() {
    i="test@gft.com"
    IFS="@"
    #accounts=( $logarchive_account $sharedservices_account $security_account $network_account)
    exit_answer=""
    #for acc in "${accounts[@]}"
    #do
        #echo "acc: ${acc}"
        set -- ${i}
	    if [ "${#@}" -ne 2 ]
	    then
            echo "${i} is an INVALID email"
	        #exit_answer=1
            exit 5
	    fi
        echo "${i} is a valid account"
        #domain="$2"
	    #dig $domain | grep "ANSWER: 0" 1>/dev/null && echo "domain not ok"
	    #if [[ ${exit_answer} -eq 1 ]]
        #then
        #    echo "---------------Some of the account is invalid---------------"
	    #    echo "---------------The system has to restart---------------"
	    #    exit 5
	    #fi
    #done
}


# Install the required dependencies for Red Hat like OS
function redhat_dependencies() {
    echo -e "${HLC}------------------------------------------------------------------------------------${NC}"
    echo "Installing required packages"
    echo -e "1. curl\n2. wget\n3. unzip\n4. python3\n5. pip3\n6. boto3\n7. bind-utils\n8. ca-certificates"
    yum update -y > /dev/null
    yum install -y curl wget unzip python3 python3-pip ca-certificates bind-utils > /dev/null
    echo "Packages installation is done"
    pip3 install boto3 > /dev/null
    echo "Boto3 installation is done"
}

# Download Kubectl and IAM authenticator
function install_kubectl_iam_authenticator() {
    echo -e "${HLC}------------------------------------------------------------------------------------${NC}"
    echo "Installing Kubectl"
    curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/kubectl 
    chmod +x ./kubectl
    mkdir -p $HOME/bin
    cp ./kubectl $HOME/bin/kubectl
    echo -e "${HLC}------------------------------------------------------------------------------------${NC}"
    echo "Installing AWS IAM Authenticator"
    curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator
    chmod +x ./aws-iam-authenticator
    mkdir -p $HOME/bin
    cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator
    export PATH=$PATH:/root/bin
}

# Downlaod the required version of terraform
function install_terraform() {
    echo -e "${HLC}------------------------------------------------------------------------------------${NC}"
    echo "Downloading terraform package: terraform_${terraform_min_version}_linux_amd64.zip"
    wget -q https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip
    if [[ $? -ne 0 ]]
    then
        echo "Failed downloading package: terraform_${terraform_min_version}_linux_amd64.zip"
	    exit 3
    fi
    unzip terraform_0.12.20_linux_amd64.zip > /dev/null
    mv terraform /usr/bin
    rm terraform_0.12.20_linux_amd64.zip
    echo "Terraform home is: /usr/bin/terraform"
    terraform -version
}

# This functions gets the latest version from the Github repository
function get_aws_lz() {
    echo -e "${HLC}------------------------------------------------------------------------------------${NC}"
    echo "Downloading tb-aws repository"
    wget -q https://github.com/tranquilitybase-io/tb-aws/archive/master.zip
    if [[ $? -ne 0 ]]
    then
        echo "Failed downloading package: master.zip"
	    exit 4
    fi
    if [[ -d "tb-aws-master" ]]
    then
	    echo -e "${RED}---------------------------------------WARNING--------------------------------------------"
        read -p "You have already downloaded the tb-aws-master repository, do you want to remove it? N/y: " user_input
	    echo -e "------------------------------------------------------------------------------------------${NC}"
	    if [[ ${user_input} == "y" ]]
        then
            backup_folder # creates a backup folder
            time=$(date +%d-%m-%Y_%H-%M)
	        mv tb-aws-master ${working_path}/backup_old_version/tb-aws-master_${time}
        else
	        echo "You have to manually fix this problem"
	        echo "Check folder in: $(pwd)"
	        echo "Files: $(ls)"
	        rm master.zip
	        exit 5
	    fi
    fi
    unzip master.zip > /dev/null
}


function start_lz_deployment() {
    echo -e "${HLC}------------------------------------------------------------------------------------${NC}"
    echo -e "${WHITE}"
    echo "Starting with Landing Zone deployment"
    echo "Before the deployment there are some details that you need to provide"
    echo "The system will use those entries to set configure the files and setup the Landing Zone"
    echo -e "${NC}"
    
    echo -e "${GRAY}"
    read -p "COMPANY Name (This will be used for the Organization structure): " COMPANY
    read -p "Email for LogArchive account: " logarchive_account
    read -p "Email for Shared Services account: " sharedservices_account
    read -p "Email for Security account: " security_account
    read -p "Email for Network account: " network_account
    echo -e "${NC}"
    #validate_emails
    cd tb-aws-master
    sed -i "s;company_name;${COMPANY};" config/main.config.yml
    sed -i "s;security_email;${security_account};" config/main.config.yml
    sed -i "s;logarchive_email;${logarchive_account};" config/main.config.yml
    sed -i "s;sharedservice_email;${sharedservices_account};" config/main.config.yml
    sed -i "s;network_email;${network_account};" config/main.config.yml
    sed -i "s;test-account_email;tb.test.logging.01@gmail.com;" config/main.config.yml
    sed -i "s;test-account-2_email;tb.test.logging.02@gmail.com;" config/main.config.yml
    echo "This is your current configuration: "
    cat config/main.config.yml
    echo ""
    cd terraform
    sed -i "s;tl93372@gmail.com;${sharedservices_account};" implementations/core/organization-variables.tf
    sed -i "s;tl93373@gmail.com;${logarchive_account};" implementations/core/organization-variables.tf
    sed -i "s;test.gft.aws.03@gmail.com;${security_account};" implementations/core/organization-variables.tf
    sed -i "s;test.gft.aws.04@gmail.com;${network_account};" implementations/core/organization-variables.tf
    cd ${repo}
    ls
    python3 ${repo}/automation/cicd/terraform-pre-run.py
    echo -e "${HLC}------------------------------------------------------------------------------------${NC}"
    echo -e "${WHITE}"
    echo "Now you need to enter the AWS access_key and the secret_key"
    echo "Be aware that you will enter the values but you won't see them"
    read -sp "Access_key: " access_key
    echo ""
    read -sp "Secret_key: " secret_key
    echo ""
    read -p "Default region: " DEV_region
    export AWS_ACCESS_KEY_ID=${access_key}
    export AWS_SECRET_ACCESS_KEY=${secret_key}
    export AWS_DEFAULT_REGION=${DEV_region}
    echo -e "${HLC}--------------------------TERRAFORM INIT--------------------------------------------${NC}"
    terraform init
    echo -e "${HLC}--------------------------TERRAFORM VALIDATE----------------------------------------${NC}"
    terraform validate
    echo -e "${HLC}---------------------------TERRAFORM APPLY------------------------------------------${NC}"
    terraform refresh
    #terraform apply -auto-approve
}


function detect_os() {
    echo -e "${HLC}------------------------------------------------------------------------------------${NC}"
    echo "Check OS version"
    os_version=$(cat /etc/os-release | grep ID_LIKE | cut -d "=" -f 2)
    if [[ ${os_version} =~ fedora ]]
    then
        echo "Dependencies for Red Hat like OS"
	    redhat_dependencies
    elif [[ ${os_version} =~ debian ]]
    then
        echo "Debian"
    else
        echo "OS not supported"
	    exit 2
    fi
}

function remove_downloaded_files() {
    echo -e "${HLC}------------------------------------------------------------------------------------${NC}"
    echo "Remving downloaded files"
    cd ${working_path}
    ls
    rm master.zip
}

#detect_os
#install_kubectl_iam_authenticator
#install_terraform
get_aws_lz
start_lz_deployment
remove_downloaded_files
