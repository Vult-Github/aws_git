resource "aws_instance" "test_ec2" {
  ami           = "ami-09a41e26df464c548"
  instance_type = "t2.micro"
}
