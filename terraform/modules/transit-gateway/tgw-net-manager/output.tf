data "template_file" "log_name" {
  template = "./modules/transit-gateway/tgw-net-manager/output.log"
}

data "local_file" "create-globalnet" {
  filename = data.template_file.log_name.rendered
  depends_on = [null_resource.aws_lz_ena_net_manager]
}

output "aws-cli-output" {
  value = data.local_file.create-globalnet.content
}