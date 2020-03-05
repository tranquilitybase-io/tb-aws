resource "aws_instance" "ec2" {
  ami           = var.aws_ec2_ami
  instance_type = var.aws_ec2_instance_type

  tags = {
    Name = "HelloWorld2"
  }
}