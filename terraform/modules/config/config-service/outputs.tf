
output "recorder_id"{
    value = concat(aws_config_configuration_recorder.main.*.id, [""])[0]
}

output "recorder_name"{
    value = concat(aws_config_configuration_recorder.main.*.name, [""])[0]
}

output "delivery_channel_id"{
    value = concat(aws_config_delivery_channel.main.*.id, [""])[0]
}

output "delivery_channel_name"{
    value = concat(aws_config_delivery_channel.main.*.name, [""])[0]
}