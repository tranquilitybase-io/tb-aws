import time
import boto3
import json
from datetime import datetime
from boto3.session import Session

class Account:
    def __init__(self, name, id, email, guardduty_ids = []):
        self.name = name
        self.id = id
        self.email = email
        self.guardduty_ids = guardduty_ids
    def __str__(self):
        return "\n{Name: "  + self.name + "\nId: " + self.id + "\nEmail: " + self.email + "\nDetectors: "+ str(self.guardduty_ids) +"\n}"
    def __repr__(self):
        return str(self)
        
#Get all accounts in organization
def get_accounts_data():
    account_list = []
    client = boto3.client('organizations')
    master_account_data = client.describe_organization()["Organization"]
    account_list.append(Account("Master",master_account_data["MasterAccountId"],master_account_data["MasterAccountEmail"]))
    member_accounts_data = client.list_accounts()["Accounts"]
    for member in member_accounts_data:
        if member["Id"] != master_account_data["MasterAccountId"]:
            account_list.append(Account(member["Name"],member["Id"],member["Email"],[]))   
    return account_list

#Get enabled regions
def get_regions(): 
    regions_list = {}
    enable_regions_prefix = {"us"}#,"eu","ca","sa"}
    client = boto3.client('ec2')
    regions = client.describe_regions()
    regions_list = [region for region in regions['Regions'] if region['RegionName'][:2] in enable_regions_prefix]        
    return regions_list

def create_guardduty(account, regions_list):
    #print("Creating GuardDuty on account " + account.name)
    for region in regions_list:
        session = assume_role(account.name, account.id, region["RegionName"])
        if session != None:              
            client = session.client('guardduty')
            detector_id = 0000
            try:
                #print("Checking GuardDuty on region " + region["RegionName"])
                currentDetector = client.list_detectors()["DetectorIds"]
                if currentDetector:   
                    detector_id = currentDetector[0]
                    #print("Detector found with id " + detector_id)
                else:
                    #print("Detector not found, creating")
                    newDetector = client.create_detector(Enable=True)
                    detector_id = newDetector["DetectorId"]
                    #print("Detector created with id " + detector_id)
                account.guardduty_ids.append(detector_id)
            except Exception as ex:
                template = "An exception of type {0} occurred while creating GuardDuty. Arguments:\n{1!r}"
                message = template.format(type(ex).__name__, ex.args)
                #print (message)
                return False
        else:
            print("Could't assume role for Account " + account.name + " Region: " + region["RegionName"] + ". Trying next region")
    return True

def assume_role(account_name, account_id, region):
    now = datetime.now()   
    client = boto3.client("sts")
    if(account_name == "Master"):
        session = Session(region_name = region)
        return session
    else:
        try:
            response = client.assume_role(
                RoleArn="arn:aws:iam::" + account_id + ":role/AWSLZCoreOUAdminRole", #Role Name is case sensitive!
                RoleSessionName= "Guardduty_Master_Creation_" + now.strftime("%Y%m%d_%H%M%S"),
                DurationSeconds=900
            )               
            #print("Role OrganizationAccountAccessRole assumed in account " + account_id + " in region " + region + ". Timestamp: " + now.strftime("%Y/%m/%d_%H:%M:%S"))
            session = Session(aws_access_key_id=response['Credentials']['AccessKeyId'],
                        aws_secret_access_key=response['Credentials']['SecretAccessKey'],
                        aws_session_token=response['Credentials']['SessionToken'],
                        region_name = region)
            return session
        except Exception as ex:
            template = "An exception of type {0} occurred while Assuming Role. Arguments:\n{1!r}"
            message = template.format(type(ex).__name__, ex.args)
            #print (message)
            return None

def security_account(account):
    if account.name == "security":
        return True
    else:
        return False

def logarchive_account(account):    
    if account.name == "logarchive":
        return True
    else:
        return False

def guardduty_members(account):
    if account.name != "security":
        return True
    else:
        return False

def get_findings_bucket_arn(logarchive):  
    for account in logarchive:  
        session = assume_role(account.name, account.id, 'us-west-2')
        if session != None:              
                client = session.client('s3')
                try:                   
                    result = client.list_buckets()
                    bucket_list = result['Buckets']
                    for bucket in bucket_list:
                        if 'aws-lz-s3-guardduty-findings-' in bucket['Name']:
                            return ("arn:aws:s3:::"+bucket['Name'])

                except Exception as ex:
                    template = "An exception of type {0} occurred. Arguments:\n{1!r}"
                    message = template.format(type(ex).__name__, ex.args)
                    #print (message)


