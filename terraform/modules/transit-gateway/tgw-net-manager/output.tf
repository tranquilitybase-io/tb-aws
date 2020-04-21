
output "aws_cli_output" {
  value = data.local_file.create-globalnet.content
}