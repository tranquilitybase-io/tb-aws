output "recorder_main"{
    value = aws_config_configuration_recorder.main
}

output "delivery_channel"{
    value = aws_config_delivery_channel.main
}
