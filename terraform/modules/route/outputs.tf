output "custom_route_id" {
  value = concat(aws_route.custom_route.*.id, [""])[0]
  description = "Route Table identifier and destination"
}