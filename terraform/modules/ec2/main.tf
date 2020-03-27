resource "aws_instance" "instances" {
  ami           = var.ami_version
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = {
    Name = "Ubuntu"
  }
}