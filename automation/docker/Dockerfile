# Docker image with Python3 and Terraform 0.12.20
# Project: AWS-LZ
# Company: GFT
# Use this docker file to run docker scripts. Python is required to run the pre-run step

FROM ubuntu:18.04
Label MAINTAINER Deiver Kiel "deikiel@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends python3-setuptools graphviz curl wget unzip python3 python3-pip ca-certificates openssh-client jq && pip3 install boto3 awscli && rm -rf /var/lib/apt/lists/* && curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/kubectl && chmod +x ./kubectl && mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator && chmod +x ./aws-iam-authenticator && mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator
ENV PATH "export PATH=$PATH:/root/bin"
RUN wget --no-check-certificate https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip && \
        unzip terraform_0.12.20_linux_amd64.zip && mv terraform /usr/bin && rm terraform_0.12.20_linux_amd64.zip
#RUN cd /usr/local/bin && ln -s /usr/bin/python3 python