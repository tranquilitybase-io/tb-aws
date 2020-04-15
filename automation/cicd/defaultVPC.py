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
def get_accounts():
    account_list = []
    client = boto3.client('organizations')
    master_account_data = client.describe_organization()["Organization"]
    account_list.append(Account("Master",master_account_data["MasterAccountId"],master_account_data["MasterAccountEmail"]))
    member_accounts_data = client.list_accounts()["Accounts"]
    for member in member_accounts_data:
        if member["Id"] != master_account_data["MasterAccountId"]:
            account_list.append(Account(member["Name"],member["Id"],member["Email"],[]))   
    return account_list

def get_regions(client):
  """ Build a region list """

  reg_list = []
  regions = client.describe_regions()
  data_str = json.dumps(regions)
  resp = json.loads(data_str)
  region_str = json.dumps(resp['Regions'])
  region = json.loads(region_str)
  for reg in region:
    reg_list.append(reg['RegionName'])
  return reg_list

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
            print("Role AWSLZCoreOUAdminRole assumed in account " + account_id + " in region " + region + ". Timestamp: " + now.strftime("%Y/%m/%d_%H:%M:%S"))
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
          
def get_default_vpcs(session):
  vpc_list = []
  client = session.client('ec2')
  vpcs = client.describe_vpcs(
    Filters=[
      {
          'Name' : 'isDefault',
          'Values' : ['true',],
      },
    ]
  )
  vpcs = vpcs['Vpcs']
  for vpc in vpcs:
    vpc_list.append(vpc['VpcId'])
  
  return vpc_list

def delete_igw(ec2,vpc):
  vpc_resource = ec2.Vpc(vpc)
  igws = vpc_resource.internet_gateways.all()
  if igws:
    for igw in igws:
      try:
        print("Dettaching and deleting IGW for VPC " + vpc)
        igw.detach_from_vpc(VpcId=vpc)
        igw.delete()
      except Exception as e:
        print('Cannot delete IGW since it has some dependencies')

def delete_sub(ec2, vpcid):
  vpc_resource = ec2.Vpc(vpcid)
  subnets = vpc_resource.subnets.all()  
  if (subnets):
    for subnet in subnets:
      print("Deleting subnet " + subnet.id)
      try:
        subnet.delete()
      except Exception as e:
        print('Cannot delete Subnet since it has some dependencies')
        
def delete_rtb(ec2, vpcid):  
  vpc_resource = ec2.Vpc(vpcid)
  rtbs = vpc_resource.route_tables.all() 
  if rtbs:
    for rtb in rtbs:
      assoc_attr = [rtb.associations_attribute for rtb in rtbs]
      #Main route tables can't be deleted, so is necessary to check if it is the main RT before trying to delete
      if [rtb_ass[0]['RouteTableId'] for rtb_ass in assoc_attr if rtb_ass[0]['Main'] == True]:
        print(rtb.id + " is the main route table, continue...")
        continue
      table = ec2.RouteTable(rtb.id)
      print ("Deleting Route table " + rtb.id)
      try:
        table.delete()
      except Exception as e:
        print('Cannot delete Route table since it has some dependencies')

def delete_acl(ec2, vpcid):   
  vpc_resource = ec2.Vpc(vpcid)      
  acls = vpc_resource.network_acls.all()
  if acls:
    for acl in acls: 
      if acl.is_default:
        #Default ACL can't be deleted, checking
        print(acl.id + " is the default NACL, continue...")
        continue
      print("Removing acl ", acl.id)
      try: 
        acl.delete()
      except Exception as e:
        print('Cannot delete ACL since it has some dependencies')
      
def delete_sgp(ec2, vpcid):  
  vpc_resource = ec2.Vpc(vpcid)
  sgps = vpc_resource.security_groups.all()
  if sgps:
    for sg in sgps: 
      if sg.group_name == 'default':
        #Default SG can't be deleted
        print(sg.id + " is the default security group, continue...")
        continue
      print("Removing sg ", sg.id)
      try:
        sg.delete()
      except Exception as e:
        print('Cannot delete SG since it has some dependencies')
      
def delete_vpc(ec2, vpcid):
  vpc_resource = ec2.Vpc(vpcid)
  print("Removing VPC ", vpc_resource.id)
  try:
    vpc_resource.delete()
  except Exception as e:
        print('Cannot delete VPC since it has some dependencies')

def start_delete():
    client = boto3.client('ec2')
    accounts = get_accounts()
    
    regions = get_regions(client)
    for account in accounts:
      for region in regions:
        print ("\n\nAccount " + account.name + " region " + region)
        session = assume_role(account.name, account.id, region)                
        ec2 = session.resource('ec2')
        vpcs = get_default_vpcs(session)
        for vpc in vpcs:
          delete_igw(ec2,vpc)
          delete_sub(ec2, vpc)
          delete_rtb(ec2, vpc)
          delete_acl(ec2, vpc)
          delete_sgp(ec2, vpc)
          delete_vpc(ec2, vpc)

if __name__== "__main__":    
    print("***DELETE DEFAULT VPC SCRIPT START***")
    start_time = time.time()
    start_delete()
    print("--- %s seconds ---" % (time.time() - start_time))