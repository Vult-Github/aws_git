############  EC2 for Jenkins ###############
data "aws_ami" "EC2_bastion_ami" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "tag:Name"
    values = ["EC2-bastion-*"]
  }
}

resource "aws_instance" "ec2_bastion" {
  ami                         = data.aws_ami.EC2_bastion_ami.id
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = [aws_security_group.sec_group_ec2_bastion.id]
  key_name                    = var.ec2_access_key
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = false
  }
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }
  tags = {
    Name        = "ec2_bastion-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
  }
}



data "aws_ami" "EC2_centre_ami" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "tag:Name"
    values = ["EC2-centreCA-*"]
  }
}

resource "aws_instance" "ec2_centre" {
  ami                         = data.aws_ami.EC2_centre_ami.id
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = [aws_security_group.sec_group_ec2_centre.id]
  key_name                    = var.ec2_inner_key
  associate_public_ip_address = true
  private_ip                  = var.ec2_ca_ip
  lifecycle {
    create_before_destroy = false
  }
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }
  /*
  user_data = <<VULT
#!/bin/bash
ssh-keygen -f "/home/admin/.ssh/known_hosts" -R "172.22.12.42"
VULT
*/
  tags = {
    Name        = "ec2_centre-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
  }
}




############  Security groups ###############
resource "aws_security_group" "sec_group_ec2_bastion" {
  name        = "Secgro_EC2_bastion"
  description = "Bastion"
  vpc_id      = aws_vpc.global_vpc.id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "openVPN"
    from_port   = 1192
    to_port     = 1192
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "Secgro_EC2_bastion"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
  }
}

resource "aws_security_group" "sec_group_ec2_centre" {
  name        = "Secgro_EC2_centre"
  description = "Centre"
  vpc_id      = aws_vpc.global_vpc.id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.subnet_public_cidr}"]
  }
  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "Secgro_EC2_centre"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
  }
}