def config_s3_findings(security, regions_list, bucket_arn):
    for region in regions_list:
        session = assume_role(security.name, security.id, region["RegionName"])
        if session != None:              
            client = session.client('guardduty')   
            for detector in security.guardduty_ids: 
                response = client.create_publishing_destination(
                    DetectorId = detector,
                    DestinationType='S3',
                    DestinationProperties={
                        'DestinationArn': bucket_arn,
                        'KmsKeyArn': ''
                    }
                )
                print(json.dumps(response,indent = 4, default = str))

def create_members(security, member,regions_list):
    #print("Member creation started " + member.name)
    for idx, region in enumerate(regions_list):
        session = assume_role(security.name, security.id, region["RegionName"])
        if session != None:              
            client = session.client('guardduty')
            try:                   
                result = client.create_members(
                    DetectorId = security.guardduty_ids[idx],
                    AccountDetails=[
                        {
                            'AccountId': member.id,
                            'Email': member.email
                        }
                    ]
                )
            except Exception as ex:
                template = "An exception of type {0} occurred while creating GuardDuty. Arguments:\n{1!r}"
                message = template.format(type(ex).__name__, ex.args)
                #print (message)

def invite_members(security,members,regions_list):
    #print("Member invitation started")
    account_ids = []
    for member in members:
        account_ids.append(member.id)
    for idx, region in enumerate(regions_list):
        session = assume_role(security.name, security.id, region["RegionName"])
        if session != None:              
            client = session.client('guardduty')
            try:                                   
                result = client.invite_members(
                    DetectorId=security.guardduty_ids[idx],
                    AccountIds=account_ids,
                    DisableEmailNotification=True
                )
            except Exception as ex:
                template = "An exception of type {0} occurred while creating GuardDuty. Arguments:\n{1!r}"
                message = template.format(type(ex).__name__, ex.args)
                #print (message)

def accept_invite(security,members,regions_list):
    #print("Invitation acceptance started")
    for member in members:
        for idx, region in enumerate(regions_list):
            session = assume_role(member.name, member.id, region["RegionName"])
            if session != None:              
                client = session.client('guardduty')
                try:                 
                    #print(security.guardduty_ids[idx])
                    invitations = client.list_invitations()['Invitations']
                    if invitations:
                        acceptance = client.accept_invitation(
                            DetectorId= member.guardduty_ids[idx],
                            MasterId= security.id,
                            InvitationId=invitations[0]["InvitationId"]
                        )
                    else:
                        print("No invites found for account " + member.name + " in region " + region["RegionName"])
                except Exception as ex:
                    template = "An exception of type {0} occurred while creating GuardDuty. Arguments:\n{1!r}"
                    message = template.format(type(ex).__name__, ex.args)
                    #print (message)

#This function deploys GuardDuty in all regions in all accounts in the organization
def deploy_guardduty():
    regions_list = get_regions()    
    accounts_list = get_accounts_data()
    for account in accounts_list:
        if create_guardduty(account, regions_list):
            print("GuardDuty succesfully created on account with Id: " + account.id)
        else:
            print("Couldn't create GuardDuty on account with Id: " + account.id)
    security = list(filter(security_account,accounts_list))
    members = list(filter(guardduty_members,accounts_list))
    logarchive = list(filter(logarchive_account,accounts_list))
    if security:
        if logarchive:
            bucket_arn = get_findings_bucket_arn(logarchive)
            config_s3_findings(security[0], regions_list, bucket_arn)
        else:
            print("LogArchive account not found! Can't save findings on S3")
        for member in members:
            create_members(security[0], member,regions_list)
    else:
        #print("Security account not found! Can't create master GuardDuty nor members")
        exit()
    invite_members(security[0],members,regions_list)
    accept_invite(security[0],members,regions_list)

if __name__== "__main__":
    print("***GUARDDUTY SCRIPT START***")
    start_time = time.time()
    deploy_guardduty()
    #print("--- %s seconds ---" % (time.time() - start_time))