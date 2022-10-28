resource "aws_instance" "web" {
  ami = var.AMI-Id
  instance_type = var.Instance-type

  tags = {
    Name = "kayventure-ec2"
  }
}