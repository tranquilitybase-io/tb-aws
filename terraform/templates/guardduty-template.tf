module "aws_lz_guardduty_master" {
  source = "./templates/modules/guard-duty"
  enable = var.enable_detector
  finding_publishing_frequency = var.cloudwatch_notify_frecuency
  invite = var.invite_members
  invitation_message = var.member_invite_message 
  disable_email_notification =- var.disable_email_notification
}
  #invite

  /*
  detector_id = aws_guardduty_detector.detector.id
  account_id = 
  email = 
  invite = var.invite_members
  invitation_message = var.member_invite_message
  disable_email_notification = var.disable_email_notification
}
/*

/*module "aws_lz_guardduty_member" {
  source = "./templates/modules/guard-duty"
  enable = var.enable_detector
  finding_publishing_frequency = var.cloudwatch_notify_frecuency
}

module "aws_lz_guardduty_invite_accepter" {
  source = "./templates/modules/guard-duty"
  count = var.auto_accept_invites == true ? 1 : 0
  
  master_account_id=
  
}
*/