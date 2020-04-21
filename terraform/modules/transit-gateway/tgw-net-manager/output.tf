
output "aws-cli-output" {
  value = data.local_file.create-globalnet.content
}