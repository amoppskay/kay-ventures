resource "aws_instance" "web" {
  ami = var.AMI-Id
  instance_type = var.Instance-type
  monitoring = true
  ebs_optimized = true

  tags = {
    Name = "kayventure-ec2"
  }
}