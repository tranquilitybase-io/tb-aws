
output "recorder_id"{
    value = concat(aws_config_configuration_recorder.main.*.id, [""])[0]
    description = "Recorder ID"
}

output "recorder_name"{
    value = concat(aws_config_configuration_recorder.main.*.name, [""])[0]
    description = "Recorder name"
}

output "delivery_channel_id"{
    value = concat(aws_config_delivery_channel.main.*.id, [""])[0]
    description = "Delivery Channel ID"
}

output "delivery_channel_name"{
    value = concat(aws_config_delivery_channel.main.*.name, [""])[0]
    description = "Delivery Channel name"
}