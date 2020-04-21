
output "globalnet_json_output" {
  description = "Output string with the information of Global Network"
  value = jsondecode(data.local_file.create_globalnet.content)
}