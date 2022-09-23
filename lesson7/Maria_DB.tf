############  RDS ###############
resource "aws_db_subnet_group" "Maria_DB" {
  name       = "mariadb_subgroup"
  subnet_ids = [aws_subnet.subnet_DB_A.id, aws_subnet.subnet_DB_B.id]

  tags = {
    Name        = "DB_subgroup-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "DB subnet group"
    Description = "For DB"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
    Deployner   = "Terraform"
  }
}

resource "aws_db_instance" "MariaDB_instance" {
  allocated_storage           = 20
  max_allocated_storage       = 0
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = false
  db_subnet_group_name        = aws_db_subnet_group.Maria_DB.name
  vpc_security_group_ids      = [aws_security_group.sec_group_mariadb.id]
  backup_retention_period     = 0
  delete_automated_backups    = true
  deletion_protection         = false
  instance_class              = "db.t3.micro"
  monitoring_interval         = 0
  publicly_accessible         = false
  skip_final_snapshot         = true
  engine                      = "mariadb"
  engine_version              = "10.6"
  parameter_group_name        = "default.mariadb10.6"
  option_group_name           = "default:mariadb-10-6"
  db_name                     = "mariadb"
  port                        = var.db_port
  username                    = var.db_admin_name
  password                    = var.db_admin_pass
  tags = {
    Name        = "DB-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "DB MariaDB"
    Description = "DB"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
    Deployner   = "Terraform"
  }
}

############  Security groups ###############
resource "aws_security_group" "sec_group_mariadb" {
  name        = "Secgro_mariadb"
  description = "For jenkins machine"
  vpc_id      = aws_vpc.global_vpc.id
  ingress {
    description = "Mariadb"
    from_port   = var.db_port
    to_port     = var.db_port
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
    Name        = "Secgro_mariadb"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
  }
}
