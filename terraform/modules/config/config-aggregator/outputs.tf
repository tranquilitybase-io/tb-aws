output "aggregator_name" {
    value = concat(aws_config_configuration_aggregator.organization.*.name, [""])[0]
    description = "Aggregator Name"
}