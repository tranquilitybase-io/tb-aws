import boto3
import json
from boto3.session import Session
from datetime import date

def enable_aws_ram_organization():
    today = date.today()
    print("Date: ", today)
    client = boto3.client('ram')
    response = client.enable_sharing_with_aws_organization()
    print(response)

if __name__== "__main__":
    enable_aws_ram_organization()
