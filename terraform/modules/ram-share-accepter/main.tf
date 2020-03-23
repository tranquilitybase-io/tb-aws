resource "aws_ram_resource_share_accepter" "receiver_accept" {
  share_arn = var.share-arn
}