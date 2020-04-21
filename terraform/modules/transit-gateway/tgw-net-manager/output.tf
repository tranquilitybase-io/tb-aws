
output "aws_cli_output" {
  description = "Output string with the information of Global Network"
  value = data.local_file.create_globalnet.content
}