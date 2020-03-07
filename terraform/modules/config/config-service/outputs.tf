output "recorder_main"{
    value = aws_config_configuration_recorder.main
}

output "delivery_channel"{
    value = aws_config_delivery_channel.main
}

output "aggregator_role_arn"{
    value = concat(aws_iam_role.aggregator_role.*.arn, [""])[0]
}