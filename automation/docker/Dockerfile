# Docker image with Python3 and Terraform 0.12.20
# Project: AWS-LZ
# Company: GFT
# Use this docker file to run docker scripts. Python is required to run the pre-run step
# Usage:
# docker build -t deiverk/ubuntu_terraform_python3:latest .
# docker push deiverk/ubuntu_terraform_python3:latest

FROM ubuntu:18.04
LABEL maintainer Deiver Kiel "deikiel@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends curl wget unzip python3 ca-certificates && rm -rf /var/lib/apt/lists/*
RUN wget --no-check-certificate https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip && \
        unzip terraform_0.12.20_linux_amd64.zip && mv terraform /usr/bin && rm terraform_0.12.20_linux_amd64.zip
RUN cd /usr/local/bin && ln -s /usr/bin/python3 python