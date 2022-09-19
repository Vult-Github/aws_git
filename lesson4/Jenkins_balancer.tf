############  Security groups ###############
resource "aws_security_group" "sec_group_subnet_jenkins" {
  name        = "EC2_jenkins"
  description = "For jenkins machine"
  vpc_id      = aws_vpc.global_vpc.id
  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
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
    Name        = "SecGro-Jenkins-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "Security group"
    Description = "For Jenkins EC2"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
    Deployner   = "Terraform"
  }
}

resource "aws_security_group" "sec_group_loadbalancer_jenkins" {
  name        = "Loadbalancer_jenkins"
  description = "For jenkins loadbalancer"
  vpc_id      = aws_vpc.global_vpc.id
  ingress {
    description = "Jenkins"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
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
    Name        = "SecGro-Jenkins-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "Security group"
    Description = "For Jenkins Loadbalancer"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
    Deployner   = "Terraform"
  }
}



############  Autoscaling Group + Launch configuration ###############
data "aws_ami" "EC2_ami" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "tag:Name"
    values = ["EC2-jenkins-*"]
  }
}



resource "aws_launch_configuration" "Launch_config_Jenkins" {
  name          = "Launch-Conf-Jenkins-${var.projectname}${var.lesson_number}-${var.environment_type}"
  image_id      = data.aws_ami.EC2_ami.id
  instance_type = "t2.micro"
  key_name      = var.ec2_access_key
  security_groups = [
    aws_security_group.sec_group_subnet_jenkins.id
  ]
  associate_public_ip_address = false
  enable_monitoring           = false
}



resource "aws_autoscaling_group" "Autoscaling_gr_Jenkins" {
  name                      = "Autoscale-Conf-Jenkins${var.projectname}${var.lesson_number}-${var.environment_type}"
  launch_configuration      = aws_launch_configuration.Launch_config_Jenkins.name
  vpc_zone_identifier       = [aws_subnet.subnetA.id, aws_subnet.subnetB.id]
  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "EC2"
  target_group_arns         = [aws_lb_target_group.Target_group_jenkins.arn]
  tag {
    key                 = "Name"
    value               = "EC2-Jenkins-${var.projectname}${var.lesson_number}-${var.environment_type}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Description"
    value               = "For Jenkins"
    propagate_at_launch = true
  }
  tag {
    key                 = "Deployner"
    value               = "Terraform + autoscaling"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}



############  Target group ###############
resource "aws_lb_target_group" "Target_group_jenkins" {
  name        = "Target-gr-Jenkins-${var.projectname}${var.lesson_number}-${var.environment_type}"
  target_type = "instance"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.global_vpc.id
  health_check {
    enabled           = true
    healthy_threshold = 3
    interval          = 30
    protocol          = "HTTP"
    port              = 8080
    path              = "/"
    matcher           = "403"
  }
}



############  Load balancer ###############
resource "aws_lb" "Load_balancer_jenkins" {
  name               = "Loadbalan-Jenkins-${var.projectname}${var.lesson_number}-${var.environment_type}"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sec_group_loadbalancer_jenkins.id]
  subnets            = [aws_subnet.subnetA.id, aws_subnet.subnetB.id]
  tags = {
    Name        = "Loadbalan-Jenkins-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "Load balancer"
    Purpose     = "For Jenkins"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
    Deployner   = "Terraform"
  }
}


resource "aws_lb_listener" "Listener_jenkins" {
  load_balancer_arn = aws_lb.Load_balancer_jenkins.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Target_group_jenkins.arn
  }

}
