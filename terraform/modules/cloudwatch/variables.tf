variable "event_name"{
    description = "Cloudwatch event name"
}

variable "event_description"{
    description = "Event description"
}

variable "event_pattern"{
    description = "Event pattern to be recorded"
}

variable "target_arn"{
    description = "ARN associated to the event target"
}