import boto3
import json
from boto3.session import Session

def enable_aws_ram_organization():
    client = boto3.client('ram')
    response = client.enable_sharing_with_aws_organization()
    print(response)

if __name__== "__main__":
    enable_aws_ram_organization()
