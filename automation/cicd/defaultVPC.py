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

def start_delete():
    client = boto3.client('ec2')
    regions = get_regions(client)
    for region in regions:
    try:
      client = boto3.client('ec2', region_name = region)
      ec2 = boto3.resource('ec2', region_name = region)
      vpcs = get_default_vpcs(client)

if __name__== "__main__":    
    print("***DELETE DEFAULT VPC SCRIPT START***")
    start_time = time.time()
    start_delete()
    print("--- %s seconds ---" % (time.time() - start_time))