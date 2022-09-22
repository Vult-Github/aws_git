/*
############  EC2 for Jenkins ###############
data "aws_ami" "EC2_ami" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "tag:Name"
    values = ["EC2-bastion-*"]
  }
}

resource "aws_instance" "ec2_bastion" {
  depends_on                  = [aws_db_instance.MariaDB_instance]
  ami                         = data.aws_ami.EC2_ami.id
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.subnet_bastion.id
  vpc_security_group_ids      = [aws_security_group.sec_group_ec2_bastion.id]
  key_name                    = var.ec2_access_key
  associate_public_ip_address = true
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
  user_data = <<VULT
#!/bin/bash
echo "alias prodmaria='mysql --user=${var.db_admin_name} --host=${aws_db_instance.MariaDB_instance.address} --port=${var.db_port} -p'" >> /home/admin/.bashrc
VULT
}



############  Security groups ###############
resource "aws_security_group" "sec_group_ec2_bastion" {
  name        = "Secgro_EC2_bastion"
  description = "For jenkins machine"
  vpc_id      = aws_vpc.global_vpc.id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
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
*/
