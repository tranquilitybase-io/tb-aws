data "template_file" "log_name" {
  template = "${path.module}/output.json"
}

data "local_file" "create-globalnet" {
  filename = data.template_file.log_name.rendered
  depends_on = [null_resource.aws_lz_ena_net_manager]
}