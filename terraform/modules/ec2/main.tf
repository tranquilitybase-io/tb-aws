resource "aws_instance" "instances" {
  ami           = var.ami_version
  instance_type = var.instance_type

  tags = {
    Name = "test"
  }
}