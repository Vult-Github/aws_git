resource "aws_instance" "lesson2_ec2_jenkins" {
  ami           = "ami-09a41e26df464c548"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.lesson2_subA.id
  vpc_security_group_ids = [
    aws_security_group.sec_group_subA.id
  ]
  key_name                    = "Test_vult_aws"
  associate_public_ip_address = true
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }

  user_data = <<VULT
#!/bin/bash
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y openjdk-11-jre-headless
sudo apt-get  -y install jenkins
VULT
  tags = {
    Name = "lesson2_ec2_jenkins"
    Type = "EC2"
  }
}
