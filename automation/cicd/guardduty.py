import boto3
import json

class Account:
    def __init__(self, name, id, email):
        self.name = name
        self.id = id
        self.email = email
    def __str__(self):
        return "\n{Name: "  + self.name + " | Id: " + self.id + " | Email: " + self.email + "}"
    def __repr__(self):
        return str(self)

        
#Get accounts in organization
def get_accounts_data():
    account_list = []
    client = boto3.client('organizations')
    master_account_data = client.describe_organization()["Organization"]#list_accounts()       
    account_list.append(Account("Master",master_account_data["MasterAccountId"],master_account_data["MasterAccountEmail"]))
    member_accounts_data = client.list_accounts()["Accounts"]
    for member in member_accounts_data:
        account_list.append(Account(member["Name"],member["Id"],member["Email"]))   
    return account_list

#Get enabled regions
def get_regions():
    regions_list = {}
    enable_regions_prefix = {"us","eu","ca","sa"}
    client = boto3.client('ec2')
    regions = client.describe_regions()
    regions_list = [region for region in regions['Regions'] if region['RegionName'][:2] in enable_regions_prefix]    
    return regions_list

def create_master_guardduty(account, regions_list):

    return "a"

def get_roles():
    client = boto3.client("iam")
    roles = client.list_roles()
    print(json.dumps(roles,indent = 4, default = str))
    return roles

#This function deploys GuardDuty in all regions in all accounts in the organization
def deploy_guardduty():
    regions_list = get_regions()    
    accounts_list = get_accounts_data()
    roles_list = get_roles()
   # guardduty_members = {}
  #  for account in accounts_list:
   #     if account.name == "security":
    #        create_master_guardduty(account, regions_list)
    #    else:
      #      guardduty_members.append(account)
    #create members and invites
    #Create detector on members and accept invite

if __name__== "__main__":
    deploy_guardduty()