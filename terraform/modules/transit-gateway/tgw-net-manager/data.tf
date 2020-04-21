data "template_file" "log_name" {
  template = "${path.module}/output.log"
}

data "local_file" "create_globalnet" {
  filename = data.template_file.log_name.rendered
  depends_on = [null_resource.aws_lz_ena_net_manager]
}